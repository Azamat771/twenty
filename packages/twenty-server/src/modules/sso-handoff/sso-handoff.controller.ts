// SSO-handoff контроллер для форка ru-translations.
// Выдаёт short-lived JWT (HS256, exp 5 мин), которым внешний UI
// (crm-hooks.center-guarantee.ru) узнаёт текущего пользователя Twenty.
// Подпись — общий секрет process.env.WEBHOOK_SECRET с crm-hooks.

import {
  BadRequestException,
  Body,
  Controller,
  Post,
  UseGuards,
} from '@nestjs/common';

import * as jwt from 'jsonwebtoken';
import { isDefined } from 'twenty-shared/utils';

import { AuthUser } from 'src/engine/decorators/auth/auth-user.decorator';
import { AuthWorkspace } from 'src/engine/decorators/auth/auth-workspace.decorator';
import { JwtAuthGuard } from 'src/engine/guards/jwt-auth.guard';
import { WorkspaceAuthGuard } from 'src/engine/guards/workspace-auth.guard';
import { type WorkspaceEntity } from 'src/engine/core-modules/workspace/workspace.entity';
import { type UserEntity } from 'src/engine/core-modules/user/user.entity';
import { UserService } from 'src/engine/core-modules/user/services/user.service';

type SsoHandoffBody = {
  redirectUri: string;
};

type SsoHandoffResponse = {
  ssoToken: string;
  redirectUri: string;
};

@Controller('api/sso')
@UseGuards(JwtAuthGuard, WorkspaceAuthGuard)
export class SsoHandoffController {
  constructor(private readonly userService: UserService) {}

  @Post('handoff')
  async handoff(
    @AuthUser() user: UserEntity,
    @AuthWorkspace() workspace: WorkspaceEntity,
    @Body() body: SsoHandoffBody,
  ): Promise<SsoHandoffResponse> {
    const redirectUri = body?.redirectUri;

    if (!isDefined(redirectUri) || typeof redirectUri !== 'string') {
      throw new BadRequestException('redirectUri is required');
    }

    const whitelistRaw = process.env.SSO_HANDOFF_WHITELIST ?? '';
    const whitelist = whitelistRaw
      .split(',')
      .map((item) => item.trim())
      .filter((item) => item.length > 0);

    if (whitelist.length === 0 || !whitelist.includes(redirectUri)) {
      throw new BadRequestException('redirectUri not allowed');
    }

    const secret = process.env.WEBHOOK_SECRET;

    if (!isDefined(secret) || secret.length === 0) {
      throw new BadRequestException('WEBHOOK_SECRET is not configured');
    }

    const workspaceMember = await this.userService.loadWorkspaceMember(
      user,
      workspace,
    );

    if (!isDefined(workspaceMember)) {
      throw new BadRequestException('workspace member not found');
    }

    const memberName =
      [workspaceMember.name?.firstName, workspaceMember.name?.lastName]
        .filter((part) => isDefined(part) && part.length > 0)
        .join(' ')
        .trim() || user.email;

    const now = Math.floor(Date.now() / 1000);

    const payload = {
      sub: workspaceMember.id,
      workspaceMemberId: workspaceMember.id,
      workspaceId: workspace.id,
      email: user.email,
      name: memberName,
      iat: now,
      exp: now + 300,
    };

    const ssoToken = jwt.sign(payload, secret, { algorithm: 'HS256' });

    return { ssoToken, redirectUri };
  }
}

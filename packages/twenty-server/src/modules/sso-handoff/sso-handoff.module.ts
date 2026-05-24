// Модуль SSO-handoff (форк ru-translations).
// Регистрирует контроллер api/sso/handoff. Зависимости:
// - UserModule — UserService.loadWorkspaceMember.
// - TokenModule — экспортирует AccessTokenService, нужный JwtAuthGuard
//   (без него Nest падает с UnknownDependenciesException при старте).

import { Module } from '@nestjs/common';

import { TokenModule } from 'src/engine/core-modules/auth/token/token.module';
import { UserModule } from 'src/engine/core-modules/user/user.module';
import { SsoHandoffController } from 'src/modules/sso-handoff/sso-handoff.controller';

@Module({
  imports: [UserModule, TokenModule],
  controllers: [SsoHandoffController],
})
export class SsoHandoffModule {}

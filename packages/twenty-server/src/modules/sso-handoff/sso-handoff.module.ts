// Модуль SSO-handoff (форк ru-translations).
// Регистрирует контроллер api/sso/handoff и подключает UserModule,
// чтобы получить доступ к UserService.loadWorkspaceMember.

import { Module } from '@nestjs/common';

import { UserModule } from 'src/engine/core-modules/user/user.module';
import { SsoHandoffController } from 'src/modules/sso-handoff/sso-handoff.controller';

@Module({
  imports: [UserModule],
  controllers: [SsoHandoffController],
})
export class SsoHandoffModule {}

export enum AppPath {
  // Not logged-in
  Verify = '/verify',
  VerifyEmail = '/verify-email',
  SignInUp = '/welcome',
  Invite = '/invite/:workspaceInviteHash',
  ResetPassword = '/reset-password/:passwordResetToken',

  // Onboarding
  CreateWorkspace = '/create/workspace',
  CreateProfile = '/create/profile',
  SyncEmails = '/sync/emails',
  InviteTeam = '/invite-team',
  PlanRequired = '/plan-required',
  PlanRequiredSuccess = '/plan-required/payment-success',
  BookCallDecision = '/book-call-decision',
  BookCall = '/book-call',

  // Onboarded
  Index = '/',
  TasksPage = '/objects/tasks',
  OpportunitiesPage = '/objects/opportunities',

  RecordIndexPage = '/objects/:objectNamePlural',
  RecordShowPage = '/object/:objectNameSingular/:objectRecordId',
  PageLayoutPage = '/page/:pageLayoutId',

  // Форк ru-translations: iframe-страницы внешнего email-UI (crm-hooks).
  EmailInbox = '/email/inbox',
  EmailSettings = '/email/settings',

  Settings = `settings`,
  SettingsCatchAll = `/${Settings}/*`,
  Developers = `developers`,
  DevelopersCatchAll = `/${Developers}/*`,

  Authorize = '/authorize',

  // 404 page not found
  NotFoundWildcard = '*',
  NotFound = '/not-found',
}

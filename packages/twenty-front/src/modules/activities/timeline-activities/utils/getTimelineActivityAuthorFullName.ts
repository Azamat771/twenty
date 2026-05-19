import { type TimelineActivity } from '@/activities/timeline-activities/types/TimelineActivity';
import { type CurrentWorkspaceMember } from '@/auth/states/currentWorkspaceMemberState';
import { isDefined } from 'twenty-shared/utils';

// [ru-fork] Always show full name (firstName + lastName) instead of 'You'.
// Reasoning: in a team workspace seeing "You обновили..." is confusing for
// admins reviewing what others did. Names always read unambiguously.
// currentWorkspaceMember kept in signature for upstream-merge friendliness.
export const getTimelineActivityAuthorFullName = (
  event: TimelineActivity,
  // eslint-disable-next-line @typescript-eslint/no-unused-vars
  currentWorkspaceMember: CurrentWorkspaceMember,
) => {
  if (isDefined(event.workspaceMember)) {
    const firstName = event.workspaceMember?.name?.firstName ?? '';
    const lastName = event.workspaceMember?.name?.lastName ?? '';
    return `${firstName} ${lastName}`.trim() || 'Система';
  }
  return 'Система';
};

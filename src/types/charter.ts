export type StatusType = 'Not Started' | 'In Progress' | 'Under Review' | 'Completed' | 'Deferred';

export interface Responsibility {
  id: string;
  title: string;
  category: 'Governance' | 'Business' | 'Philanthropy' | 'Estate & Wealth' | 'Family Office';
  owner: string; // empty string highlights unassigned
  adviser: string;
  dueDate: string; // YYYY-MM-DD
  status: StatusType;
  description: string;
}

export interface DecisionOption {
  id: string;
  title: string;
  pros: string;
  cons: string;
}

export interface Decision {
  id: string;
  title: string;
  question: string;
  month: string; // e.g. "2026-06" or "June 2026"
  owner: string;
  deadline: string; // YYYY-MM-DD
  options: DecisionOption[];
  outcome?: string;
  reviewDate?: string;
  status: 'Pending' | 'Under Discussion' | 'Decided' | 'Completed';
}

export interface GivingRecord {
  id: string;
  organization: string;
  familyInterest: string;
  assessment: string;
  proposedGift: string;
  decisionStatus: 'Proposed' | 'Approved' | 'Declined' | 'Pledged' | 'Paid';
  pledgeFollowUp: string; // YYYY-MM-DD or note
  focusArea: 'Arts & Culture' | 'Education' | 'Medical Research' | 'Community & Civic';
}

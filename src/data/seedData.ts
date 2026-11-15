import { Responsibility, Decision, GivingRecord } from '../types/charter';

export const INITIAL_RESPONSIBILITIES: Responsibility[] = [
  {
    id: 'resp-1',
    title: 'River Oaks & Aspen Property Insurance Renewal',
    category: 'Estate & Wealth',
    owner: 'Julian Ashford',
    adviser: 'Marsh McLennan / Sarah Jenkins',
    dueDate: '2026-07-15',
    status: 'In Progress',
    description: 'Annual review and renewal of high-value homeowners and umbrella liability policies for Houston and Aspen residences.'
  },
  {
    id: 'resp-2',
    title: 'Ashford Family Foundation Annual Grantee Audit',
    category: 'Philanthropy',
    owner: '', // Unassigned to highlight warning
    adviser: 'BDO USA / CPA',
    dueDate: '2026-08-30',
    status: 'Not Started',
    description: 'Review compliance and impact reports for Tier-1 foundation beneficiaries across Texas.'
  },
  {
    id: 'resp-3',
    title: 'Ashford Energy Holdings Q2 Board Governance Packet',
    category: 'Business',
    owner: 'Arthur Ashford',
    adviser: 'Vinson & Elkins LLP',
    dueDate: '2026-06-20',
    status: 'Under Review',
    description: 'Prepare governance materials, voting proxies, and generational transition updates for operating board.'
  },
  {
    id: 'resp-4',
    title: 'Post-War Art Collection Insurance & Conservation Check',
    category: 'Estate & Wealth',
    owner: 'Maya Ashford',
    adviser: 'Axa Art / Conservator Dr. Vance',
    dueDate: '2026-09-10',
    status: 'Not Started',
    description: 'Biennial physical inspection of Rothko and Diebenkorn canvases stored in Houston climate-controlled facility.'
  },
  {
    id: 'resp-5',
    title: 'Family Council Charter & Next-Gen Onboarding Update',
    category: 'Governance',
    owner: 'Eleanor Ashford',
    adviser: 'Fiduciary Trust',
    dueDate: '2026-07-01',
    status: 'In Progress',
    description: 'Refining voting thresholds and educational requirements for grandchildren turning 25.'
  }
];

export const INITIAL_DECISIONS: Decision[] = [
  {
    id: 'dec-1',
    title: 'Museum Loan Agreement: Rothko Retrospective',
    question: 'Should the foundation approve the 12-month museum loan of Untitled (Red & Ochre, 1961) to the Museum of Fine Arts, Houston?',
    month: 'June 2026',
    owner: 'Maya Ashford',
    deadline: '2026-06-28',
    status: 'Under Discussion',
    options: [
      { id: 'opt-1', title: 'Approve full 12-month loan with courier terms', pros: 'Strengthens institutional ties; enhanced public provenance.', cons: 'Removes piece from primary residence; transit insurance overhead.' },
      { id: 'opt-2', title: 'Limit loan to 6 months', pros: 'Reduces exposure duration while supporting local institution.', cons: 'Museum exhibition scheduling constraints.' },
      { id: 'opt-3', title: 'Decline loan request', pros: 'Zero risk of transit damage or climate fluctuation.', cons: 'Misses community engagement opportunity.' }
    ],
    outcome: '',
    reviewDate: '2026-06-25'
  },
  {
    id: 'dec-2',
    title: 'Ashford Family Foundation Clean Energy Initiative',
    question: 'Authorize a $2.5M multi-year matching grant for Texas Gulf Coast carbon capture research?',
    month: 'July 2026',
    owner: 'Julian Ashford',
    deadline: '2026-07-20',
    status: 'Pending',
    options: [
      { id: 'opt-1', title: 'Fund full $2.5M over 3 years', pros: 'Aligns foundation mission with regional environmental innovation.', cons: 'Substantial drawdown on annual corpus.' },
      { id: 'opt-2', title: 'Approve $1.0M phased pilot grant', pros: 'Tests research efficacy before full commitment.', cons: 'Slower initial deployment.' }
    ]
  },
  {
    id: 'dec-3',
    title: 'Aspen Estate Solar & Geothermal Retrofit',
    question: 'Proceed with the architectural and engineering overhaul for net-zero energy independence at the Aspen residence?',
    month: 'August 2026',
    owner: 'Eleanor Ashford',
    deadline: '2026-08-15',
    status: 'Pending',
    options: [
      { id: 'opt-1', title: 'Full retrofit (Solar + Geothermal)', pros: 'Long-term operational cost reduction and sustainability.', cons: 'High upfront capital expenditure and construction window.' },
      { id: 'opt-2', title: 'Solar array only', pros: 'Lower disruption and quicker payback period.', cons: 'Does not fully eliminate winter heating reliance.' }
    ]
  }
];

export const INITIAL_GIVING: GivingRecord[] = [
  {
    id: 'giv-1',
    organization: 'Museum of Fine Arts, Houston (MFAH)',
    familyInterest: 'Access for local students & contemporary art preservation.',
    assessment: 'Tier-1 relationship. Long-standing family trustee history.',
    proposedGift: '$500,000 (Endowed Education Gallery)',
    decisionStatus: 'Approved',
    pledgeFollowUp: '2026-09-01 (Wire transfer scheduled)',
    focusArea: 'Arts & Culture'
  },
  {
    id: 'giv-2',
    organization: 'Texas Medical Center Research Institute',
    familyInterest: 'Cardiovascular research and genomic medicine fellowships.',
    assessment: 'High impact potential; aligns with family medical legacy.',
    proposedGift: '$1,000,000 (Research Chair Endowment)',
    decisionStatus: 'Pledged',
    pledgeFollowUp: '2026-11-15 (Annual installment)',
    focusArea: 'Medical Research'
  },
  {
    id: 'giv-3',
    organization: 'Houston Food Bank - Capital Campaign',
    familyInterest: 'Regional food security and community resilience.',
    assessment: 'Essential regional infrastructure support.',
    proposedGift: '$250,000 (Direct Impact Fund)',
    decisionStatus: 'Paid',
    pledgeFollowUp: 'Completed (Receipt on file)',
    focusArea: 'Community & Civic'
  }
];

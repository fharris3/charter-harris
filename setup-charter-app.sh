#!/usr/bin/env bash
set -e

# Ensure directory structure exists inside charter-harris-office
mkdir -p src/{types,data,hooks,components}

# 1. Domain Types (src/types/charter.ts)
cat << 'EOF' > src/types/charter.ts
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
EOF

# 2. Seed Data (src/data/seedData.ts)
cat << 'EOF' > src/data/seedData.ts
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
EOF

# 3. Store Hook (src/hooks/useCharterStore.ts)
cat << 'EOF' > src/hooks/useCharterStore.ts
import { useState, useEffect } from 'react';
import { Responsibility, Decision, GivingRecord } from '../types/charter';
import { INITIAL_RESPONSIBILITIES, INITIAL_DECISIONS, INITIAL_GIVING } from '../data/seedData';

const STORAGE_KEY_RESP = 'charter_responsibilities_v1';
const STORAGE_KEY_DEC = 'charter_decisions_v1';
const STORAGE_KEY_GIV = 'charter_giving_v1';

export function useCharterStore() {
  const [responsibilities, setResponsibilities] = useState<Responsibility[]>(() => {
    const saved = localStorage.getItem(STORAGE_KEY_RESP);
    return saved ? JSON.parse(saved) : INITIAL_RESPONSIBILITIES;
  });

  const [decisions, setDecisions] = useState<Decision[]>(() => {
    const saved = localStorage.getItem(STORAGE_KEY_DEC);
    return saved ? JSON.parse(saved) : INITIAL_DECISIONS;
  });

  const [giving, setGiving] = useState<GivingRecord[]>(() => {
    const saved = localStorage.getItem(STORAGE_KEY_GIV);
    return saved ? JSON.parse(saved) : INITIAL_GIVING;
  });

  const [toastMessage, setToastMessage] = useState<string | null>(null);

  useEffect(() => {
    localStorage.setItem(STORAGE_KEY_RESP, JSON.stringify(responsibilities));
  }, [responsibilities]);

  useEffect(() => {
    localStorage.setItem(STORAGE_KEY_DEC, JSON.stringify(decisions));
  }, [decisions]);

  useEffect(() => {
    localStorage.setItem(STORAGE_KEY_GIV, JSON.stringify(giving));
  }, [giving]);

  const showToast = (msg: string) => {
    setToastMessage(msg);
    setTimeout(() => setToastMessage(null), 3500);
  };

  const resetDemoData = () => {
    setResponsibilities(INITIAL_RESPONSIBILITIES);
    setDecisions(INITIAL_DECISIONS);
    setGiving(INITIAL_GIVING);
    showToast('Demo data reset to Ashford family defaults.');
  };

  const saveResponsibility = (item: Responsibility) => {
    setResponsibilities(prev => {
      const exists = prev.some(r => r.id === item.id);
      if (exists) {
        showToast('Responsibility updated successfully.');
        return prev.map(r => r.id === item.id ? item : r);
      } else {
        showToast('New responsibility added.');
        return [item, ...prev];
      }
    });
  };

  const saveDecision = (item: Decision) => {
    setDecisions(prev => {
      const exists = prev.some(d => d.id === item.id);
      if (exists) {
        showToast('Decision record updated.');
        return prev.map(d => d.id === item.id ? item : d);
      } else {
        showToast('New decision created.');
        return [item, ...prev];
      }
    });
  };

  const completeDecision = (id: string) => {
    setDecisions(prev => prev.map(d => {
      if (d.id === id) {
        const nextStatus = d.status === 'Completed' ? 'Decided' : 'Completed';
        showToast(`Decision marked as ${nextStatus}.`);
        return { ...d, status: nextStatus };
      }
      return d;
    }));
  };

  const saveGiving = (item: GivingRecord) => {
    setGiving(prev => {
      const exists = prev.some(g => g.id === item.id);
      if (exists) {
        showToast('Charitable organization record updated.');
        return prev.map(g => g.id === item.id ? item : g);
      } else {
        showToast('New charitable record added.');
        return [item, ...prev];
      }
    });
  };

  return {
    responsibilities,
    decisions,
    giving,
    toastMessage,
    saveResponsibility,
    saveDecision,
    completeDecision,
    saveGiving,
    resetDemoData
  };
}
EOF

# 4. Responsibilities Component (src/components/ResponsibilitiesSection.tsx)
cat << 'EOF' > src/components/ResponsibilitiesSection.tsx
import React, { useState } from 'react';
import { Responsibility } from '../types/charter';
import { Plus, Edit3, AlertCircle, CheckCircle2, Clock, ShieldAlert } from 'lucide-react';

interface Props {
  data: Responsibility[];
  onSave: (item: Responsibility) => void;
}

export const ResponsibilitiesSection: React.FC<Props> = ({ data, onSave }) => {
  const [filterCategory, setFilterCategory] = useState<string>('All');
  const [editingItem, setEditingItem] = useState<Responsibility | null>(null);
  const [isModalOpen, setIsModalOpen] = useState(false);

  const categories = ['All', 'Governance', 'Business', 'Philanthropy', 'Estate & Wealth', 'Family Office'];

  const filteredData = filterCategory === 'All' 
    ? data 
    : data.filter(d => d.category === filterCategory);

  const handleOpenAdd = () => {
    setEditingItem({
      id: `resp-${Date.now()}`,
      title: '',
      category: 'Governance',
      owner: '',
      adviser: '',
      dueDate: new Date().toISOString().split('T')[0],
      status: 'Not Started',
      description: ''
    });
    setIsModalOpen(true);
  };

  const handleOpenEdit = (item: Responsibility) => {
    setEditingItem({ ...item });
    setIsModalOpen(true);
  };

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    if (!editingItem || !editingItem.title.trim()) return;
    onSave(editingItem);
    setIsModalOpen(false);
    setEditingItem(null);
  };

  const unassignedCount = data.filter(d => !d.owner.trim()).length;

  return (
    <section className="space-y-6">
      <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4 bg-white p-6 rounded-xl border border-[#E4DFD5] shadow-sm">
        <div>
          <div className="flex items-center gap-3">
            <h2 className="text-2xl font-editorial font-medium text-[#5C1D2A]">Governance Responsibilities</h2>
            {unassignedCount > 0 && (
              <span className="inline-flex items-center gap-1.5 px-3 py-1 bg-[#F7EFF1] text-[#5C1D2A] text-xs font-medium rounded-full border border-[#5C1D2A]/20">
                <ShieldAlert className="w-3.5 h-3.5" />
                {unassignedCount} Unassigned
              </span>
            )}
          </div>
          <p className="text-sm text-[#5E5A54] mt-1">
            Track accountability, advisory support, and completion deadlines across family office domains.
          </p>
        </div>
        <button
          onClick={handleOpenAdd}
          className="flex items-center gap-2 bg-[#5C1D2A] hover:bg-[#7A2838] text-white px-4 py-2.5 rounded-lg text-sm font-medium transition shadow-sm"
        >
          <Plus className="w-4 h-4" />
          Add Responsibility
        </button>
      </div>

      {/* Category Filter Pills */}
      <div className="flex flex-wrap gap-2">
        {categories.map(cat => (
          <button
            key={cat}
            onClick={() => setFilterCategory(cat)}
            className={`px-3.5 py-1.5 rounded-lg text-xs font-medium transition ${
              filterCategory === cat
                ? 'bg-[#4A609A] text-white shadow-sm'
                : 'bg-white text-[#5E5A54] border border-[#E4DFD5] hover:border-[#4A609A]'
            }`}
          >
            {cat}
          </button>
        ))}
      </div>

      {/* Table */}
      <div className="bg-white rounded-xl border border-[#E4DFD5] shadow-sm overflow-hidden">
        <div className="overflow-x-auto">
          <table className="w-full text-left border-collapse">
            <thead>
              <tr className="bg-[#FAF8F4] border-b border-[#E4DFD5] text-xs font-semibold text-[#5E5A54] uppercase tracking-wider">
                <th className="p-4">Responsibility & Domain</th>
                <th className="p-4">Owner</th>
                <th className="p-4">Adviser</th>
                <th className="p-4">Due Date</th>
                <th className="p-4">Status</th>
                <th className="p-4 text-right">Actions</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-[#E4DFD5] text-sm">
              {filteredData.length === 0 ? (
                <tr>
                  <td colSpan={6} className="p-8 text-center text-[#8C867D]">
                    No responsibilities found in this category.
                  </td>
                </tr>
              ) : (
                filteredData.map(item => {
                  const isUnassigned = !item.owner.trim();
                  return (
                    <tr 
                      key={item.id} 
                      className={`transition hover:bg-[#FAF8F4]/60 ${isUnassigned ? 'bg-[#F7EFF1]/40' : ''}`}
                    >
                      <td className="p-4 max-w-xs">
                        <div className="font-medium text-[#1F1E1C]">{item.title}</div>
                        <div className="text-xs text-[#5E5A54] mt-0.5 line-clamp-1">{item.description}</div>
                        <span className="inline-block mt-1 text-[10px] px-2 py-0.5 bg-[#EEF2FA] text-[#4A609A] rounded font-medium">
                          {item.category}
                        </span>
                      </td>
                      <td className="p-4">
                        {isUnassigned ? (
                          <span className="inline-flex items-center gap-1 text-xs font-semibold text-[#5C1D2A] bg-[#F7EFF1] px-2.5 py-1 rounded-md border border-[#5C1D2A]/20">
                            <AlertCircle className="w-3.5 h-3.5" />
                            Needs Owner
                          </span>
                        ) : (
                          <span className="font-medium text-[#1F1E1C]">{item.owner}</span>
                        )}
                      </td>
                      <td className="p-4 text-[#5E5A54]">{item.adviser || '—'}</td>
                      <td className="p-4 text-[#5E5A54] font-mono text-xs">{item.dueDate}</td>
                      <td className="p-4">
                        <span className={`inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full text-xs font-medium ${
                          item.status === 'Completed' ? 'bg-emerald-50 text-emerald-700 border border-emerald-200' :
                          item.status === 'In Progress' ? 'bg-[#EEF2FA] text-[#4A609A]' :
                          item.status === 'Under Review' ? 'bg-amber-50 text-amber-700' :
                          'bg-[#FAF8F4] text-[#5E5A54] border border-[#E4DFD5]'
                        }`}>
                          {item.status === 'Completed' && <CheckCircle2 className="w-3 h-3" />}
                          {item.status === 'In Progress' && <Clock className="w-3 h-3" />}
                          {item.status}
                        </span>
                      </td>
                      <td className="p-4 text-right">
                        <button
                          onClick={() => handleOpenEdit(item)}
                          className="p-1.5 text-[#5E5A54] hover:text-[#5C1D2A] hover:bg-[#FAF8F4] rounded-lg transition"
                          title="Edit Responsibility"
                        >
                          <Edit3 className="w-4 h-4" />
                        </button>
                      </td>
                    </tr>
                  );
                })
              )}
            </tbody>
          </table>
        </div>
      </div>

      {/* Modal for Add / Edit */}
      {isModalOpen && editingItem && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/40 backdrop-blur-sm p-4">
          <div className="bg-white rounded-2xl max-w-lg w-full p-6 shadow-xl border border-[#E4DFD5] space-y-6 animate-in fade-in zoom-in-95">
            <div className="flex justify-between items-center border-b border-[#E4DFD5] pb-4">
              <h3 className="text-xl font-editorial font-medium text-[#5C1D2A]">
                {data.some(d => d.id === editingItem.id) ? 'Edit Responsibility' : 'Add Responsibility'}
              </h3>
              <button 
                onClick={() => setIsModalOpen(false)}
                className="text-[#8C867D] hover:text-[#1F1E1C] text-lg font-bold px-2"
              >
                &times;
              </button>
            </div>

            <form onSubmit={handleSubmit} className="space-y-4">
              <div>
                <label className="block text-xs font-semibold text-[#5E5A54] uppercase tracking-wider mb-1">Title *</label>
                <input
                  type="text"
                  required
                  value={editingItem.title}
                  onChange={e => setEditingItem({ ...editingItem, title: e.target.value })}
                  className="w-full px-3 py-2 border border-[#E4DFD5] rounded-lg text-sm focus:outline-none focus:border-[#4A609A]"
                  placeholder="e.g. Annual Trust Review"
                />
              </div>

              <div className="grid grid-cols-2 gap-4">
                <div>
                  <label className="block text-xs font-semibold text-[#5E5A54] uppercase tracking-wider mb-1">Category</label>
                  <select
                    value={editingItem.category}
                    onChange={e => setEditingItem({ ...editingItem, category: e.target.value as any })}
                    className="w-full px-3 py-2 border border-[#E4DFD5] rounded-lg text-sm bg-white focus:outline-none focus:border-[#4A609A]"
                  >
                    <option value="Governance">Governance</option>
                    <option value="Business">Business</option>
                    <option value="Philanthropy">Philanthropy</option>
                    <option value="Estate & Wealth">Estate & Wealth</option>
                    <option value="Family Office">Family Office</option>
                  </select>
                </div>
                <div>
                  <label className="block text-xs font-semibold text-[#5E5A54] uppercase tracking-wider mb-1">Status</label>
                  <select
                    value={editingItem.status}
                    onChange={e => setEditingItem({ ...editingItem, status: e.target.value as any })}
                    className="w-full px-3 py-2 border border-[#E4DFD5] rounded-lg text-sm bg-white focus:outline-none focus:border-[#4A609A]"
                  >
                    <option value="Not Started">Not Started</option>
                    <option value="In Progress">In Progress</option>
                    <option value="Under Review">Under Review</option>
                    <option value="Completed">Completed</option>
                    <option value="Deferred">Deferred</option>
                  </select>
                </div>
              </div>

              <div className="grid grid-cols-2 gap-4">
                <div>
                  <label className="block text-xs font-semibold text-[#5E5A54] uppercase tracking-wider mb-1">Owner (Leave blank if unassigned)</label>
                  <input
                    type="text"
                    value={editingItem.owner}
                    onChange={e => setEditingItem({ ...editingItem, owner: e.target.value })}
                    className="w-full px-3 py-2 border border-[#E4DFD5] rounded-lg text-sm focus:outline-none focus:border-[#4A609A]"
                    placeholder="e.g. Julian Ashford"
                  />
                </div>
                <div>
                  <label className="block text-xs font-semibold text-[#5E5A54] uppercase tracking-wider mb-1">Adviser / Firm</label>
                  <input
                    type="text"
                    value={editingItem.adviser}
                    onChange={e => setEditingItem({ ...editingItem, adviser: e.target.value })}
                    className="w-full px-3 py-2 border border-[#E4DFD5] rounded-lg text-sm focus:outline-none focus:border-[#4A609A]"
                    placeholder="e.g. Vinson & Elkins"
                  />
                </div>
              </div>

              <div>
                <label className="block text-xs font-semibold text-[#5E5A54] uppercase tracking-wider mb-1">Due Date</label>
                <input
                  type="date"
                  value={editingItem.dueDate}
                  onChange={e => setEditingItem({ ...editingItem, dueDate: e.target.value })}
                  className="w-full px-3 py-2 border border-[#E4DFD5] rounded-lg text-sm focus:outline-none focus:border-[#4A609A]"
                />
              </div>

              <div>
                <label className="block text-xs font-semibold text-[#5E5A54] uppercase tracking-wider mb-1">Description</label>
                <textarea
                  rows={3}
                  value={editingItem.description}
                  onChange={e => setEditingItem({ ...editingItem, description: e.target.value })}
                  className="w-full px-3 py-2 border border-[#E4DFD5] rounded-lg text-sm focus:outline-none focus:border-[#4A609A]"
                  placeholder="Provide brief context or scope..."
                />
              </div>

              <div className="flex justify-end gap-3 pt-4 border-t border-[#E4DFD5]">
                <button
                  type="button"
                  onClick={() => setIsModalOpen(false)}
                  className="px-4 py-2 border border-[#E4DFD5] text-[#5E5A54] rounded-lg text-sm font-medium hover:bg-[#FAF8F4]"
                >
                  Cancel
                </button>
                <button
                  type="submit"
                  className="px-5 py-2 bg-[#5C1D2A] hover:bg-[#7A2838] text-white rounded-lg text-sm font-medium shadow-sm"
                >
                  Save Responsibility
                </button>
              </div>
            </form>
          </div>
        </div>
      )}
    </section>
  );
};
EOF

# 5. Decisions Component (src/components/DecisionsSection.tsx)
cat << 'EOF' > src/components/DecisionsSection.tsx
import React, { useState } from 'react';
import { Decision } from '../types/charter';
import { Plus, Calendar, User, FileText, CheckCircle2 } from 'lucide-react';

interface Props {
  data: Decision[];
  onSave: (item: Decision) => void;
  onComplete: (id: string) => void;
}

export const DecisionsSection: React.FC<Props> = ({ data, onSave, onComplete }) => {
  const [selectedDecision, setSelectedDecision] = useState<Decision | null>(null);
  const [isEditModalOpen, setIsEditModalOpen] = useState(false);
  const [editingItem, setEditingItem] = useState<Decision | null>(null);

  const groupedByMonth = data.reduce((acc, item) => {
    const m = item.month || 'Upcoming';
    if (!acc[m]) acc[m] = [];
    acc[m].push(item);
    return acc;
  }, {} as Record<string, Decision[]>);

  const handleOpenAdd = () => {
    setEditingItem({
      id: `dec-${Date.now()}`,
      title: '',
      question: '',
      month: 'June 2026',
      owner: 'Arthur Ashford',
      deadline: new Date().toISOString().split('T')[0],
      options: [
        { id: 'opt-1', title: 'Proceed with recommendation', pros: 'Aligned with family goals', cons: 'Capital outlay' }
      ],
      status: 'Pending'
    });
    setIsEditModalOpen(true);
  };

  const handleOpenEdit = (item: Decision, e?: React.MouseEvent) => {
    if (e) e.stopPropagation();
    setEditingItem({ ...item });
    setIsEditModalOpen(true);
  };

  const handleSaveSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    if (!editingItem || !editingItem.title.trim()) return;
    onSave(editingItem);
    if (selectedDecision?.id === editingItem.id) {
      setSelectedDecision(editingItem);
    }
    setIsEditModalOpen(false);
    setEditingItem(null);
  };

  const handleToggleComplete = (id: string) => {
    onComplete(id);
    if (selectedDecision?.id === id) {
      setSelectedDecision(prev => prev ? {
        ...prev,
        status: prev.status === 'Completed' ? 'Decided' : 'Completed'
      } : null);
    }
  };

  return (
    <section className="space-y-6">
      <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4 bg-white p-6 rounded-xl border border-[#E4DFD5] shadow-sm">
        <div>
          <h2 className="text-2xl font-editorial font-medium text-[#5C1D2A]">Governance Decisions</h2>
          <p className="text-sm text-[#5E5A54] mt-1">
            Upcoming and deliberative family decisions organized by month with structured options and outcomes.
          </p>
        </div>
        <button
          onClick={handleOpenAdd}
          className="flex items-center gap-2 bg-[#5C1D2A] hover:bg-[#7A2838] text-white px-4 py-2.5 rounded-lg text-sm font-medium transition shadow-sm"
        >
          <Plus className="w-4 h-4" />
          New Decision Record
        </button>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
        {/* Left Column: List organized by month */}
        <div className="lg:col-span-1 space-y-6">
          {Object.keys(groupedByMonth).length === 0 ? (
            <div className="bg-white p-8 rounded-xl border border-[#E4DFD5] text-center text-[#8C867D]">
              No decisions recorded.
            </div>
          ) : (
            Object.entries(groupedByMonth).map(([month, items]) => (
              <div key={month} className="space-y-3">
                <div className="flex items-center gap-2 text-xs font-semibold text-[#4A609A] uppercase tracking-wider px-1">
                  <Calendar className="w-3.5 h-3.5" />
                  {month}
                </div>
                <div className="space-y-2.5">
                  {items.map(item => {
                    const isSelected = selectedDecision?.id === item.id;
                    const isCompleted = item.status === 'Completed';
                    return (
                      <div
                        key={item.id}
                        onClick={() => setSelectedDecision(item)}
                        className={`p-4 rounded-xl border transition cursor-pointer bg-white ${
                          isSelected 
                            ? 'border-[#5C1D2A] ring-1 ring-[#5C1D2A] shadow-sm' 
                            : 'border-[#E4DFD5] hover:border-[#4A609A]'
                        }`}
                      >
                        <div className="flex justify-between items-start gap-2">
                          <h4 className={`font-medium text-sm ${isCompleted ? 'line-through text-[#8C867D]' : 'text-[#1F1E1C]'}`}>
                            {item.title}
                          </h4>
                          <span className={`text-[10px] px-2 py-0.5 rounded font-medium shrink-0 ${
                            isCompleted ? 'bg-emerald-50 text-emerald-700' :
                            item.status === 'Under Discussion' ? 'bg-[#EEF2FA] text-[#4A609A]' :
                            'bg-[#FAF8F4] text-[#5E5A54] border border-[#E4DFD5]'
                          }`}>
                            {item.status}
                          </span>
                        </div>
                        <div className="flex items-center justify-between mt-3 text-xs text-[#5E5A54]">
                          <span className="flex items-center gap-1">
                            <User className="w-3 h-3" />
                            {item.owner}
                          </span>
                          <span className="font-mono">Due {item.deadline}</span>
                        </div>
                      </div>
                    );
                  })}
                </div>
              </div>
            ))
          )}
        </div>

        {/* Right Column: Detailed Record View */}
        <div className="lg:col-span-2">
          {selectedDecision ? (
            <div className="bg-white rounded-xl border border-[#E4DFD5] p-6 shadow-sm space-y-6">
              <div className="flex justify-between items-start border-b border-[#E4DFD5] pb-4">
                <div>
                  <span className="text-xs font-semibold text-[#4A609A] uppercase tracking-wider">
                    {selectedDecision.month}
                  </span>
                  <h3 className="text-2xl font-editorial font-medium text-[#5C1D2A] mt-1">
                    {selectedDecision.title}
                  </h3>
                </div>
                <div className="flex items-center gap-2">
                  <button
                    onClick={() => handleToggleComplete(selectedDecision.id)}
                    className={`flex items-center gap-1.5 px-3 py-1.5 rounded-lg text-xs font-medium transition ${
                      selectedDecision.status === 'Completed'
                        ? 'bg-emerald-600 text-white'
                        : 'bg-[#FAF8F4] border border-[#E4DFD5] text-[#5E5A54] hover:bg-[#EEF2FA]'
                    }`}
                  >
                    <CheckCircle2 className="w-3.5 h-3.5" />
                    {selectedDecision.status === 'Completed' ? 'Completed' : 'Mark Complete'}
                  </button>
                  <button
                    onClick={(e) => handleOpenEdit(selectedDecision, e)}
                    className="px-3.5 py-1.5 bg-[#5C1D2A] text-white rounded-lg text-xs font-medium hover:bg-[#7A2838] transition"
                  >
                    Edit Record
                  </button>
                </div>
              </div>

              {/* Question */}
              <div className="bg-[#FAF8F4] p-4 rounded-xl border border-[#E4DFD5]">
                <h4 className="text-xs font-semibold text-[#5E5A54] uppercase tracking-wider mb-1">Core Question</h4>
                <p className="text-base font-editorial text-[#1F1E1C]">{selectedDecision.question}</p>
              </div>

              <div className="grid grid-cols-2 gap-4 text-sm">
                <div className="p-3 bg-white rounded-lg border border-[#E4DFD5]">
                  <span className="text-xs text-[#5E5A54] block">Owner</span>
                  <span className="font-medium text-[#1F1E1C]">{selectedDecision.owner}</span>
                </div>
                <div className="p-3 bg-white rounded-lg border border-[#E4DFD5]">
                  <span className="text-xs text-[#5E5A54] block">Deadline</span>
                  <span className="font-mono text-xs font-medium text-[#1F1E1C]">{selectedDecision.deadline}</span>
                </div>
              </div>

              {/* Options Evaluated */}
              <div className="space-y-3">
                <h4 className="text-xs font-semibold text-[#5E5A54] uppercase tracking-wider">Considered Options</h4>
                <div className="space-y-3">
                  {selectedDecision.options.map((opt, idx) => (
                    <div key={opt.id || idx} className="p-4 rounded-lg border border-[#E4DFD5] bg-[#FAF8F4]/50 space-y-2">
                      <div className="font-medium text-sm text-[#1F1E1C]">Option {idx + 1}: {opt.title}</div>
                      <div className="grid grid-cols-1 md:grid-cols-2 gap-2 text-xs">
                        <div className="text-emerald-700 bg-emerald-50 p-2 rounded border border-emerald-100">
                          <strong>Pros:</strong> {opt.pros}
                        </div>
                        <div className="text-rose-700 bg-rose-50 p-2 rounded border border-rose-100">
                          <strong>Cons:</strong> {opt.cons}
                        </div>
                      </div>
                    </div>
                  ))}
                </div>
              </div>

              {/* Outcome / Review */}
              {selectedDecision.outcome && (
                <div className="p-4 rounded-lg bg-[#EEF2FA] border border-[#4A609A]/20 space-y-1">
                  <h4 className="text-xs font-semibold text-[#4A609A] uppercase tracking-wider">Final Outcome</h4>
                  <p className="text-sm text-[#1F1E1C]">{selectedDecision.outcome}</p>
                  {selectedDecision.reviewDate && (
                    <div className="text-xs text-[#5E5A54] pt-1 font-mono">Review Date: {selectedDecision.reviewDate}</div>
                  )}
                </div>
              )}
            </div>
          ) : (
            <div className="bg-white rounded-xl border border-[#E4DFD5] p-12 text-center text-[#8C867D] flex flex-col items-center justify-center space-y-3 h-full min-h-[350px]">
              <FileText className="w-10 h-10 text-[#E4DFD5]" />
              <p>Select a decision record from the left to view full deliberative details, options, and outcomes.</p>
            </div>
          )}
        </div>
      </div>

      {/* Edit / Add Modal */}
      {isEditModalOpen && editingItem && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/40 backdrop-blur-sm p-4 overflow-y-auto">
          <div className="bg-white rounded-2xl max-w-xl w-full p-6 shadow-xl border border-[#E4DFD5] space-y-6 my-8">
            <div className="flex justify-between items-center border-b border-[#E4DFD5] pb-4">
              <h3 className="text-xl font-editorial font-medium text-[#5C1D2A]">
                {data.some(d => d.id === editingItem.id) ? 'Edit Decision Record' : 'Create Decision'}
              </h3>
              <button 
                onClick={() => setIsEditModalOpen(false)}
                className="text-[#8C867D] hover:text-[#1F1E1C] text-lg font-bold px-2"
              >
                &times;
              </button>
            </div>

            <form onSubmit={handleSaveSubmit} className="space-y-4 max-h-[70vh] overflow-y-auto pr-1">
              <div>
                <label className="block text-xs font-semibold text-[#5E5A54] uppercase tracking-wider mb-1">Decision Title *</label>
                <input
                  type="text"
                  required
                  value={editingItem.title}
                  onChange={e => setEditingItem({ ...editingItem, title: e.target.value })}
                  className="w-full px-3 py-2 border border-[#E4DFD5] rounded-lg text-sm focus:outline-none focus:border-[#4A609A]"
                  placeholder="e.g. Museum Loan Agreement"
                />
              </div>

              <div>
                <label className="block text-xs font-semibold text-[#5E5A54] uppercase tracking-wider mb-1">Core Question *</label>
                <textarea
                  required
                  rows={2}
                  value={editingItem.question}
                  onChange={e => setEditingItem({ ...editingItem, question: e.target.value })}
                  className="w-full px-3 py-2 border border-[#E4DFD5] rounded-lg text-sm focus:outline-none focus:border-[#4A609A]"
                  placeholder="What is the exact question facing the family?"
                />
              </div>

              <div className="grid grid-cols-2 gap-4">
                <div>
                  <label className="block text-xs font-semibold text-[#5E5A54] uppercase tracking-wider mb-1">Month / Schedule</label>
                  <input
                    type="text"
                    value={editingItem.month}
                    onChange={e => setEditingItem({ ...editingItem, month: e.target.value })}
                    className="w-full px-3 py-2 border border-[#E4DFD5] rounded-lg text-sm focus:outline-none focus:border-[#4A609A]"
                    placeholder="e.g. June 2026"
                  />
                </div>
                <div>
                  <label className="block text-xs font-semibold text-[#5E5A54] uppercase tracking-wider mb-1">Status</label>
                  <select
                    value={editingItem.status}
                    onChange={e => setEditingItem({ ...editingItem, status: e.target.value as any })}
                    className="w-full px-3 py-2 border border-[#E4DFD5] rounded-lg text-sm bg-white focus:outline-none focus:border-[#4A609A]"
                  >
                    <option value="Pending">Pending</option>
                    <option value="Under Discussion">Under Discussion</option>
                    <option value="Decided">Decided</option>
                    <option value="Completed">Completed</option>
                  </select>
                </div>
              </div>

              <div className="grid grid-cols-2 gap-4">
                <div>
                  <label className="block text-xs font-semibold text-[#5E5A54] uppercase tracking-wider mb-1">Owner</label>
                  <input
                    type="text"
                    value={editingItem.owner}
                    onChange={e => setEditingItem({ ...editingItem, owner: e.target.value })}
                    className="w-full px-3 py-2 border border-[#E4DFD5] rounded-lg text-sm focus:outline-none focus:border-[#4A609A]"
                  />
                </div>
                <div>
                  <label className="block text-xs font-semibold text-[#5E5A54] uppercase tracking-wider mb-1">Deadline</label>
                  <input
                    type="date"
                    value={editingItem.deadline}
                    onChange={e => setEditingItem({ ...editingItem, deadline: e.target.value })}
                    className="w-full px-3 py-2 border border-[#E4DFD5] rounded-lg text-sm focus:outline-none focus:border-[#4A609A]"
                  />
                </div>
              </div>

              <div>
                <label className="block text-xs font-semibold text-[#5E5A54] uppercase tracking-wider mb-1">Outcome & Review Notes</label>
                <textarea
                  rows={2}
                  value={editingItem.outcome || ''}
                  onChange={e => setEditingItem({ ...editingItem, outcome: e.target.value })}
                  className="w-full px-3 py-2 border border-[#E4DFD5] rounded-lg text-sm focus:outline-none focus:border-[#4A609A]"
                  placeholder="Record final decision outcome once reached..."
                />
              </div>

              <div>
                <label className="block text-xs font-semibold text-[#5E5A54] uppercase tracking-wider mb-1">Review Date</label>
                <input
                  type="date"
                  value={editingItem.reviewDate || ''}
                  onChange={e => setEditingItem({ ...editingItem, reviewDate: e.target.value })}
                  className="w-full px-3 py-2 border border-[#E4DFD5] rounded-lg text-sm focus:outline-none focus:border-[#4A609A]"
                />
              </div>

              <div className="flex justify-end gap-3 pt-4 border-t border-[#E4DFD5]">
                <button
                  type="button"
                  onClick={() => setIsEditModalOpen(false)}
                  className="px-4 py-2 border border-[#E4DFD5] text-[#5E5A54] rounded-lg text-sm font-medium hover:bg-[#FAF8F4]"
                >
                  Cancel
                </button>
                <button
                  type="submit"
                  className="px-5 py-2 bg-[#5C1D2A] hover:bg-[#7A2838] text-white rounded-lg text-sm font-medium shadow-sm"
                >
                  Save Decision
                </button>
              </div>
            </form>
          </div>
        </div>
      )}
    </section>
  );
};
EOF

# 6. Giving Component (src/components/GivingSection.tsx)
cat << 'EOF' > src/components/GivingSection.tsx
import React, { useState } from 'react';
import { GivingRecord } from '../types/charter';
import { Plus, Edit3 } from 'lucide-react';

interface Props {
  data: GivingRecord[];
  onSave: (item: GivingRecord) => void;
}

export const GivingSection: React.FC<Props> = ({ data, onSave }) => {
  const [filterFocus, setFilterFocus] = useState<string>('All');
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [editingItem, setEditingItem] = useState<GivingRecord | null>(null);

  const focusAreas = ['All', 'Arts & Culture', 'Education', 'Medical Research', 'Community & Civic'];

  const filteredData = filterFocus === 'All' 
    ? data 
    : data.filter(d => d.focusArea === filterFocus);

  const handleOpenAdd = () => {
    setEditingItem({
      id: `giv-${Date.now()}`,
      organization: '',
      familyInterest: '',
      assessment: '',
      proposedGift: '',
      decisionStatus: 'Proposed',
      pledgeFollowUp: '2026-12-31',
      focusArea: 'Arts & Culture'
    });
    setIsModalOpen(true);
  };

  const handleOpenEdit = (item: GivingRecord) => {
    setEditingItem({ ...item });
    setIsModalOpen(true);
  };

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    if (!editingItem || !editingItem.organization.trim()) return;
    onSave(editingItem);
    setIsModalOpen(false);
    setEditingItem(null);
  };

  return (
    <section className="space-y-6">
      <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4 bg-white p-6 rounded-xl border border-[#E4DFD5] shadow-sm">
        <div>
          <h2 className="text-2xl font-editorial font-medium text-[#5C1D2A]">Charitable Giving & Foundation</h2>
          <p className="text-sm text-[#5E5A54] mt-1">
            Ashford Family Foundation beneficiary tracking, impact assessments, proposed gifts, and pledge schedules.
          </p>
        </div>
        <button
          onClick={handleOpenAdd}
          className="flex items-center gap-2 bg-[#5C1D2A] hover:bg-[#7A2838] text-white px-4 py-2.5 rounded-lg text-sm font-medium transition shadow-sm"
        >
          <Plus className="w-4 h-4" />
          Add Charitable Organization
        </button>
      </div>

      {/* Focus Area Pills */}
      <div className="flex flex-wrap gap-2">
        {focusAreas.map(area => (
          <button
            key={area}
            onClick={() => setFilterFocus(area)}
            className={`px-3.5 py-1.5 rounded-lg text-xs font-medium transition ${
              filterFocus === area
                ? 'bg-[#4A609A] text-white shadow-sm'
                : 'bg-white text-[#5E5A54] border border-[#E4DFD5] hover:border-[#4A609A]'
            }`}
          >
            {area}
          </button>
        ))}
      </div>

      {/* Grid of Charitable Records */}
      <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
        {filteredData.length === 0 ? (
          <div className="col-span-2 bg-white p-8 rounded-xl border border-[#E4DFD5] text-center text-[#8C867D]">
            No charitable organizations found in this category.
          </div>
        ) : (
          filteredData.map(item => (
            <div key={item.id} className="bg-white rounded-xl border border-[#E4DFD5] p-6 shadow-sm flex flex-col justify-between space-y-4">
              <div className="space-y-3">
                <div className="flex justify-between items-start gap-2">
                  <div>
                    <span className="text-[10px] uppercase tracking-wider font-semibold px-2 py-0.5 bg-[#EEF2FA] text-[#4A609A] rounded">
                      {item.focusArea}
                    </span>
                    <h3 className="text-xl font-editorial font-medium text-[#1F1E1C] mt-1.5">{item.organization}</h3>
                  </div>
                  <span className={`text-xs px-2.5 py-1 rounded-full font-medium shrink-0 ${
                    item.decisionStatus === 'Approved' || item.decisionStatus === 'Paid' ? 'bg-emerald-50 text-emerald-700 border border-emerald-200' :
                    item.decisionStatus === 'Pledged' ? 'bg-[#EEF2FA] text-[#4A609A]' :
                    item.decisionStatus === 'Declined' ? 'bg-rose-50 text-rose-700' :
                    'bg-[#FAF8F4] text-[#5E5A54] border border-[#E4DFD5]'
                  }`}>
                    {item.decisionStatus}
                  </span>
                </div>

                <div className="space-y-2 text-sm text-[#5E5A54]">
                  <div>
                    <strong className="text-[#1F1E1C] font-medium">Family Interest:</strong> {item.familyInterest}
                  </div>
                  <div className="bg-[#FAF8F4] p-3 rounded-lg border border-[#E4DFD5]">
                    <strong className="text-[#1F1E1C] font-medium block text-xs uppercase tracking-wider mb-0.5">Short Assessment</strong>
                    {item.assessment}
                  </div>
                </div>
              </div>

              <div className="pt-4 border-t border-[#E4DFD5] flex items-center justify-between">
                <div>
                  <div className="text-xs text-[#8C867D]">Proposed Gift</div>
                  <div className="font-editorial text-lg font-medium text-[#5C1D2A]">{item.proposedGift}</div>
                  <div className="text-[11px] text-[#5E5A54] font-mono mt-0.5">Follow-up: {item.pledgeFollowUp}</div>
                </div>
                <button
                  onClick={() => handleOpenEdit(item)}
                  className="p-2 text-[#5E5A54] hover:text-[#5C1D2A] hover:bg-[#FAF8F4] rounded-lg transition border border-[#E4DFD5]"
                  title="Edit Record"
                >
                  <Edit3 className="w-4 h-4" />
                </button>
              </div>
            </div>
          ))
        )}
      </div>

      {/* Modal for Add / Edit */}
      {isModalOpen && editingItem && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/40 backdrop-blur-sm p-4 overflow-y-auto">
          <div className="bg-white rounded-2xl max-w-lg w-full p-6 shadow-xl border border-[#E4DFD5] space-y-6 my-8">
            <div className="flex justify-between items-center border-b border-[#E4DFD5] pb-4">
              <h3 className="text-xl font-editorial font-medium text-[#5C1D2A]">
                {data.some(d => d.id === editingItem.id) ? 'Edit Charitable Record' : 'Add Charitable Organization'}
              </h3>
              <button 
                onClick={() => setIsModalOpen(false)}
                className="text-[#8C867D] hover:text-[#1F1E1C] text-lg font-bold px-2"
              >
                &times;
              </button>
            </div>

            <form onSubmit={handleSubmit} className="space-y-4 max-h-[70vh] overflow-y-auto pr-1">
              <div>
                <label className="block text-xs font-semibold text-[#5E5A54] uppercase tracking-wider mb-1">Organization Name *</label>
                <input
                  type="text"
                  required
                  value={editingItem.organization}
                  onChange={e => setEditingItem({ ...editingItem, organization: e.target.value })}
                  className="w-full px-3 py-2 border border-[#E4DFD5] rounded-lg text-sm focus:outline-none focus:border-[#4A609A]"
                  placeholder="e.g. Museum of Fine Arts, Houston"
                />
              </div>

              <div className="grid grid-cols-2 gap-4">
                <div>
                  <label className="block text-xs font-semibold text-[#5E5A54] uppercase tracking-wider mb-1">Focus Area</label>
                  <select
                    value={editingItem.focusArea}
                    onChange={e => setEditingItem({ ...editingItem, focusArea: e.target.value as any })}
                    className="w-full px-3 py-2 border border-[#E4DFD5] rounded-lg text-sm bg-white focus:outline-none focus:border-[#4A609A]"
                  >
                    <option value="Arts & Culture">Arts & Culture</option>
                    <option value="Education">Education</option>
                    <option value="Medical Research">Medical Research</option>
                    <option value="Community & Civic">Community & Civic</option>
                  </select>
                </div>
                <div>
                  <label className="block text-xs font-semibold text-[#5E5A54] uppercase tracking-wider mb-1">Decision Status</label>
                  <select
                    value={editingItem.decisionStatus}
                    onChange={e => setEditingItem({ ...editingItem, decisionStatus: e.target.value as any })}
                    className="w-full px-3 py-2 border border-[#E4DFD5] rounded-lg text-sm bg-white focus:outline-none focus:border-[#4A609A]"
                  >
                    <option value="Proposed">Proposed</option>
                    <option value="Approved">Approved</option>
                    <option value="Declined">Declined</option>
                    <option value="Pledged">Pledged</option>
                    <option value="Paid">Paid</option>
                  </select>
                </div>
              </div>

              <div>
                <label className="block text-xs font-semibold text-[#5E5A54] uppercase tracking-wider mb-1">Family Interest</label>
                <input
                  type="text"
                  value={editingItem.familyInterest}
                  onChange={e => setEditingItem({ ...editingItem, familyInterest: e.target.value })}
                  className="w-full px-3 py-2 border border-[#E4DFD5] rounded-lg text-sm focus:outline-none focus:border-[#4A609A]"
                  placeholder="e.g. Access for local students"
                />
              </div>

              <div>
                <label className="block text-xs font-semibold text-[#5E5A54] uppercase tracking-wider mb-1">Short Assessment</label>
                <textarea
                  rows={2}
                  value={editingItem.assessment}
                  onChange={e => setEditingItem({ ...editingItem, assessment: e.target.value })}
                  className="w-full px-3 py-2 border border-[#E4DFD5] rounded-lg text-sm focus:outline-none focus:border-[#4A609A]"
                  placeholder="Strategic alignment and impact notes..."
                />
              </div>

              <div className="grid grid-cols-2 gap-4">
                <div>
                  <label className="block text-xs font-semibold text-[#5E5A54] uppercase tracking-wider mb-1">Proposed Gift</label>
                  <input
                    type="text"
                    value={editingItem.proposedGift}
                    onChange={e => setEditingItem({ ...editingItem, proposedGift: e.target.value })}
                    className="w-full px-3 py-2 border border-[#E4DFD5] rounded-lg text-sm focus:outline-none focus:border-[#4A609A]"
                    placeholder="e.g. $500,000"
                  />
                </div>
                <div>
                  <label className="block text-xs font-semibold text-[#5E5A54] uppercase tracking-wider mb-1">Pledge Follow-Up</label>
                  <input
                    type="text"
                    value={editingItem.pledgeFollowUp}
                    onChange={e => setEditingItem({ ...editingItem, pledgeFollowUp: e.target.value })}
                    className="w-full px-3 py-2 border border-[#E4DFD5] rounded-lg text-sm focus:outline-none focus:border-[#4A609A]"
                    placeholder="e.g. 2026-09-01"
                  />
                </div>
              </div>

              <div className="flex justify-end gap-3 pt-4 border-t border-[#E4DFD5]">
                <button
                  type="button"
                  onClick={() => setIsModalOpen(false)}
                  className="px-4 py-2 border border-[#E4DFD5] text-[#5E5A54] rounded-lg text-sm font-medium hover:bg-[#FAF8F4]"
                >
                  Cancel
                </button>
                <button
                  type="submit"
                  className="px-5 py-2 bg-[#5C1D2A] hover:bg-[#7A2838] text-white rounded-lg text-sm font-medium shadow-sm"
                >
                  Save Giving Record
                </button>
              </div>
            </form>
          </div>
        </div>
      )}
    </section>
  );
};
EOF

# 7. Main App Entry (src/App.tsx)
cat << 'EOF' > src/App.tsx
import React, { useState } from 'react';
import { useCharterStore } from './hooks/useCharterStore';
import { ResponsibilitiesSection } from './components/ResponsibilitiesSection';
import { DecisionsSection } from './components/DecisionsSection';
import { GivingSection } from './components/GivingSection';
import { Shield, CheckSquare, Heart, RotateCcw } from 'lucide-react';

export default function App() {
  const {
    responsibilities,
    decisions,
    giving,
    toastMessage,
    saveResponsibility,
    saveDecision,
    completeDecision,
    saveGiving,
    resetDemoData
  } = useCharterStore();

  const [activeTab, setActiveTab] = useState<'responsibilities' | 'decisions' | 'giving'>('responsibilities');

  return (
    <div className="min-h-screen bg-[#FAF8F4] text-[#1F1E1C] flex flex-col justify-between font-sans selection:bg-[#4A609A]/20">
      {/* Toast Notification */}
      {toastMessage && (
        <div className="fixed top-6 right-6 z-50 bg-[#1F1E1C] text-white px-5 py-3 rounded-xl shadow-lg border border-[#E4DFD5]/20 text-sm animate-in fade-in slide-in-from-top-4 flex items-center gap-3">
          <span className="w-2 h-2 rounded-full bg-emerald-400"></span>
          {toastMessage}
        </div>
      )}

      {/* Header */}
      <header className="bg-white border-b border-[#E4DFD5] sticky top-0 z-30">
        <div className="max-w-7xl mx-auto px-6 py-4 flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4">
          <div className="flex items-center gap-3">
            <div className="w-10 h-10 rounded-xl bg-[#5C1D2A] text-white flex items-center justify-center font-editorial font-bold text-xl shadow-sm">
              C
            </div>
            <div>
              <div className="flex items-center gap-2">
                <span className="text-xs uppercase tracking-widest text-[#5E5A54] font-semibold">The Harris Office</span>
                <span className="text-[10px] px-2 py-0.5 bg-[#F7EFF1] text-[#5C1D2A] rounded-full font-medium border border-[#5C1D2A]/15">
                  Ashford Family Demo
                </span>
              </div>
              <h1 className="text-2xl font-editorial font-medium text-[#1F1E1C]">Charter & Family Governance</h1>
            </div>
          </div>

          <div className="flex items-center gap-3 w-full sm:w-auto justify-between sm:justify-end">
            <button
              onClick={resetDemoData}
              className="flex items-center gap-2 px-3.5 py-2 bg-[#FAF8F4] hover:bg-[#EEF2FA] text-[#5E5A54] border border-[#E4DFD5] rounded-lg text-xs font-medium transition shadow-sm"
              title="Reset data to initial Ashford family demo state"
            >
              <RotateCcw className="w-3.5 h-3.5" />
              Reset Demo Data
            </button>
          </div>
        </div>

        {/* Navigation Tabs */}
        <div className="max-w-7xl mx-auto px-6 flex gap-8 border-t border-[#E4DFD5]/60">
          <button
            onClick={() => setActiveTab('responsibilities')}
            className={`py-3.5 text-sm font-medium border-b-2 transition flex items-center gap-2 ${
              activeTab === 'responsibilities'
                ? 'border-[#5C1D2A] text-[#5C1D2A]'
                : 'border-transparent text-[#5E5A54] hover:text-[#1F1E1C]'
            }`}
          >
            <Shield className="w-4 h-4" />
            Responsibilities ({responsibilities.length})
          </button>
          <button
            onClick={() => setActiveTab('decisions')}
            className={`py-3.5 text-sm font-medium border-b-2 transition flex items-center gap-2 ${
              activeTab === 'decisions'
                ? 'border-[#5C1D2A] text-[#5C1D2A]'
                : 'border-transparent text-[#5E5A54] hover:text-[#1F1E1C]'
            }`}
          >
            <CheckSquare className="w-4 h-4" />
            Decisions ({decisions.length})
          </button>
          <button
            onClick={() => setActiveTab('giving')}
            className={`py-3.5 text-sm font-medium border-b-2 transition flex items-center gap-2 ${
              activeTab === 'giving'
                ? 'border-[#5C1D2A] text-[#5C1D2A]'
                : 'border-transparent text-[#5E5A54] hover:text-[#1F1E1C]'
            }`}
          >
            <Heart className="w-4 h-4" />
            Giving & Foundation ({giving.length})
          </button>
        </div>
      </header>

      {/* Main Content Area */}
      <main className="max-w-7xl mx-auto px-6 py-8 flex-grow w-full">
        {activeTab === 'responsibilities' && (
          <ResponsibilitiesSection data={responsibilities} onSave={saveResponsibility} />
        )}
        {activeTab === 'decisions' && (
          <DecisionsSection data={decisions} onSave={saveDecision} onComplete={completeDecision} />
        )}
        {activeTab === 'giving' && (
          <GivingSection data={giving} onSave={saveGiving} />
        )}
      </main>

      {/* Footer */}
      <footer className="bg-white border-t border-[#E4DFD5] py-6 text-center text-xs text-[#8C867D]">
        <div className="max-w-7xl mx-auto px-6 flex flex-col sm:flex-row justify-between items-center gap-4">
          <div>Charter — Family Office Governance Platform &copy; {new Date().getFullYear()}</div>
          <div className="text-[11px] bg-[#FAF8F4] px-3 py-1 rounded-md border border-[#E4DFD5]">
            Demonstration Version using Fictional Data (Ashford Family of Houston). No real client data or bank connections.
          </div>
        </div>
      </footer>
    </div>
  );
}
EOF

# 8. README Documentation (README.md)
cat << 'EOF' > README.md
# Charter — Family Office Governance Platform (The Harris Office)

> **Demonstration Notice:** This application is a demonstration built with realistic, entirely fictional data for the Ashford family of Houston. No backend, login, bank connections, payment processing, or real client data are included.

## Overview

Charter organizes family office governance across three connected sections:
1. **Responsibilities:** Tracks ongoing governance, business, philanthropy, and estate duties with owner assignments, adviser contacts, due dates, and automatic visual highlighting for unassigned responsibilities.
2. **Decisions:** Organizes upcoming family deliberations by month, detailing core questions, owners, deadlines, evaluated pros/cons options, outcomes, and review dates.
3. **Giving & Foundation:** Manages charitable organizations, family interests, impact assessments, proposed gift commitments, approval statuses, and pledge follow-up schedules.

All edits persist automatically in browser `localStorage` and can be restored to the default Ashford family baseline at any time via the **Reset Demo Data** button.

## Installation & Running

1. Install dependencies:
   ```bash
   npm install
   ```

2. Start the development server:
   ```bash
   npm run dev
   ```

3. Open your browser to the local URL shown in your terminal (typically `http://localhost:5173`).

## Architecture & Extending the App

- `src/types/charter.ts`: Strongly typed interfaces (`Responsibility`, `Decision`, `GivingRecord`).
- `src/data/seedData.ts`: Fictional baseline records for the Ashford family.
- `src/hooks/useCharterStore.ts`: Centralized state hook handling `localStorage` sync, CRUD mutations, toast feedback, and demo data resets.
- `src/components/`: Self-contained UI modules (`ResponsibilitiesSection.tsx`, `DecisionsSection.tsx`, `GivingSection.tsx`).
EOF

echo "All Charter governance files created successfully!"

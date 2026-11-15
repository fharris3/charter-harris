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

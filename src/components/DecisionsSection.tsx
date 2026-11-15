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

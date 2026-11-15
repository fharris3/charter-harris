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

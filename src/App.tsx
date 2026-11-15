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

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

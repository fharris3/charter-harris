cat << 'EOF' > src/App.tsx
import React from 'react';

export default function App() {
  return (
    <div className="min-h-screen bg-[#FAF8F4] text-[#1F1E1C] flex flex-col justify-between p-8 font-sans">
      <header className="max-w-4xl mx-auto w-full py-6 border-b border-[#E4DFD5] flex justify-between items-center">
        <div>
          <span className="text-xs uppercase tracking-widest text-[#5E5A54] font-semibold">The Harris Office</span>
          <h1 className="text-3xl font-editorial font-medium text-[#5C1D2A] mt-1">Charter & Governance</h1>
        </div>
        <span className="text-xs px-3 py-1 bg-[#EEF2FA] text-[#4A609A] rounded-full font-medium">System Online</span>
      </header>

      <main className="max-w-4xl mx-auto w-full my-12 space-y-6">
        <div className="bg-white rounded-xl p-8 shadow-sm border border-[#E4DFD5]">
          <h2 className="text-2xl font-editorial text-[#1F1E1C] mb-3">Welcome to Your Family Office Charter</h2>
          <p className="text-[#5E5A54] leading-relaxed mb-6">
            Your project environment has been successfully initialized with Vite, Tailwind CSS, and TypeScript. 
            You can now start building out your governance modules, components, and data structures.
          </p>
          <div className="p-4 bg-[#F7EFF1] border-l-4 border-[#5C1D2A] text-[#5C1D2A] text-sm rounded-r-lg">
            <strong>Next step:</strong> Begin adding your custom components inside the <code>src/components/</code> directory and import them here or in your router setup.
          </div>
        </div>
      </main>

      <footer className="max-w-4xl mx-auto w-full pt-6 border-t border-[#E4DFD5] text-xs text-[#8C867D] text-center">
        Charter — The Harris Office &copy; {new Date().getFullYear()}
      </footer>
    </div>
  );
}
EOF
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

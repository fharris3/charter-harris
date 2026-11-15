/** @type {import('tailwindcss').Config} */
export default {
  content: ['./index.html', './src/**/*.{js,ts,jsx,tsx}'],
  theme: {
    extend: {
      colors: {
        ivory: { DEFAULT: '#FAF8F4', subtle: '#F3EFE6', card: '#FFFFFF' },
        maroon: { DEFAULT: '#5C1D2A', light: '#7A2838', tint: '#F7EFF1' },
        periwinkle: { DEFAULT: '#4A609A', light: '#6179B8', tint: '#EEF2FA' },
        ink: { DEFAULT: '#1F1E1C', muted: '#5E5A54', faint: '#8C867D' },
        sand: '#E4DFD5',
      },
      fontFamily: {
        serif: ['Newsreader', 'Georgia', 'serif'],
        sans: ['Inter', 'system-ui', 'sans-serif'],
      },
    },
  },
  plugins: [],
};

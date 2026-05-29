import type { Config } from 'tailwindcss'

export default {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
      colors: {
        indigo: {
          50: '#eef8f8',
          100: '#d5eff0',
          200: '#aae0e1',
          300: '#52c9c2',
          400: '#0b6873',
          500: '#0b6873',
          600: '#123451',
          700: '#092531',
          800: '#061a22',
          900: '#030d11',
        },
        slate: {
          50: '#f8fbfb',
          100: '#eef3f4',
          200: '#dce5e7',
          300: '#baccd0',
          400: '#94b0b5',
          500: '#73949a',
          600: '#5c7a80',
          700: '#4a6267',
          800: '#123451',
          900: '#092531',
        },
      },
      fontFamily: {
        sans: ['"Plus Jakarta Sans"', '"Inter"', 'ui-sans-serif', 'system-ui', 'sans-serif'],
        display: ['"Plus Jakarta Sans"', 'sans-serif'],
      },
    },
  },
  plugins: [],
} satisfies Config

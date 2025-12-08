import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';

// Mantine-based Vite configuration
// This configuration uses Mantine UI components instead of Tailwind CSS
// Mantine provides a complete component library with:
// - Pre-built accessible components (Button, Card, Modal, etc.)
// - Built-in dark mode support
// - TypeScript-first API
// - Hooks for form handling, notifications, and more
// - Customizable theme system

export default defineConfig({
  plugins: [react()],
});

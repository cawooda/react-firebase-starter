import { createContext } from 'react';
import { useState, useEffect, type ReactNode } from 'react';

interface ThemeContextType {
  darkMode: string;
  setDarkMode: (mode: 'light' | 'dark') => void;
}

interface ThemeProviderProps {
  children: ReactNode;
}

export const ThemeContext = createContext<ThemeContextType>({
  darkMode: 'dark',
  setDarkMode: () => {},
});

export const ThemeProvider = ({ children }: ThemeProviderProps) => {
  const [darkMode, setDarkModeState] = useState<'light' | 'dark'>('dark');

  const setDarkMode = (mode: 'light' | 'dark') => {
    console.log('setDarkMode called with:', mode);
    setDarkModeState(mode);
  };

  useEffect(() => {
    console.log('Theme changed to:', darkMode);
    localStorage.setItem('theme', darkMode);
    const root = document.documentElement;

    if (darkMode === 'dark') {
      root.classList.add('dark');
      root.classList.remove('light');
    } else {
      root.classList.remove('dark');
      root.classList.add('light');
    }

    console.log('HTML classes:', root.classList.toString());
  }, [darkMode]);

  return (
    <ThemeContext.Provider value={{ darkMode, setDarkMode }}>
      {children}
    </ThemeContext.Provider>
  );
};

import AppContainer from './components/AppContainer';
import { ThemeProvider } from './ThemeContext';

import './App.css';
import Menu from './components/Menu';

export default function App() {
  return (
    <ThemeProvider>
      <AppContainer>
        <Menu
          items={[
            { id: 1, name: 'about' },
            { id: 2, name: 'contact' },
          ]}
        />
        <article className="prose lg:prose-xl">
          <h1>Welcome to your New App</h1>
          <p>
            A simple app to get you started with React, TypeScript, and Tailwind
            CSS.
          </p>
        </article>
      </AppContainer>
    </ThemeProvider>
  );
}

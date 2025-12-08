# Mantine UI Integration - Quick Reference

## 🎯 Feature Overview

The Vite Bootstrap script now supports **Mantine UI** as an alternative to Tailwind CSS + daisyUI.

## 🚀 Quick Start

### Default (Tailwind CSS + daisyUI)

```bash
./vite-bootstrap.sh my-app --git --eslint
```

### With Mantine UI

```bash
./vite-bootstrap.sh my-app --mantine --git --eslint
```

---

## 📦 What Gets Installed

### Tailwind CSS (Default)

```bash
npm install tailwindcss @tailwindcss/vite daisyui
npm install -D @tailwindcss/typography  # optional
```

### Mantine UI

```bash
npm install @mantine/core @mantine/hooks @mantine/form @mantine/dates dayjs
npm install --save-dev postcss postcss-preset-mantine postcss-simple-vars
```

---

## 🎨 Component Examples

### Tailwind with daisyUI

```tsx
import AppContainer from "./components/AppContainer";
import { ThemeProvider } from "./ThemeContext";

export default function App() {
  return (
    <ThemeProvider>
      <AppContainer>
        <article className="prose lg:prose-xl">
          <h1>Welcome</h1>
          <p>Built with Tailwind CSS</p>
        </article>
      </AppContainer>
    </ThemeProvider>
  );
}
```

### Mantine UI

```tsx
import { MantineProvider, Button, Card, Title, Text } from "@mantine/core";
import AppContainer from "./components/AppContainer";

export default function App() {
  return (
    <MantineProvider>
      <AppContainer>
        <Card>
          <Title>Welcome</Title>
          <Text>Built with Mantine UI</Text>
          <Button>Get Started</Button>
        </Card>
      </AppContainer>
    </MantineProvider>
  );
}
```

---

## 🌓 Dark Mode Implementation

### Tailwind (Manual Toggle)

```tsx
import { useContext } from "react";
import { ThemeContext } from "./ThemeContext";

export function ThemeToggle() {
  const { darkMode, setDarkMode } = useContext(ThemeContext);

  return (
    <button onClick={() => setDarkMode(darkMode === "dark" ? "light" : "dark")}>
      Toggle: {darkMode}
    </button>
  );
}
```

### Mantine (Built-in Hook)

```tsx
import { useMantineColorScheme, Button } from "@mantine/core";

export function ThemeToggle() {
  const { colorScheme, toggleColorScheme } = useMantineColorScheme();

  return (
    <Button onClick={() => toggleColorScheme()}>Toggle: {colorScheme}</Button>
  );
}
```

---

## 📁 Template Files Created

### New Files for Mantine

- `templates/vite.config.mantine.ts` - Vite configuration
- `templates/postcss.config.ts` - PostCSS configuration
- `templates/src/App.mantine.tsx` - Root component example
- `templates/src/index.mantine.css` - Global styles

### Existing Files (Shared)

- `templates/src/components/AppContainer.tsx`
- `templates/src/components/Menu.tsx`
- `templates/.gitignore`
- `templates/.prettierrc.json`
- `templates/.prettierignore`
- `templates/eslint.config.js`

---

## 🔧 Command-Line Usage

### Available Flags

```bash
--git              # Initialize Git
--eslint           # Install ESLint
--prettier         # Install Prettier
--mantine          # Use Mantine UI instead of Tailwind
--no-firebase      # Skip Firebase
--no-router        # Skip React Router
--no-typography    # Skip Tailwind Typography
--overwrite        # Overwrite existing directory
--help             # Show help
```

### Common Combinations

```bash
# Mantine with everything
./vite-bootstrap.sh my-app --mantine --git --eslint --prettier

# Mantine minimal
./vite-bootstrap.sh my-app --mantine --no-firebase --no-router

# Tailwind with tools
./vite-bootstrap.sh my-app --git --eslint --prettier

# Just Tailwind
./vite-bootstrap.sh my-app --git
```

---

## 🎯 Choose Your Framework

### Use **Tailwind CSS** if you want:

- Lightweight bundle
- Utility-first approach
- Maximum customization
- Pre-designed daisyUI themes
- Fine-grained control over styling

### Use **Mantine UI** if you want:

- Rapid development with components
- Built-in dark mode
- Comprehensive component library
- Form validation built-in
- Less CSS code to write
- TypeScript-first experience

---

## 📚 Documentation Links

- [Mantine Official Docs](https://mantine.dev/)
- [Mantine Components](https://mantine.dev/components/)
- [Mantine Hooks](https://mantine.dev/hooks/)
- [Tailwind CSS Docs](https://tailwindcss.com/docs)
- [daisyUI Components](https://daisyui.com/)

---

## ✨ Key Features

✅ Fully backward compatible (default is still Tailwind)
✅ Conditional installation of dependencies
✅ Automatic file selection based on framework choice
✅ Both frameworks work with all optional features
✅ Shared components work with both frameworks
✅ Complete documentation in README.md

---

## 📝 Script Logic Flow

```
1. Parse --mantine flag
2. Set INSTALL_MANTINE variable
3. Install appropriate CSS framework
4. Copy framework-specific Vite config
5. Copy framework-specific CSS file
6. Copy framework-specific App component
7. Copy shared components (both use same)
8. Install optional tools (ESLint, Prettier, Git)
9. Open in VS Code
```

---

## 🤔 FAQ

**Q: Can I switch from Tailwind to Mantine later?**
A: Yes, you can manually update the configuration files and dependencies.

**Q: Do both frameworks work with Firebase?**
A: Yes, Firebase is independent of the CSS framework.

**Q: Can I use both Tailwind and Mantine together?**
A: Not recommended - stick with one for consistency.

**Q: Is Mantine production-ready?**
A: Yes, Mantine is a mature, battle-tested component library.

**Q: What's the bundle size difference?**
A: Mantine is larger (includes all components), Tailwind is smaller with tree-shaking.

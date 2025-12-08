# Vite Bootstrap Script

A powerful bash script that automates the creation of production-ready React applications with modern tooling, styling, and optional features.

## 🎯 Overview

This bootstrap script creates a fully configured React application with:

- **Vite** - Lightning-fast build tool and development server
- **React 18+** - Modern React with hooks and concurrent features
- **TypeScript** - Type-safe JavaScript for better code quality
- **CSS Framework** - Choose between:
  - **Tailwind CSS** - Utility-first CSS framework with daisyUI components
  - **Mantine UI** - Complete component library with built-in dark mode
- **Dark Mode Support** - Built-in theme switching (Tailwind via ThemeContext, Mantine built-in)
- **Pre-built Components** - AppContainer and Menu components ready to use
- **Optional Firebase** - Backend services integration
- **Optional React Router** - Client-side routing for multi-page apps
- **Optional ESLint** - Code quality linting
- **Optional Prettier** - Code formatting
- **Optional Git** - Version control initialization

## 📋 Prerequisites

- **Node.js** v18 or higher ([Download](https://nodejs.org/))
- **npm** v9 or higher (comes with Node.js)
- **VS Code** (optional, but recommended)
- **Git** (optional, only needed with `--git` flag)

Verify installation:

```bash
node --version   # Should be v18+
npm --version    # Should be v9+
git --version    # Required only if using --git flag
```

## 🚀 Quick Start

### Basic Usage

Create a new project with all defaults:

```bash
./vite-bootstrap.sh my-app
```

This will create a project with:

- ✅ Vite + React + TypeScript
- ✅ Tailwind CSS + daisyUI
- ✅ React Router
- ✅ Firebase
- ✅ Tailwind Typography plugin
- ✅ Dark mode theme support

### Common Examples

**With Git initialization:**

```bash
./vite-bootstrap.sh my-app --git
```

**With Mantine UI (instead of Tailwind):**

```bash
./vite-bootstrap.sh my-app --mantine --git
```

**With Mantine and development tools:**

```bash
./vite-bootstrap.sh my-app --mantine --git --eslint --prettier
```

**With development tools (Tailwind):**

```bash
./vite-bootstrap.sh my-app --git --eslint --prettier
```

**Without Firebase (lighter project):**

```bash
./vite-bootstrap.sh my-app --git --no-firebase
```

**Full setup with all optional tools:**

```bash
./vite-bootstrap.sh my-app --git --eslint --prettier
```

**Minimal setup (no optionals):**

```bash
./vite-bootstrap.sh my-app --no-firebase --no-router --no-typography
```

## 📖 Usage Instructions

### 1. Make the Script Executable (First Time Only)

```bash
chmod +x vite-bootstrap.sh
```

### 2. Run the Script

```bash
./vite-bootstrap.sh <project-name> [OPTIONS]
```

### 3. Navigate to Your Project

```bash
cd <project-name>
```

### 4. Start Development

```bash
npm run dev
```

The development server opens at `http://localhost:5173`

## 🔧 Command Line Options

| Option            | Description                                   | Default                  |
| ----------------- | --------------------------------------------- | ------------------------ |
| `--git`           | Initialize Git repository with first commit   | Disabled                 |
| `--eslint`        | Install and configure ESLint for code quality | Disabled                 |
| `--prettier`      | Install and configure Prettier for formatting | Disabled                 |
| `--mantine`       | Use Mantine UI instead of Tailwind CSS        | Disabled (uses Tailwind) |
| `--no-firebase`   | Skip Firebase installation                    | Installed                |
| `--no-router`     | Skip React Router installation                | Installed                |
| `--no-typography` | Skip Tailwind Typography plugin               | Installed                |
| `--overwrite`     | Overwrite existing project directory          | Disabled                 |
| `--help` or `-h`  | Display help information                      | —                        |

## 🎨 CSS Framework Comparison

### Tailwind CSS + daisyUI (Default)

**Best for:** Utility-first styling, maximum customization, lightweight projects

**Includes:**

- Tailwind CSS with Vite integration
- daisyUI component themes (Nord, Abyss, Cupcake, Dracula)
- Tailwind Typography plugin for prose styling
- ThemeContext for manual dark mode control

**Usage:**

```bash
./vite-bootstrap.sh my-app --git
```

**Key Features:**

- Utility-first approach for fine-grained control
- Pre-built daisyUI themes
- Manual theme switching via ThemeContext
- Smallest bundle size with tree-shaking

### Mantine UI

**Best for:** Component-driven development, rapid prototyping, built-in accessibility

**Includes:**

- @mantine/core with 100+ components
- @mantine/hooks for form, notifications, dialogs
- @mantine/form for form management
- @mantine/dates for date picking
- Built-in dark mode support
- TypeScript-first API

**Usage:**

```bash
./vite-bootstrap.sh my-app --mantine --git
```

**Key Features:**

- Pre-built, accessible components (Button, Card, Modal, etc.)
- Comprehensive hook library
- Built-in dark mode toggle
- Customizable theme system
- Form validation with @mantine/form
- Significantly larger bundle size

**Mantine Component Examples:**

```tsx
import { Button, Card, Title, Text, Group } from "@mantine/core";

export default function App() {
  return (
    <Card>
      <Title>Welcome</Title>
      <Text>Build with Mantine components</Text>
      <Group>
        <Button>Click me</Button>
        <Button variant="outline">Or me</Button>
      </Group>
    </Card>
  );
}
```

## 📁 Project Structure

```
my-app/
├── node_modules/           # Dependencies
├── public/                  # Static assets
├── src/
│   ├── App.tsx             # Root component with ThemeProvider or MantineProvider
│   ├── App.css             # App-specific styles
│   ├── main.tsx            # Application entry point
│   ├── index.css           # Global styles (Tailwind or Mantine)
│   ├── vite-env.d.ts       # Vite environment types
│   ├── components/
│   │   ├── AppContainer.tsx    # Max-width wrapper component
│   │   └── Menu.tsx            # Responsive navigation menu
│   └── ThemeContext/
│       └── index.tsx       # Dark/light theme toggle (Tailwind only)
├── vite.config.ts          # Vite configuration
├── postcss.config.ts       # PostCSS config (Mantine only)
├── tsconfig.json           # TypeScript configuration
├── package.json            # Project dependencies
├── .gitignore              # Git ignore rules
├── eslint.config.js        # ESLint rules (if --eslint)
├── .prettierrc.json        # Prettier config (if --prettier)
└── README.md               # Project documentation
```

## 🎨 Theme System

### Tailwind CSS Theme (Default)

The application includes a built-in theme system using React Context:

```typescript
// Use the theme in components
import { useContext } from "react";
import { ThemeContext } from "./ThemeContext";

export function MyComponent() {
  const { darkMode, setDarkMode } = useContext(ThemeContext);

  return (
    <button onClick={() => setDarkMode(darkMode === "dark" ? "light" : "dark")}>
      Toggle Theme
    </button>
  );
}
```

#### Available Themes

daisyUI provides multiple color themes:

- **nord** - Cool blue tones (default)
- **abyss** - Dark with blue accents
- **cupcake** - Pastel colors
- **dracula** - Dark with purple accents

#### Customize Themes

Edit `src/index.css`:

```css
@plugin "daisyui" {
  themes: nord light dark cupcake; /* Add or remove themes */
  include: ;
}
```

### Mantine UI Theme

Mantine includes built-in dark mode support without additional context:

```typescript
// Dark mode is built-in to Mantine
import { useMantineColorScheme } from "@mantine/core";

export function MyComponent() {
  const { colorScheme, toggleColorScheme } = useMantineColorScheme();

  return (
    <button onClick={() => toggleColorScheme()}>Current: {colorScheme}</button>
  );
}
```

#### Customize Mantine Theme

Edit your App component's theme object:

```typescript
const mantineTheme = {
  primaryColor: "blue",
  colors: {
    // Override default colors
  },
  spacing: {
    // Custom spacing
  },
};

<MantineProvider theme={mantineTheme}>{/* Your app */}</MantineProvider>;
```

See [Mantine Theme Documentation](https://mantine.dev/guides/getting-started/) for more options.

## 📦 Pre-built Components

### AppContainer

A max-width wrapper with consistent padding and background:

```typescript
import AppContainer from "./components/AppContainer";

export default function App() {
  return (
    <AppContainer>
      <h1>My Content</h1>
      <p>Centered content with max-width constraint</p>
    </AppContainer>
  );
}
```

### Menu

A responsive navigation component with toggle functionality:

```typescript
import Menu from "./components/Menu";

<Menu
  items={[
    { id: 1, name: "about" },
    { id: 2, name: "services" },
  ]}
/>;
```

Menu automatically:

- Shows hamburger menu on small screens
- Displays full menu on large screens
- Handles open/close toggle
- Links to sections using anchors

## 📚 Available npm Scripts

```bash
# Development
npm run dev          # Start Vite development server
npm run preview      # Preview production build locally

# Building
npm run build        # Build for production
npm run type-check   # Check TypeScript types

# Code Quality (if installed with --eslint)
npm run lint         # Run ESLint

# Code Formatting (if installed with --prettier)
npm run format       # Run Prettier
```

## 🔥 Firebase Setup (Optional)

If Firebase is installed, initialize it:

1. Create a Firebase project at [console.firebase.google.com](https://console.firebase.google.com)

2. Get your config object and create `src/firebase.ts`:

```typescript
import { initializeApp } from "firebase/app";
import { getAuth } from "firebase/auth";
import { getFirestore } from "firebase/firestore";

const firebaseConfig = {
  apiKey: "YOUR_API_KEY",
  authDomain: "your-app.firebaseapp.com",
  projectId: "your-project-id",
  storageBucket: "your-project.appspot.com",
  messagingSenderId: "123456789",
  appId: "1:123456789:web:abc123",
};

const app = initializeApp(firebaseConfig);
export const auth = getAuth(app);
export const db = getFirestore(app);
```

3. Use Firebase in your components:

```typescript
import { auth } from "./firebase";
import { signOut } from "firebase/auth";

const logout = () => signOut(auth);
```

## 🛣️ React Router Setup (Optional)

If React Router is installed, set up routing:

1. Create `src/pages/` directory with page components

2. Update `src/App.tsx`:

```typescript
import { BrowserRouter, Routes, Route } from "react-router-dom";
import Home from "./pages/Home";
import About from "./pages/About";

export default function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/about" element={<About />} />
      </Routes>
    </BrowserRouter>
  );
}
```

## 🧹 Code Quality Tools

### ESLint (Optional)

Installed with `--eslint` flag. Run checks:

```bash
npm run lint
```

Configuration: `eslint.config.js`

### Prettier (Optional)

Installed with `--prettier` flag. Format code:

```bash
npm run format
```

Configuration: `.prettierrc.json`

## 📝 TypeScript Configuration

TypeScript is pre-configured with:

- Strict mode enabled for type safety
- JSX support
- Modern ES2020 target
- Path aliases ready to use

Customize `tsconfig.json` for your needs.

## 🌐 Building for Production

```bash
# Create optimized production build
npm run build

# Preview the production build locally
npm run preview

# The build output is in the 'dist' folder
```

Vite automatically:

- Minifies code
- Optimizes assets
- Generates sourcemaps
- Creates performant bundles

## 🚨 Troubleshooting

### "Failed to create Vite project"

- Check Node.js is installed: `node --version`
- Check npm is installed: `npm --version`
- Try updating npm: `npm install -g npm@latest`

### "Failed to install dependencies"

- Delete `node_modules/` and `package-lock.json`
- Run `npm install` again
- Check internet connection

### "Failed to open VS Code"

- Install VS Code from [code.visualstudio.com](https://code.visualstudio.com)
- Or open manually: `cd my-app && code .`

### ESLint/Prettier not working

- Make sure you used `--eslint` and `--prettier` flags
- Clear node_modules: `rm -rf node_modules && npm install`

### Template files not found

- Ensure you run the script from the vite-bootstrap directory
- Check the `templates/` folder exists with all required files

## 📚 Learning Resources

- [Vite Documentation](https://vitejs.dev/)
- [React Documentation](https://react.dev/)
- [TypeScript Documentation](https://www.typescriptlang.org/)
- **Tailwind CSS Resources:**
  - [Tailwind CSS Documentation](https://tailwindcss.com/docs)
  - [daisyUI Components](https://daisyui.com/)
- **Mantine Resources:**
  - [Mantine Official Documentation](https://mantine.dev/)
  - [Mantine Components](https://mantine.dev/components/)
  - [Mantine Hooks](https://mantine.dev/hooks/)
- [Firebase Documentation](https://firebase.google.com/docs)

## 📝 Template Files

All configuration templates are stored in the `templates/` directory:

### Configuration Files

- `vite.config.ts` - Vite build configuration with Tailwind
- `vite.config.mantine.ts` - Vite build configuration for Mantine
- `postcss.config.ts` - PostCSS configuration (Mantine only)
- `.gitignore` - Files to ignore in Git
- `eslint.config.js` - ESLint configuration
- `.prettierrc.json` - Prettier formatting rules
- `.prettierignore` - Files to ignore in Prettier

### Source Files

- **Tailwind Version:**
  - `src/App.tsx` - Root component with ThemeProvider
  - `src/index.css` - Global styles with Tailwind directives
- **Mantine Version:**
  - `src/App.mantine.tsx` - Root component with MantineProvider
  - `src/index.mantine.css` - Global styles for Mantine

### Component Files

- `src/ThemeContext/index.tsx` - Dark mode theme context (Tailwind only)
- `src/components/AppContainer.tsx` - Wrapper component
- `src/components/Menu.tsx` - Navigation menu component

To customize templates, edit files in the `templates/` directory before running the script.

## 🔄 Script Flow Diagram

```
1. Validate Prerequisites
   └─ Node.js & npm installed?
   └─ Project name provided?

2. Parse Command Line Options
   └─ Store --git, --eslint, --prettier flags

3. Create Vite Project
   └─ npm create vite@latest

4. Install Base Dependencies
   └─ npm install

5. Install Optional Packages
   └─ React Router (--no-router)
   └─ Firebase (--no-firebase)
   └─ Tailwind Typography (--no-typography)

6. Copy Template Files
   └─ Configuration files
   └─ Component files
   └─ Style files

7. Install Dev Tools
   └─ ESLint (--eslint)
   └─ Prettier (--prettier)

8. Initialize Git (--git)
   └─ git init
   └─ First commit

9. Open in VS Code
   └─ code .

10. Display Summary
    └─ Next steps
    └─ Available commands
```

## 🤝 Contributing

To improve templates or scripts:

1. Edit files in the `templates/` directory
2. Test the script with your changes
3. Update this README if adding new features

## 📄 License

This bootstrap script is provided as-is for creating modern React applications.

## 🎓 Tips for Best Results

1. **Always use TypeScript** - It catches bugs before runtime
2. **Use the ThemeContext** - Provide dark mode to all users
3. **Keep components small** - One component per file in most cases
4. **Use Tailwind utilities** - Write less CSS, build faster
5. **Leverage daisyUI** - Pre-built components save time
6. **Set up ESLint/Prettier early** - Enforce consistent code style
7. **Test in production mode** - Run `npm run build && npm run preview`

## 🚀 Next Steps After Bootstrap

1. Install optional ESLint/Prettier: `npm install`
2. Customize theme in `src/index.css`
3. Replace default App.tsx content with your app
4. Create page/component structure in `src/`
5. Deploy to Vercel, Netlify, or your hosting provider

---

**Happy coding!** 🎉

For questions or issues, check the script comments in `vite-bootstrap.sh` for detailed explanations.

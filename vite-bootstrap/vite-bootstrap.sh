#!/bin/bash

# =========================================================
# VITE + REACT + TYPESCRIPT + FIREBASE + TAILWIND/MANTINE
# BOOTSTRAP SCRIPT
# ---------------------------------------------------------
# DESCRIPTION:
# This script automates the creation of a modern, production-ready
# React application with Vite, TypeScript, and your choice of:
# - Tailwind CSS with daisyUI components, OR
# - Mantine UI with built-in component library
# All template files are sourced from the ./templates directory,
# allowing for easy customization without modifying the script itself.
#
# USAGE:
# ./vite-bootstrap.sh <project-name> [OPTIONS]
#
# OPTIONS:
#   --git              Initialize Git repository with initial commit
#   --eslint           Install & configure ESLint for code linting
#   --prettier         Install & configure Prettier for code formatting
#   --mantine          Use Mantine UI instead of Tailwind CSS
#   --no-firebase      Skip Firebase installation
#   --no-router        Skip React Router installation
#   --no-typography    Skip Tailwind Typography plugin
#   --overwrite        Overwrite existing project directory
#   --help             Display this help message
#
# EXAMPLES:
#   ./vite-bootstrap.sh my-app
#   ./vite-bootstrap.sh my-app --git --eslint --prettier
#   ./vite-bootstrap.sh my-app --no-firebase
#   ./vite-bootstrap.sh my-app --mantine --git --eslint
#   ./vite-bootstrap.sh my-app --mantine --git --eslint --prettier --overwrite
#
# FEATURES:
# ✅ Creates Vite + React + TypeScript project
# ✅ Choose between Tailwind CSS or Mantine UI
# ✅ Tailwind CSS with daisyUI themes OR Mantine with pre-built components
# ✅ Sets up ThemeContext for dark mode support
# ✅ Provides pre-built AppContainer and Menu components
# ✅ Optional Firebase integration for backend services
# ✅ Optional React Router for multi-page applications
# ✅ Optional ESLint configuration for code quality
# ✅ Optional Prettier configuration for code formatting
# ✅ Optional Git initialization with first commit
# ✅ Opens project in VS Code upon completion
#
# TEMPLATE STRUCTURE:
# templates/
# ├── vite.config.ts              - Vite configuration with Tailwind
# ├── vite.config.mantine.ts      - Vite configuration for Mantine
# ├── postcss.config.ts           - PostCSS configuration for Mantine
# ├── eslint.config.js            - ESLint configuration
# ├── .prettierrc.json            - Prettier format rules
# ├── .prettierignore             - Prettier ignore patterns
# ├── .gitignore                  - Git ignore patterns
# └── src/
#     ├── App.tsx                 - Root component with ThemeProvider (Tailwind)
#     ├── App.mantine.tsx         - Root component with MantineProvider
#     ├── index.css               - Global styles with Tailwind directives
#     ├── index.mantine.css       - Global styles for Mantine
#     ├── ThemeContext/
#     │   └── index.tsx           - Theme context for dark/light mode
#     └── components/
#         ├── AppContainer.tsx    - Max-width wrapper component
#         └── Menu.tsx            - Responsive navigation menu
#
# PREREQUISITES:
# - Node.js (v18+) installed
# - npm (v9+) installed
# - VS Code (optional, for automatic project opening)
# - Git (optional, if using --git flag)
# =========================================================

set -e  # Exit on any error

# Capture the absolute path to this script before changing directories
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"


# =========================================================
# UTILITY FUNCTIONS
# =========================================================

# Display help information and exit
# Usage: show_help (automatically called with --help or -h)
show_help() {
  echo "$0 <project-name> [OPTIONS]"
  echo ""
  echo "OPTIONS:"
  echo "  --git          Initialize Git repository"
  echo "  --eslint       Install & configure ESLint"
  echo "  --prettier     Install & configure Prettier"
  echo "  --no-firebase  Skip Firebase installation"
  echo "  --no-router    Skip Router installation"
  echo "  --overwrite    Overwrite existing files (if any)"
  echo "  --help         Show this help message"
  exit 0
}

# Check if a command exists in the system PATH
# Usage: command_exists <command_name>
# Returns: 0 if exists, 1 if not found
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Log a step with timestamp to track progress
# Usage: log_step "Message describing the step"
# Output: [HH:MM:SS] Message describing the step
log_step() {
  echo ""
  echo "$(date '+[%H:%M:%S]') $1"
}

# Log and display an error, then exit with status 1
# Usage: log_error "Description of what failed"
# Output: ❌ ERROR: Description of what failed
log_error() {
  echo "❌ ERROR: $1" >&2
  exit 1
}

# =========================================================
# PREREQUISITE CHECKS
# =========================================================

# Node.js is required for npm and running the development server
if ! command_exists node; then
  log_error "Node.js is not installed. Please install Node.js from https://nodejs.org/"
fi

# npm is required to install dependencies and run scripts
if ! command_exists npm; then
  log_error "npm is not installed. Please install npm from https://nodejs.org/"
fi

# Check for help flag first before other validation
# This allows users to get help without providing a project name
if [[ " $* " =~ " --help " ]] || [[ " $* " =~ " -h " ]]; then
  show_help
fi

# =========================================================
# ARGUMENT VALIDATION
# =========================================================

# Project name is the first positional argument
# It will be used as the directory name
if [ -z "$1" ]; then
  echo "❌ ERROR: You must provide a project name."
  echo "✅ Usage: ./vite-bootstrap.sh my-app-name [OPTIONS]"
  echo "Use --help for more information."
  exit 1
fi

PROJECT_NAME=$1

# Check if project directory already exists unless --overwrite is specified
# This prevents accidental deletion or overwriting of existing projects
if [ -d "$PROJECT_NAME" ] && [[ ! " $* " =~ " --overwrite " ]]; then
  log_error "Directory '$PROJECT_NAME' already exists. Please choose a different name."
fi

# =========================================================
# OPTION FLAGS - Initialize all options with defaults
# =========================================================

# Default: Include Git initialization
INIT_GIT=false

# Default: Include ESLint (optional code quality tool)
INSTALL_ESLINT=false

# Default: Include Prettier (optional code formatter)
INSTALL_PRETTIER=false

# Default: Include Firebase (optional backend service)
INSTALL_FIREBASE=true

# Default: Include React Router (optional routing library)
INSTALL_ROUTER=true

# Default: Include Tailwind Typography plugin
INSTALL_TYPOGRAPHY=true

# Default: Use Tailwind CSS (not Mantine)
INSTALL_MANTINE=false

# Parse command line arguments to override defaults
# Iterate through all arguments after the project name
for arg in "$@"; do
  case $arg in
    --git)
      INIT_GIT=true
      ;;
    --eslint)
      INSTALL_ESLINT=true
      ;;
    --prettier)
      INSTALL_PRETTIER=true
      ;;
    --no-firebase)
      INSTALL_FIREBASE=false
      ;;
    --no-router)
      INSTALL_ROUTER=false
      ;;
    --no-typography)
      INSTALL_TYPOGRAPHY=false
      ;;
    --mantine)
      INSTALL_MANTINE=true
      ;;
  esac
done

# =========================================================
# PHASE 1: PROJECT CREATION AND DEPENDENCY INSTALLATION
# =========================================================

log_step "🚀 Navigating to parent folder to create: $PROJECT_NAME"
cd .. || log_error "Failed to navigate to parent directory" 

log_step "🚀 Creating Vite + React + TS project: $PROJECT_NAME"
# Using npm create vite with react-ts template for modern React with TypeScript
npm create vite@latest "$PROJECT_NAME" -- --template react-ts || log_error "Failed to create Vite project"

cd "$PROJECT_NAME" || log_error "Failed to navigate to project directory"

log_step "📦 Installing base dependencies..."
# Install the initial dependencies created by Vite template
npm install || log_error "Failed to install dependencies"

# =========================================================
# PHASE 2: OPTIONAL DEPENDENCY INSTALLATION
# =========================================================

# React Router enables client-side routing for multi-page applications
if [ "$INSTALL_ROUTER" = true ]; then
  log_step "🚦 Installing React Router..."
  npm install react-router || log_error "Failed to install React Router"
fi

# Firebase provides backend services (auth, database, storage, etc.)
if [ "$INSTALL_FIREBASE" = true ]; then
  log_step "🔥 Installing Firebase..."
  npm install firebase || log_error "Failed to install Firebase"
else
  log_step "⏭️  Skipping Firebase installation (--no-firebase flag set)"
fi

# Tailwind Typography plugin adds beautiful default styles for prose content
if [ "$INSTALL_TYPOGRAPHY" = true ] && [ "$INSTALL_MANTINE" = false ]; then
  log_step "📝 Installing Tailwind Typography plugin..."
  npm install -D @tailwindcss/typography || log_error "Failed to install Tailwind Typography"
else
  log_step "⏭️  Skipping Tailwind Typography installation (--no-typography flag set or using Mantine)"
fi

# Install either Tailwind CSS or Mantine UI
if [ "$INSTALL_MANTINE" = true ]; then
  log_step "🎨 Installing Mantine UI components and dependencies..."
  npm install @mantine/core @mantine/hooks @mantine/form @mantine/dates dayjs || log_error "Failed to install Mantine Core"
  npm install --save-dev postcss postcss-preset-mantine postcss-simple-vars || log_error "Failed to install Mantine PostCSS plugins"
else
  log_step "🎨 Installing Tailwind CSS + daisyUI..."
  npm install tailwindcss @tailwindcss/vite daisyui || log_error "Failed to install Tailwind CSS and daisyUI"
fi

# =========================================================
# PHASE 3: COPY TEMPLATE FILES FROM THE TEMPLATES DIRECTORY
# =========================================================

log_step "📋 Copying configuration files from templates..."
# Vite configuration - choose based on CSS framework
if [ "$INSTALL_MANTINE" = true ]; then
  cp "$SCRIPT_DIR/templates/vite.config.mantine.ts" vite.config.ts || log_error "Failed to copy Mantine Vite config"
  cp "$SCRIPT_DIR/templates/postcss.config.ts" postcss.config.ts || log_error "Failed to copy Mantine PostCSS config"
else
  cp "$SCRIPT_DIR/templates/vite.config.ts" vite.config.ts || log_error "Failed to copy Vite config"
fi

# =========================================================
# PHASE 4: CONFIGURE STYLES AND GLOBAL SETUP
# =========================================================

if [ "$INSTALL_MANTINE" = true ]; then
  log_step "🎨 Configuring Mantine UI..."
  cp "$SCRIPT_DIR/templates/src/index.mantine.css" src/index.css
else
  log_step "🎨 Configuring Tailwind CSS..."
  cp "$SCRIPT_DIR/templates/src/index.css" src/index.css
fi

# =========================================================
# PHASE 5: CREATE PROJECT DIRECTORY STRUCTURE
# =========================================================

log_step "📂 Creating folder structure..."
mkdir -p src/ || log_error "Failed to create src directory"
mkdir -p src/ThemeContext || log_error "Failed to create ThemeContext directory"
mkdir -p src/components || log_error "Failed to create components directory"

# =========================================================
# PHASE 6: COPY APPLICATION COMPONENTS AND FILES
# =========================================================

# Reset App.tsx to a clean container with ThemeProvider or MantineProvider and sample components
log_step "🗂️ Setting up root App component..."
if [ "$INSTALL_MANTINE" = true ]; then
  cp "$SCRIPT_DIR/templates/src/App.mantine.tsx" src/App.tsx
else
  cp "$SCRIPT_DIR/templates/src/App.tsx" src/App.tsx
fi

log_step "📦 Creating reusable UI components..." 
# AppContainer: Max-width wrapper with consistent padding and background
cp "$SCRIPT_DIR/templates/src/components/AppContainer.tsx" src/components/AppContainer.tsx

# Menu: Responsive navigation component with toggle functionality
cp "$SCRIPT_DIR/templates/src/components/Menu.tsx" src/components/Menu.tsx

# ThemeContext: Provides dark/light mode toggle capability to entire app
log_step "🌙 Setting up theme context for dark mode support..."
cp "$SCRIPT_DIR/templates/src/ThemeContext/index.tsx" src/ThemeContext/index.tsx

# =========================================================
# PHASE 7: OPTIONAL DEVELOPMENT TOOLS CONFIGURATION
# =========================================================

# ESLint helps identify and fix code quality issues
if [ "$INSTALL_ESLINT" = true ]; then
  log_step "🧪 Installing & configuring ESLint..."
  npm install --save-dev eslint eslint-plugin-react eslint-plugin-react-hooks eslint-plugin-react-refresh @typescript-eslint/eslint-plugin @typescript-eslint/parser || log_error "Failed to install ESLint"
  cp "$SCRIPT_DIR/templates/eslint.config.js" eslint.config.js
fi

# Prettier automatically formats code to maintain consistency
if [ "$INSTALL_PRETTIER" = true ]; then
  log_step "🎯 Installing & configuring Prettier..."
  npm install --save-dev prettier eslint-config-prettier eslint-plugin-prettier || log_error "Failed to install Prettier"
  cp "$SCRIPT_DIR/templates/.prettierrc.json" .prettierrc.json
  cp "$SCRIPT_DIR/templates/.prettierignore" .prettierignore
fi

# =========================================================
# PHASE 8: OPTIONAL GIT INITIALIZATION
# =========================================================

# Initialize Git repository and create initial commit
if [ "$INIT_GIT" = true ]; then
  log_step "🔧 Initialising Git repository..."
  git init || log_error "Failed to initialize Git"
  cp "$SCRIPT_DIR/templates/.gitignore" .gitignore
  git add . || log_error "Failed to stage files for Git"
  git commit -m "Initial Vite + React + TS setup" || log_error "Failed to create initial Git commit"
fi

# =========================================================
# PHASE 9: OPEN IN EDITOR
# =========================================================

# Automatically open the project in VS Code for immediate development
log_step "📝 Opening project in VS Code..."
code . || log_error "Failed to open VS Code"

# =========================================================
# ✅ BOOTSTRAP COMPLETE - SUMMARY AND NEXT STEPS
# =========================================================

log_step "✅ BOOTSTRAP COMPLETE!"
echo ""
echo "📋 Summary of installed packages:"
echo "   • Vite + React + TypeScript"
if [ "$INSTALL_MANTINE" = true ]; then
  echo "   • Mantine UI (component library)"
  echo "   • Mantine Hooks, Forms, Dates"
else
  echo "   • Tailwind CSS + daisyUI (ready with themes)"
  [ "$INSTALL_TYPOGRAPHY" = true ] && echo "   • Tailwind Typography"
fi
[ "$INSTALL_ROUTER" = true ] && echo "   • React Router"
[ "$INSTALL_FIREBASE" = true ] && echo "   • Firebase"
[ "$INSTALL_ESLINT" = true ] && echo "   • ESLint (configured)"
[ "$INSTALL_PRETTIER" = true ] && echo "   • Prettier (configured)"
[ "$INIT_GIT" = true ] && echo "   • Git (initialized with first commit)"
echo ""
echo "🚀 Next steps:"
echo "-----------------------------------"
echo "   cd $PROJECT_NAME"
echo "   npm run dev"
echo "-----------------------------------"
echo ""
echo "📚 Available commands:"
echo "   npm run dev        - Start development server (Vite)"
echo "   npm run build      - Build for production"
echo "   npm run preview    - Preview production build locally"
[ "$INSTALL_ESLINT" = true ] && echo "   npm run lint       - Run ESLint code quality checks"
echo ""
if [ "$INSTALL_MANTINE" = true ]; then
  echo "🎨 Mantine UI Documentation:"
  echo "   - Official Docs: https://mantine.dev"
  echo "   - Theme customization: https://mantine.dev/guides/getting-started/"
  echo "   - Dark mode is built-in"
else
  echo "🎨 Theme System:"
  echo "   - Light/Dark theme toggle via ThemeContext"
  echo "   - daisyUI themes: nord, abyss, cupcake, dracula"
  echo "   - Customize themes in src/index.css"
fi
echo ""
echo "📦 Components Available:"
echo "   - AppContainer: Max-width centered wrapper"
echo "   - Menu: Responsive navigation component"
echo "   - ThemeContext: Global theme state management"
echo ""
echo "Happy coding! 🎉"

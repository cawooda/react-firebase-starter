import {
  MantineProvider,
  Container,
  Box,
  Title,
  Text,
  Group,
  Button,
} from '@mantine/core';
import AppContainer from './components/AppContainer';
import Menu from './components/Menu';

import './App.css';

// Mantine App Component
// This component demonstrates Mantine UI usage with:
// - MantineProvider for theme configuration and dark mode support
// - Pre-built components: Container, Box, Title, Text, Group, Button
// - Responsive design with Mantine's breakpoint system
// - Integrated theme switching capability

const mantineTheme = {
  primaryColor: 'blue',
  fontFamily: 'system-ui, Avenir, Helvetica, Arial, sans-serif',
  headings: {
    fontFamily: 'system-ui, Avenir, Helvetica, Arial, sans-serif',
  },
};

export default function App() {
  return (
    <MantineProvider theme={mantineTheme}>
      <AppContainer>
        <Menu
          items={[
            { id: 1, name: 'about' },
            { id: 2, name: 'contact' },
          ]}
        />
        <Box component="article" p="lg">
          <Title order={1}>Welcome to your Mantine App</Title>
          <Text mt="md" size="lg">
            A modern React app with TypeScript and Mantine UI components.
          </Text>
          <Group mt="lg">
            <Button variant="filled">Get Started</Button>
            <Button variant="outline">Learn More</Button>
          </Group>
        </Box>
      </AppContainer>
    </MantineProvider>
  );
}

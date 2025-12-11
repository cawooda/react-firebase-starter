import { Routes, Route, Outlet } from "react-router-dom";
import "./App.css";
import { Container, Flex } from "@chakra-ui/react";
import LoginForm from "./components/LoginForm";
import { AuthProvider, useAuth } from "@/context/AuthContext";

import { ColorModeButton } from "@/components/ui/color-mode";

function App() {
  const { user, loading } = useAuth();
  return (
    <>
      <AuthProvider value={{ user, loading }}>
        <Container>
          <Flex direction="column" align="center" justify="center" minH="100vh">
            <ColorModeButton />
            <Routes>
              <Route path="/" element={<LoginForm />} />
              {/* <Route path="/signup" element={<Signup />} /> */}
            </Routes>
            <Outlet />
          </Flex>
        </Container>
      </AuthProvider>
    </>
  );
}

export default App;

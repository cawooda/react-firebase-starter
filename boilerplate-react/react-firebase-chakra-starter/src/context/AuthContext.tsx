// create a context for auth state and methods
import React, { createContext, useContext, useEffect, useState } from "react";
import { onAuthStateChanged, type User } from "firebase/auth";
import { auth } from "../lib/firebase";

// define the shape of the auth context
type AuthContextType = {
  user: User | null;
  loading: boolean;
};

// create the auth context
const AuthContext = createContext<AuthContextType>({
  user: null,
  loading: true,
});

// create a provider component
export const AuthProvider: React.FC<{ children: React.ReactNode }> = ({
  children,
}) => {
  const [user, setUser] = useState<User | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const unsubscribe = onAuthStateChanged(auth, (firebaseUser) => {
      setUser(firebaseUser);
      setLoading(false);
    });

    return () => unsubscribe();
  }, []);

  return (
    <AuthContext.Provider value={{ user, loading }}>
      {children}
    </AuthContext.Provider>
  );
};

// create a custom hook to use the auth context
export const useAuth = () => {
  return useContext(AuthContext);
};

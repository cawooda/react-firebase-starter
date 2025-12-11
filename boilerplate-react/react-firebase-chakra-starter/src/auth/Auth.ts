//handles login and signup logic with firebase

import {
  signInWithEmailAndPassword,
  createUserWithEmailAndPassword,
  type User,
} from "firebase/auth";
import { auth } from "../lib/firebase";

// Function to log in a user with email and password
export const login = async (email: string, password: string): Promise<User> => {
  const userCredential = await signInWithEmailAndPassword(
    auth,
    email,
    password
  );
  return userCredential.user;
};

// Function to sign up a new user with email and password
export const signup = async (
  email: string,
  password: string
): Promise<User> => {
  const userCredential = await createUserWithEmailAndPassword(
    auth,
    email,
    password
  );
  return userCredential.user;
};

// Function to log out the current user
export const logout = async (): Promise<void> => {
  await auth.signOut();
};

// Function to get the currently logged-in user
export const getCurrentUser = (): User | null => {
  return auth.currentUser;
};

export const signInWithGoogle = async () => {
  // Google sign-in logic to be implemented
};

export const signUpWithGoogle = async () => {
  // Google sign-up logic to be implemented
};

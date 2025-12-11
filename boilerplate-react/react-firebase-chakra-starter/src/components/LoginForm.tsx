import {
  Field,
  Input,
  Button,
  Heading,
  Image,
  Flex,
  Container,
  Text,
} from "@chakra-ui/react";
import { useState } from "react";
import Logo from "../assets/logo.png";
import { Link } from "react-router-dom";

// Define types for form fields and data
type LoginFormFields = {
  [key: string]: {
    label: string;
    type: string;
    placeholder?: string;
    required?: boolean;
  };
};

type LoginFormData = {
  email: string;
  password: string;
  onSubmit?: () => void;
};

// Configuration for the login form fields
const formFieldsConfig: LoginFormFields = {
  email: {
    label: "Email",
    type: "email",
    placeholder: "your@email.address",
    required: true,
  },
  password: {
    label: "Password",
    type: "password",
    placeholder: "Your secure password",
    required: true,
  },
  submit: {
    label: "Login",
    type: "submit",
  },
};

const loginFormData: LoginFormData = {
  email: "",
  password: "",
};

// LoginForm component
// Renders a login form with email and password fields
// the form is able to use and communicate with an AuthContext to set the user state upon successful login
// however the actual login logic is not implemented here
// this is just the form structure
// A user type should be imported from the firebase auth module

function googleSignin() {
  // Placeholder function for Google Sign-In
  console.log("Google Sign-In clicked");
}

function LoginForm() {
  const [fields, setFields] = useState(loginFormData);
  const handleInputChange = (event: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value } = event.target;
    setFields({
      ...fields,
      [name as keyof LoginFormData]: value,
    });
  };

  const handleFormSubmit = (event: any) => {
    event.preventDefault();
    // Handle form submission logic here
    console.log("Form submitted with data:", fields);
  };

  return (
    <Flex
      direction="column"
      align="center"
      justify="center"
      height="100vh"
      width="100vw"
    >
      <Image src={Logo} alt="Logo" width="10vw" pb={3} />
      <Heading mb={6}>Login</Heading>
      <form key="login-form" onSubmit={handleFormSubmit}>
        {Object.entries(formFieldsConfig).map(([name, config]) => {
          console.log(name, config);
          if (name !== "submit") {
            return (
              <Field.Root key={name} mb={4}>
                <Field.Label mb={2} htmlFor={name}>
                  {config.label}
                </Field.Label>
                <Input
                  name={name}
                  onChange={handleInputChange}
                  type={config.type}
                  placeholder={config.placeholder}
                  required={config.required}
                />
              </Field.Root>
            );
          } else {
            return (
              <Container>
                <Button type="submit" variant="outline">
                  {config.label}
                </Button>
                <Text mt={4} fontSize="sm">
                  Don't have an account?
                  <Link
                    to="/signup"
                    style={{ color: "blue.500", textDecoration: "underline" }}
                  >
                    Sign Up
                  </Link>
                </Text>
                <Link to="/auth/google">
                  <Button
                    type="button"
                    onSubmit={googleSignin}
                    variant="outline"
                  >
                    Sign in with Google
                  </Button>
                </Link>
              </Container>
            );
          }
        })}
      </form>
    </Flex>
  );
}

export default LoginForm;

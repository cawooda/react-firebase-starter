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
import { login, signup } from "../auth/Auth";

// Define types for form fields and data
export type SignupFormFields = {
  [key: string]: {
    label: string;
    type: string;
    placeholder?: string;
    required?: boolean;
  };
};

type SignupFormData = {
  firstName: string;
  lastName: string;
  email: string;
  password: string;
  onSubmit?: () => void;
};

// Configuration for the login form fields
const formFieldsConfig: SignupFormFields = {
  firstName: {
    label: "First Name",
    type: "text",
    placeholder: "Your first name",
    required: true,
  },
  lastName: {
    label: "Last Name",
    type: "text",
    placeholder: "Your last name",
    required: true,
  },
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
    label: "Sign Up",
    type: "submit",
  },
};

const signupFormData: SignupFormData = {
  firstName: "",
  lastName: "",
  email: "",
  password: "",
};

// LoginForm component
// Renders a login form with email and password fields
// the form is able to use and communicate with an AuthContext to set the user state upon successful login
// however the actual login logic is not implemented here
// this is just the form structure
// A user type should be imported from the firebase auth module

function googleSignUp() {
  console.log("Google Sign-In clicked");
}

function SignupForm() {
  const [fields, setFields] = useState(signupFormData);
  const handleInputChange = (event: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value } = event.target;
    setFields({
      ...fields,
      [name as keyof SignupFormData]: value,
    });
  };

  const handleFormSubmit = (event: any) => {
    event.preventDefault();
    signup(fields.email, fields.password);
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
      <Heading mb={6}>Sign Up</Heading>
      <form key="signup-form" onSubmit={handleFormSubmit}>
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
                  <Button type="button" variant="outline">
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

export default SignupForm;

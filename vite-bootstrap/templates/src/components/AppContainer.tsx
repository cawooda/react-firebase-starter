import { type ReactNode } from 'react';

export default function AppContainer({ children }: { children: ReactNode }) {
  return <div className="max-w-5xl bg-base-200 mx-auto p-6 ">{children}</div>;
}

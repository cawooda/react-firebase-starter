import { useState } from 'react';

type Item = {
  id: number;
  name: string;
};

type MenuProps = {
  items: Item[];
};

function Menu({ items }: MenuProps) {
  const [isOpen, setIsOpen] = useState(false);

  const toggleMenu = () => {
    setIsOpen(!isOpen);
  };

  if (isOpen)
    return (
      <nav>
        <ul>
          {items.map((item) => (
            <li key={item.id}>
              <a href={`#${item.name.toLocaleLowerCase()}`}>{item.name}</a>
            </li>
          ))}
        </ul>
        <button onClick={toggleMenu} aria-label="Close Menu">
          ✕
        </button>
      </nav>
    );
  else if (items.length === 0)
    return (
      <nav>
        <ul>
          <li>
            <a href="#home">Home</a>
          </li>
          <li>
            <a href="#about">About</a>
          </li>
          <li>
            <a href="#services">Services</a>
          </li>
          <li>
            <a href="#contact">Contact</a>
          </li>
        </ul>
      </nav>
    );
  else {
    return (
      <button onClick={toggleMenu} aria-label="Open Menu">
        ☰
      </button>
    );
  }
}
export default Menu;

const nullUnless = (element: JSX.Element, condition: boolean): JSX.Element | null => {
  return condition ? element : null;
};

const nullIf = (element: JSX.Element, condition: boolean): JSX.Element | null => {
  return nullUnless(element, !condition);
};

export { nullUnless, nullIf };

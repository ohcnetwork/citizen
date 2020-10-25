let str = React.string;

type state = {
  token: option(string),
  loading: bool,
};

type action =
  | SetToken(string);

let reducer = (state, action) =>
  switch (action) {
  | SetToken(token) => {...state, token: Some(token)}
  };

[@react.component]
let make = () => {
  let (state, send) =
    React.useReducer(reducer, {token: None, loading: false});
  <div className="bg-white h-full">
    <div className="max-w-7xl mx-auto px-4 sm:px-6 md:px-8 h-full">
      {switch (state.token) {
       | Some(token) => str(token)
       | None => <Patient__Login />
       }}
    </div>
  </div>;
};

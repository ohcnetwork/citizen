type t = {
  id: string,
  name: string,
  state: string,
};

let id = t => t.id;
let name = t => t.name;
let state = t => t.state;

let decode = json =>
  Json.Decode.{
    id: json |> field("id", string),
    name: json |> field("name", string),
    state: json |> field("state", string),
  };

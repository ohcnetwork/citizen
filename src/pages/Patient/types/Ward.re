type t = {
  id: string,
  name: string,
  number: int,
  localBody: int,
};

let id = t => t.id;
let name = t => t.name;
let number = t => t.number;
let localBody = t => t.localBody;

let decode = json =>
  Json.Decode.{
    id: json |> field("id", string),
    name: json |> field("name", string),
    number: json |> field("number", int),
    localBody: json |> field("local_body", int),
  };

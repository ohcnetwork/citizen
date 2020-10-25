type t = {
  id: string,
  name: string,
  district: int,
  bodyType: string,
};

let id = t => t.id;
let name = t => t.name;
let district = t => t.district;
let bodyType = t => t.bodyType;

let decode = json =>
  Json.Decode.{
    id: json |> field("id", string),
    name: json |> field("name", string),
    district: json |> field("district", int),
    bodyType: json |> field("body_type", string),
  };

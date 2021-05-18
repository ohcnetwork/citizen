type t = {
  id: string,
  name: string,
  facilityType: string,
  address: string,
  wardObject: option<Ward.t>,
  localBodyObject: option<LocalBody.t>,
  districtObject: option<District.t>,
}

let id = t => t.id
let name = t => t.name

let facilityType = t => t.facilityType
let address = t => t.address
let wardObject = t => t.wardObject
let localBodyObject = t => t.localBodyObject
let districtObject = t => t.districtObject

let decode = json => {
  open Json.Decode
  {
    id: json |> field("id", string),
    name: json |> field("name", string),
    facilityType: json |> field("facility_type", string),
    address: json |> field("address", string),
    wardObject: json |> field("ward_object", optional(Ward.decode)),
    localBodyObject: json |> field("local_body_object", optional(LocalBody.decode)),
    districtObject: json |> field("district_object", optional(District.decode)),
  }
}

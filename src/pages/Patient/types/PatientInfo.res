type t = {
  action: option<int>,
  address: string,
  age: int,
  bloodGroup: option<string>,
  dateOfBirth: string,
  emergencyPhoneNumber: string,
  diseaseStatus: string,
  gender: int,
  isActive: bool,
  id: string,
  isDeclaredPositive: option<bool>,
  isMigrantWorker: bool,
  modifiedDate: Js.Date.t,
  name: string,
  phoneNumber: string,
  pincode: option<int>,
  numberOfAgedDependents: int,
  numberOfChronicDiseasedDependents: int,
  willDonateBlood: option<bool>,
  facilityObject: option<Facility.t>,
  wardObject: option<Ward.t>,
  localBodyObject: option<LocalBody.t>,
  districtObject: option<District.t>,
}

let action = t => t.action
let address = t => t.address
let age = t => t.age
let bloodGroup = t => t.bloodGroup
let dateOfBirth = t => t.dateOfBirth
let emergencyPhoneNumber = t => t.emergencyPhoneNumber
let gender = t => t.gender
let isActive = t => t.isActive
let id = t => t.id
let isDeclaredPositive = t => t.isDeclaredPositive
let isMigrantWorker = t => t.isMigrantWorker
let modifiedDate = t => t.modifiedDate
let name = t => t.name
let phoneNumber = t => t.phoneNumber
let pincode = t => t.pincode
let numberOfAgedDependents = t => t.numberOfAgedDependents
let numberOfChronicDiseasedDependents = t => t.numberOfChronicDiseasedDependents
let willDonateBlood = t => t.willDonateBlood
let facilityObject = t => t.facilityObject
let wardObject = t => t.wardObject
let localBodyObject = t => t.localBodyObject
let districtObject = t => t.districtObject
let diseaseStatus = t => t.diseaseStatus

let decode = json => {
  open Json.Decode
  {
    action: json |> field("action", optional(int)),
    address: json |> field("address", string),
    age: json |> field("age", int),
    bloodGroup: json |> field("blood_group", optional(string)),
    dateOfBirth: json |> field("date_of_birth", string),
    diseaseStatus: json |> field("disease_status", string),
    emergencyPhoneNumber: json |> field("emergency_phone_number", string),
    gender: json |> field("gender", int),
    isActive: json |> field("is_active", bool),
    id: json |> field("id", string),
    isDeclaredPositive: json |> field("is_declared_positive", optional(bool)),
    isMigrantWorker: json |> field("is_migrant_worker", bool),
    modifiedDate: json |> field("modified_date", DateFns.decodeISO),
    name: json |> field("name", string),
    phoneNumber: json |> field("phone_number", string),
    pincode: json |> field("pincode", optional(int)),
    numberOfAgedDependents: json |> field("number_of_aged_dependents", int),
    numberOfChronicDiseasedDependents: json |> field("number_of_chronic_diseased_dependents", int),
    willDonateBlood: json |> field("will_donate_blood", optional(bool)),
    facilityObject: json |> field("facility_object", optional(Facility.decode)),
    wardObject: json |> field("ward_object", optional(Ward.decode)),
    localBodyObject: json |> field("local_body_object", optional(LocalBody.decode)),
    districtObject: json |> field("district_object", optional(District.decode)),
  }
}

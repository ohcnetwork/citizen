type covidStatus =
  | POSITIVE
  | SUSPECTED

let getStatusType = (status: string) => {
  switch status {
  | "POSITIVE" => POSITIVE
  | "SUSPECTED" => SUSPECTED
  |_ => SUSPECTED
  }
}

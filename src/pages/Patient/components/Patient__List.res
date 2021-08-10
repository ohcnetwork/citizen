let str = React.string

type ui =
  | Loading
  | Loaded
  | ShowPatient(PatientInfo.t)


type state = {
  ui: ui,
  patients: array<PatientInfo.t>,
}

let getStatusType = (status: string) => {
  switch status {
  | "POSITIVE" =>Patient__Types.POSITIVE
  | "SUSPECTED" => Patient__Types.SUSPECTED
  |_ => Patient__Types.SUSPECTED
  }
}

let statusLabel = (status: Patient__Types.covidStatus) => {
  switch status {
  | POSITIVE => "bg-red-100 border border-red-300 flex-shrink-0 leading-normal text-red-600 font-semibold px-3 py-px rounded"
  | SUSPECTED => "bg-yellow-100 border border-yellow-300 flex-shrink-0 leading-normal text-yellow-400 font-semibold px-3 py-px rounded"
  | _ => "bg-yellow-100 border border-yellow-300 flex-shrink-0 leading-normal text-yellow-400 font-semibold px-3 py-px rounded"
  }
}

let handleErrorCB = () => Js.log("Error")

let handleSucessCB = (send, response) => {
  let patients = response |> {
    open Json.Decode
    field("results", Json.Decode.array(PatientInfo.decode))
  }
  send(_ => {ui: Loaded, patients: patients})
}

let getPatientsList = (send, token) => {
  send(state => {...state, ui: Loading})
  Api.getWithToken(Routes.url("otp/patient/"), token, handleSucessCB(send), handleErrorCB)
}


let patientCardClasses = patient =>
  "flex flex-col md:flex-row items-start md:items-center justify-between bg-white border-l-3 p-3 md:py-6 md:px-5 mt-4 border-l-4 cursor-pointer rounded-r-lg shadow hover:border-primary-500 hover:text-primary-500 hover:shadow-md " ++ (
    PatientInfo.isActive(patient) ? "border-green-400" : "border-orange-400"
  )

let showPatientCard = (patient, send) =>
  <div
    key={PatientInfo.id(patient)}
    className={patientCardClasses(patient)}
    onClick={_ => send(state => {...state, ui: ShowPatient(patient)})}>
    <div className="w-full md:w-3/4">
      <div className="block text-sm md:pr-2">
        <span className="ml-1 font-semibold text-base">
          {str(PatientInfo.name(patient) ++ (" - " ++ string_of_int(PatientInfo.age(patient))))}
        </span>
      </div>
      <div className="mt-1 ml-px text-xs text-gray-900">
        <span className="ml-1">
          {"Last updated on " ++ PatientInfo.modifiedDate(patient)->DateFns.format("MMMM d, yyyy")
            |> str}
        </span>
      </div>
    </div>
    <div className="w-auto md:w-1/4 text-xs flex justify-end mt-2 md:mt-0">
      <div
        className={statusLabel(getStatusType(PatientInfo.diseaseStatus(patient)))}>
        {str(PatientInfo.diseaseStatus(patient))}
      </div>
    </div>
  </div>

@react.component
let make = (~token) => {
  let (state, send) = React.useState(() => {ui: Loading, patients: []})

  React.useEffect1(() => {
    getPatientsList(send, token)
    None
  }, [token])

  <div className="max-w-3xl mx-auto h-full">
    {switch state.ui {
    | Loading
    | Loaded =>
      <h1 className="pt-6 text-gray-700 font-semibold text-3xl"> {str("Medical Records")} </h1>
    | ShowPatient(_patientInfo) =>
      <div className="pt-4">
        <button
          onClick={_ => send(state => {...state, ui: Loaded})} className="btn btn-default mb-2">
          <i className="fas fa-arrow-left mr-2" /> {str("Back")}
        </button>
      </div>
    }}
    {switch state.ui {
    | Loading => SkeletonLoading.multiple(~count=3, ~element=SkeletonLoading.card())
    | Loaded =>
      state.patients |> Js.Array.map(patient => showPatientCard(patient, send)) |> React.array
    | ShowPatient(patientInfo) => <Patient__ShowPatient token patientInfo />
    }}
  </div>
}

let str = React.string

type state =
  | Loading
  | Loaded(Consultation.t)

let handleErrorCB = () => Js.log("Error")

let handleSucessCB = (send, response) => {
  Js.log(response)
  let patients = response |> {
    open Json.Decode
    field("last_consultation", Consultation.decode)
  }
  send(_ => Loaded(patients))
}

let getPatientDetails = (id, send, token) => {
  send(state => Loading)
  Api.getWithToken(
    Routes.url("otp/patient/" ++ (id ++ "/")),
    token,
    handleSucessCB(send),
    handleErrorCB,
  )
}

let symptomToString = symptom => {
  switch symptom {
  | 1 => "ASYMPTOMATIC"
  | 2 => "FEVER"
  | 3 => "SORE THROAT"
  | 4 => "COUGH"
  | 5 => "BREATHLESSNESS"
  | 6 => "MYALGIA"
  | 7 => "ABDOMINAL DISCOMFORT"
  | 8 => "VOMITING/DIARRHOEA"
  | 10 => "SARI"
  | 11 => "SPUTUM"
  | 12 => "NAUSEA"
  | 13 => "CHEST PAIN"
  | 14 => "HEMOPTYSIS"
  | 15 => "NASAL DISCHARGE"
  | 16 => "BODY ACHE"
  | _ => "OTHERS"
  }
}

let showConsultationCard = consultation => {
  <div className="rounded-lg shadow px-4 py-2 my-4">
    <div>
      <h3 className="text-lg leading-6 font-medium text-gray-900"> {str("Last Consultation")} </h3>
      {switch Consultation.admission_date(consultation) {
      | Some(date) =>
        <p className="max-w-2xl text-sm leading-5 text-gray-500">
          {str(`admission date: ${Js.Date.toDateString(date)}`)}
        </p>
      | None => React.null
      }}
    </div>
    <div className="mt-5 border-t border-gray-200 pt-4">
      <dl>
        <div className="sm:grid sm:grid-cols-3 sm:gap-4">
          <dt className="text-sm leading-5 font-medium text-gray-500"> {str("Facility Name:")} </dt>
          <dd className="mt-1 text-sm leading-5 text-gray-900 sm:mt-0 sm:col-span-2">
            {str(Consultation.facility_name(consultation))}
          </dd>
        </div>
        <div
          className="mt-8 sm:grid sm:mt-5 sm:grid-cols-3 sm:gap-4 sm:border-t sm:border-gray-200 sm:pt-5">
          <dt className="text-sm leading-5 font-medium text-gray-500"> {str("Admitted")} </dt>
          <dd className="mt-1 text-sm leading-5 text-gray-900 sm:mt-0 sm:col-span-2">
            {switch Consultation.admitted(consultation) {
            | true => str("Yes")
            | false => str("No")
            }}
          </dd>
        </div>
        {switch Consultation.discharge_date(consultation) {
        | Some(discharge) =>
          <div
            className="mt-8 sm:grid sm:mt-5 sm:grid-cols-3 sm:gap-4 sm:border-t sm:border-gray-200 sm:pt-5">
            <dt className="text-sm leading-5 font-medium text-gray-500">
              {str("Discharge Date")}
            </dt>
            <dd className="mt-1 text-sm leading-5 text-gray-900 sm:mt-0 sm:col-span-2">
              {str(Js.Date.toDateString(discharge))}
            </dd>
          </div>
        | None => React.null
        }}
        {switch Consultation.consultation_notes(consultation) {
        | Some(notes) =>
          <div
            className="mt-8 sm:grid sm:mt-5 sm:grid-cols-3 sm:gap-4 sm:border-t sm:border-gray-200 sm:pt-5">
            <dt className="text-sm leading-5 font-medium text-gray-500">
              {str("Consultation Notes")}
            </dt>
            <dd className="mt-1 text-sm leading-5 text-gray-900 sm:mt-0 sm:col-span-2">
              {str(notes)}
            </dd>
          </div>
        | None => React.null
        }}
        {switch Consultation.category(consultation) {
        | Some(category) =>
          <div
            className="mt-8 sm:grid sm:mt-5 sm:grid-cols-3 sm:gap-4 sm:border-t sm:border-gray-200 sm:pt-5">
            <dt className="text-sm leading-5 font-medium text-gray-500"> {str("Category")} </dt>
            <dd className="mt-1 text-sm leading-5 text-gray-900 sm:mt-0 sm:col-span-2">
              {str(category)}
            </dd>
          </div>
        | None => React.null
        }}
        {switch Consultation.bed_number(consultation) {
        | Some(bed) =>
          <div
            className="mt-8 sm:grid sm:mt-5 sm:grid-cols-3 sm:gap-4 sm:border-t sm:border-gray-200 sm:pt-5">
            <dt className="text-sm leading-5 font-medium text-gray-500"> {str("Bed Number")} </dt>
            <dd className="mt-1 text-sm leading-5 text-gray-900 sm:mt-0 sm:col-span-2">
              {str(bed)}
            </dd>
          </div>
        | None => React.null
        }}
        {switch Consultation.examination_details(consultation) {
        | Some(examination) =>
          <div
            className="mt-8 sm:grid sm:mt-5 sm:grid-cols-3 sm:gap-4 sm:border-t sm:border-gray-200 sm:pt-5">
            <dt className="text-sm leading-5 font-medium text-gray-500">
              {str("Examination Details")}
            </dt>
            <dd className="mt-1 text-sm leading-5 text-gray-900 sm:mt-0 sm:col-span-2">
              {str(examination)}
            </dd>
          </div>
        | None => React.null
        }}
        <div
          className="mt-8 sm:grid sm:mt-5 sm:grid-cols-3 sm:gap-4 sm:border-t sm:border-gray-200 sm:pt-5">
          <dt className="text-sm leading-5 font-medium text-gray-500"> {str("Symptoms")} </dt>
          <dd className="mt-1 text-sm leading-5 text-gray-900 sm:mt-0 sm:col-span-2">
            {str(
              Consultation.symptoms(consultation) |> Js.Array.reduce(
                (acc, symptom) => acc ++ symptomToString(symptom) ++ " ",
                "",
              ),
            )}
          </dd>
        </div>
      </dl>
    </div>
  </div>
}

let showPatientCard = (patient, send) => {
  Js.log(patient)
  <div key={PatientInfo.id(patient)} className="rounded-lg shadow px-4 py-2 mt-4">
    <div>
      <h3 className="text-lg leading-6 font-medium text-gray-900"> {str("General")} </h3>
      <p className="max-w-2xl text-sm leading-5 text-gray-500"> {str("Demographic data")} </p>
    </div>
    <div className="mt-5 border-t border-gray-200 pt-4">
      <dl>
        <div className="sm:grid sm:grid-cols-3 sm:gap-4">
          <dt className="text-sm leading-5 font-medium text-gray-500"> {str("Date of Birth")} </dt>
          <dd className="mt-1 text-sm leading-5 text-gray-900 sm:mt-0 sm:col-span-2">
            {str(PatientInfo.dateOfBirth(patient))}
          </dd>
        </div>
        <div
          className="mt-8 sm:grid sm:mt-5 sm:grid-cols-3 sm:gap-4 sm:border-t sm:border-gray-200 sm:pt-5">
          <dt className="text-sm leading-5 font-medium text-gray-500"> {str("Mobile Number")} </dt>
          <dd className="mt-1 text-sm leading-5 text-gray-900 sm:mt-0 sm:col-span-2">
            {str(PatientInfo.phoneNumber(patient))}
          </dd>
        </div>
        <div
          className="mt-8 sm:grid sm:mt-5 sm:grid-cols-3 sm:gap-4 sm:border-t sm:border-gray-200 sm:pt-5">
          <dt className="text-sm leading-5 font-medium text-gray-500"> {str("Blood Group")} </dt>
          <dd className="mt-1 text-sm leading-5 text-gray-900 sm:mt-0 sm:col-span-2">
            {str(PatientInfo.bloodGroup(patient)->Belt.Option.getWithDefault("-"))}
          </dd>
        </div>
        <div
          className="mt-8 sm:grid sm:mt-5 sm:grid-cols-3 sm:gap-4 sm:border-t sm:border-gray-200 sm:pt-5">
          <dt className="text-sm leading-5 font-medium text-gray-500">
            {str("Emergency Contact number")}
          </dt>
          <dd className="mt-1 text-sm leading-5 text-gray-900 sm:mt-0 sm:col-span-2">
            {str(PatientInfo.emergencyPhoneNumber(patient))}
          </dd>
        </div>
        <div
          className="mt-8 sm:grid sm:mt-5 sm:grid-cols-3 sm:gap-4 sm:border-t sm:border-gray-200 sm:pt-5">
          <dt className="text-sm leading-5 font-medium text-gray-500"> {str("Address")} </dt>
          <dd
            className="mt-1 text-sm leading-5 text-gray-900 sm:mt-0 sm:col-span-2 whitespace-pre-wrap">
            {str(PatientInfo.address(patient))}
            {PatientInfo.pincode(patient)->Belt.Option.mapWithDefault(React.null, p =>
              <div> {str("Pincode: " ++ string_of_int(p))} </div>
            )}
            {PatientInfo.districtObject(patient)->Belt.Option.mapWithDefault(React.null, p =>
              <div> {str("District: " ++ District.name(p))} </div>
            )}
            {PatientInfo.localBodyObject(patient)->Belt.Option.mapWithDefault(React.null, p =>
              <div> {str("District: " ++ LocalBody.name(p))} </div>
            )}
            {PatientInfo.wardObject(patient)->Belt.Option.mapWithDefault(React.null, p =>
              <div> {str("District: " ++ Ward.name(p))} </div>
            )}
          </dd>
        </div>
        <div
          className="mt-8 sm:grid sm:mt-5 sm:grid-cols-3 sm:gap-4 sm:border-t sm:border-gray-200 sm:pt-5">
          <dt className="text-sm leading-5 font-medium text-gray-500"> {str("Gender")} </dt>
          <dd
            className="mt-1 text-sm leading-5 text-gray-900 sm:mt-0 sm:col-span-2 whitespace-pre-wrap">
            {str(
              switch PatientInfo.gender(patient) {
              | 1 => "Male"
              | 2 => "Female"
              | _ => ""
              },
            )}
          </dd>
        </div>
        <div
          className="mt-8 sm:grid sm:mt-5 sm:grid-cols-3 sm:gap-4 sm:border-t sm:border-gray-200 sm:pt-5">
          <dt className="text-sm leading-5 font-medium text-gray-500">
            {str("Number Of Aged Dependents")}
          </dt>
          <dd
            className="mt-1 text-sm leading-5 text-gray-900 sm:mt-0 sm:col-span-2 whitespace-pre-wrap">
            {str(string_of_int(PatientInfo.numberOfAgedDependents(patient)))}
          </dd>
        </div>
        <div
          className="mt-8 sm:grid sm:mt-5 sm:grid-cols-3 sm:gap-4 sm:border-t sm:border-gray-200 sm:pt-5">
          <dt className="text-sm leading-5 font-medium text-gray-500">
            {str("Number Of Chronic Diseased Dependents")}
          </dt>
          <dd
            className="mt-1 text-sm leading-5 text-gray-900 sm:mt-0 sm:col-span-2 whitespace-pre-wrap">
            {str(string_of_int(PatientInfo.numberOfChronicDiseasedDependents(patient)))}
          </dd>
        </div>
        {switch PatientInfo.facilityObject(patient) {
        | Some(facility) =>
          <div
            className="mt-8 sm:grid sm:mt-5 sm:grid-cols-3 sm:gap-4 sm:border-t sm:border-gray-200 sm:pt-5">
            <dt className="text-sm leading-5 font-medium text-gray-500">
              {str("Last visited facility")}
            </dt>
            <dd
              className="mt-1 text-sm leading-5 text-gray-900 sm:mt-0 sm:col-span-2 whitespace-pre-wrap">
              {str(Facility.name(facility))}
            </dd>
          </div>
        | None => React.null
        }}
        {switch PatientInfo.willDonateBlood(patient) {
        | Some(willDonateBlood) =>
          <div
            className="mt-8 sm:grid sm:mt-5 sm:grid-cols-3 sm:gap-4 sm:border-t sm:border-gray-200 sm:pt-5">
            <dt className="text-sm leading-5 font-medium text-gray-500">
              {str("Willing to Donate Blood")}
            </dt>
            <dd
              className="mt-1 text-sm leading-5 text-gray-900 sm:mt-0 sm:col-span-2 whitespace-pre-wrap">
              {str(willDonateBlood ? "Yes" : "No")}
            </dd>
          </div>
        | None => React.null
        }}
        {switch PatientInfo.isDeclaredPositive(patient) {
        | Some(isDeclaredPositive) =>
          <div
            className="mt-8 sm:grid sm:mt-5 sm:grid-cols-3 sm:gap-4 sm:border-t sm:border-gray-200 sm:pt-5">
            <dt className="text-sm leading-5 font-medium text-gray-500">
              {str("Has been declared postive")}
            </dt>
            <dd
              className="mt-1 text-sm leading-5 text-gray-900 sm:mt-0 sm:col-span-2 whitespace-pre-wrap">
              {str(isDeclaredPositive ? "Yes" : "No")}
            </dd>
          </div>
        | None => React.null
        }}
      </dl>
      <div
        className="mt-8 sm:grid sm:mt-5 sm:grid-cols-3 sm:gap-4 sm:border-t sm:border-gray-200 sm:pt-5">
        <dt className="text-sm leading-5 font-medium text-gray-500"> {str("Covid-19 Status")} </dt>
        <dd
          className="mt-1 text-sm leading-5 text-gray-900 sm:mt-0 sm:col-span-2 whitespace-pre-wrap">
          {str(PatientInfo.diseaseStatus(patient))}
        </dd>
      </div>
    </div>
  </div>
}

@react.component
let make = (~patientInfo, ~token) => {
  let (state, send) = React.useState(() => Loading)

  React.useEffect1(() => {
    getPatientDetails(PatientInfo.id(patientInfo), send, token)
    None
  }, [token])

  <div className="max-w-3xl mx-auto h-full">
    <div className="bg-yellow-50 border-l-4 border-yellow-400 p-4 mt-2">
      <div className="flex">
        <div className="flex-shrink-0"> <i className="text-yellow-700 fas fa-check" /> </div>
        <div className="ml-3">
          <p className="text-sm leading-5 text-yellow-700">
            {str(
              "Share your medical records with the hospital by sharing your phone number and date of birth.",
            )}
          </p>
        </div>
      </div>
    </div>
    <h1 className="pt-6 text-gray-700 font-semibold text-3xl">
      {str(PatientInfo.name(patientInfo))}
    </h1>
    <div className="font-mono text-xs"> {str("Unique Id: " ++ PatientInfo.id(patientInfo))} </div>
    {showPatientCard(patientInfo, send)}
    {switch state {
    | Loading => SkeletonLoading.multiple(~count=3, ~element=SkeletonLoading.card())
    | Loaded(consultation) => <div> {showConsultationCard(consultation)} </div>
    }}
  </div>
}

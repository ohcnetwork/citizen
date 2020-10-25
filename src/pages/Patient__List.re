let str = React.string;

type state = {
  loading: bool,
  patients: array(string),
};

let handleErrorCB = () => {
  Js.log("Error");
};

let handleSucessCB = (send, data) => Js.log(data);

let getPatientsList = (send, token) => {
  Api.getWithToken(
    Routes.url("otp/patient/"),
    token,
    handleSucessCB(send),
    handleErrorCB,
  );
};

[@react.component]
let make = (~token) => {
  let (state, send) = React.useState(() => {loading: false, patients: [||]});

  React.useEffect1(
    () => {
      getPatientsList(send, token);
      None;
    },
    [|token|],
  );

  <div className=" h-full">
    <h1> {str("Patients")} </h1>
    {state.loading
       ? <div> {str("loading")} </div>
       : state.patients
         |> Array.mapi((i, a) => <div> {str(a)} </div>)
         |> React.array}
  </div>;
};

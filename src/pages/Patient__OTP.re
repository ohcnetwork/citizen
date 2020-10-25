let str = React.string;

[@react.component]
let make = (~token) => {
  let (patientList, setPatientList) = React.useState(() => [||]);
  <div className="md:flex items-center h-full"> {str("otp")} </div>;
};

let str = React.string
let loginImage: string = %raw("require('./images/login.png')")

type ui =
  | Login
  | VerifyOtp

type state = {
  ui: ui,
  saving: bool,
  phone: string,
  otp: string,
}

type action =
  | SetLogin
  | SetVerifyOtp
  | SetSaving
  | ClearSaving
  | OtpSend
  | SetPhone(string)
  | SetOTP(string)

let reducer = (state, action) =>
  switch action {
  | SetPhone(phone) => {...state, phone: phone}
  | SetOTP(otp) => {...state, otp: otp}
  | SetLogin => {...state, ui: Login}
  | SetVerifyOtp => {...state, ui: VerifyOtp}
  | SetSaving => {...state, saving: true}
  | ClearSaving => {...state, saving: false}
  | OtpSend => {...state, ui: VerifyOtp, saving: false}
  }

let initalState = () => {ui: Login, saving: false, phone: "", otp: ""}

let handlePhoneChange = (send, event) => send(SetPhone(ReactEvent.Form.target(event)["value"]))

let handleErrorCB = (send, _error) => send(ClearSaving)

let handleGetOtpSuccess = (send, _response) => send(OtpSend)

let handleVerifyOtpSuccess = (_send, updateTokenCB, response) => {
  let token = response |> {
    open Json.Decode
    field("access", string)
  }
  updateTokenCB(token)
}

let verifyOtp = (state, send, updateTokenCB) => {
  let payload = Js.Dict.empty()
  Js.Dict.set(payload, "phone_number", Js.Json.string("+91" ++ state.phone))
  Js.Dict.set(payload, "otp", Js.Json.string(state.otp))

  let url = Routes.url("otp/token/login/")
  send(SetSaving)

  Api.create(url, payload, handleVerifyOtpSuccess(send, updateTokenCB), handleErrorCB(send))
}

let getOtp = (state, send) => {
  let payload = Js.Dict.empty()
  Js.Dict.set(payload, "phone_number", Js.Json.string("+91" ++ state.phone))

  let url = Routes.url("otp/token/")
  send(SetSaving)

  Api.create(url, payload, handleGetOtpSuccess(send), handleErrorCB(send))
}

let renderLogin = (state, send) =>
  <div>
    <label htmlFor="phone" className="block text-sm font-medium leading-5 text-gray-700">
      {str("Enter your registered Mobile Number")}
    </label>
    <div className="mt-2 rounded-md shadow-sm flex items-center">
      <span
        className="px-3 py-2 mr-1 border border-gray-300 rounded-md placeholder-gray-400 focus:outline-none focus:shadow-outline-blue focus:border-blue-300 transition duration-150 ease-in-out sm:text-sm sm:leading-5">
        {str("+91")}
      </span>
      <input
        id="phone"
        type_="number"
        placeholder="8888888888"
        required=true
        maxLength=10
        onChange={handlePhoneChange(send)}
        className="appearance-none block w-full px-3 py-2 border border-gray-300 rounded-md placeholder-gray-400 focus:outline-none focus:shadow-outline-blue focus:border-blue-300 transition duration-150 ease-in-out sm:text-sm sm:leading-5"
      />
    </div>
    <div className="pt-6">
      <span className="block w-full rounded-md shadow-sm">
        <button
          disabled=state.saving
          onClick={_ => getOtp(state, send)}
          className="w-full flex justify-center py-2 px-4 border border-transparent text-sm font-medium rounded-md text-white bg-green-500 hover:bg-green-400 focus:outline-none focus:border-indigo-700 focus:shadow-outline-indigo active:bg-indigo-700 transition duration-150 ease-in-out">
          {str("Get One Time Password")}
        </button>
      </span>
    </div>
  </div>

let handleOtpChange = (send, event) => send(SetOTP(ReactEvent.Form.target(event)["value"]))

let renderVerifyOtp = (state, send, updateTokenCB) =>
  <div>
    <label htmlFor="otp" className="block text-sm font-medium leading-5 text-gray-700">
      {str("Enter your one time password")}
    </label>
    <div className="mt-2 rounded-md shadow-sm flex items-center">
      <input
        id="otp"
        placeholder="5 digit otp"
        required=true
        maxLength=5
        onChange={handleOtpChange(send)}
        className="appearance-none block w-full px-3 py-2 border border-gray-300 rounded-md placeholder-gray-400 focus:outline-none focus:shadow-outline-blue focus:border-blue-300 transition duration-150 ease-in-out sm:text-sm sm:leading-5"
      />
    </div>
    <div className="pt-6">
      <span className="block w-full rounded-md shadow-sm">
        <button
          disabled={state.saving || String.length(String.trim(state.otp)) < 5}
          onClick={_ => verifyOtp(state, send, updateTokenCB)}
          className="w-full flex justify-center py-2 px-4 border border-transparent text-sm font-medium rounded-md text-white bg-green-500 hover:bg-green-400 focus:outline-none focus:border-indigo-700 focus:shadow-outline-indigo active:bg-indigo-700 transition duration-150 ease-in-out">
          {str("Sign in")}
        </button>
      </span>
    </div>
  </div>

@react.component
let make = (~updateTokenCB) => {
  let (state, send) = React.useReducer(reducer, initalState())
  <div className="md:flex items-center h-full">
    <div className="relative py-6 md:w-1/2">
      <div className="relative pb-1/2">
        <img className="absolute h-full w-full object-cover rounded-lg shadow" src=loginImage />
      </div>
    </div>
    <div className="max-w-sm mx-auto md:w-1/2">
      <div className="md:px-6 md:pt-4">
        <div className="font-bold text-xl text-gray-700 text-center mt-6">
          {"Patient Login" |> str}
        </div>
        {switch state.ui {
        | Login =>
          <p className="text-gray-600 text-base text-center mt-2">
            {"We will send you an " |> str}
            <strong> {str("One Time Password ")} </strong>
            {str("on this mobile number")}
          </p>
        | VerifyOtp =>
          <p className="text-gray-600 text-base text-center mt-2">
            {"We have send you a " |> str}
            <strong> {str("One Time Password ")} </strong>
            {str("to +91" ++ state.phone)}
          </p>
        }}
      </div>
      <div className="md:px-6 pt-6">
        {switch state.ui {
        | Login => renderLogin(state, send)
        | VerifyOtp => renderVerifyOtp(state, send, updateTokenCB)
        }}
      </div>
    </div>
  </div>
}

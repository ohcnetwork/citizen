let str = React.string;
let loginImage: string = [%raw "require('./images/login.png')"];

type ui =
  | Login
  | VerifyOtp;

type state = {
  ui,
  token: option(string),
  loading: bool,
  phone: string,
  otp: string,
};

type action =
  | SetToken(string)
  | SetLogin
  | SetVerifyOtp
  | SetPhone(string)
  | SetOTP(string);

let reducer = (state, action) =>
  switch (action) {
  | SetPhone(phone) => {...state, phone}
  | SetOTP(otp) => {...state, otp}
  | SetToken(token) => {...state, token: Some(token)}
  | SetLogin => {...state, ui: Login}
  | SetVerifyOtp => {...state, ui: VerifyOtp}
  };

[@react.component]
let make = () =>
  <div className="md:flex items-center h-full">
    <div className="relative py-6 md:w-1/2">
      <div className="relative pb-1/2">
        <img
          className="absolute h-full w-full object-cover rounded-lg shadow"
          src=loginImage
        />
      </div>
    </div>
    <div className="max-w-sm mx-auto md:w-1/2">
      <div className="md:px-6 pt-4">
        <div className="font-bold text-xl mb-2 text-gray-700 text-center">
          {"OTP Verification" |> str}
        </div>
        <p className="text-gray-600 text-base text-center">
          {"We will send you an " |> str}
          <strong> {str("One Time Password")} </strong>
          {str("on this mobile number")}
        </p>
      </div>
      <div className="md:px-6 pt-10">
        <div>
          <label
            htmlFor="phone"
            className="block text-sm font-medium leading-5 text-gray-700">
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
              className="appearance-none block w-full px-3 py-2 border border-gray-300 rounded-md placeholder-gray-400 focus:outline-none focus:shadow-outline-blue focus:border-blue-300 transition duration-150 ease-in-out sm:text-sm sm:leading-5"
            />
          </div>
          <div className="mt-6">
            <span className="block w-full rounded-md shadow-sm">
              <button
                disabled=false
                className="w-full flex justify-center py-2 px-4 border border-transparent text-sm font-medium rounded-md text-white bg-green-500 hover:bg-green-400 focus:outline-none focus:border-indigo-700 focus:shadow-outline-indigo active:bg-indigo-700 transition duration-150 ease-in-out">
                {str("Sign in")}
              </button>
            </span>
          </div>
        </div>
      </div>
    </div>
  </div>;

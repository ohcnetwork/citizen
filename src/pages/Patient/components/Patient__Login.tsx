import React, { useReducer } from 'react';
import { create } from '../../../shared/utils/Api';
import { url } from '../../../routes/Routes';

const loginImage = require('./images/login.png');

type UIState = 'Login' | 'VerifyOtp';

interface State {
  ui: UIState;
  saving: boolean;
  phone: string;
  otp: string;
}

type Action =
  | { type: 'SetLogin' }
  | { type: 'SetVerifyOtp' }
  | { type: 'SetSaving' }
  | { type: 'ClearSaving' }
  | { type: 'OtpSend' }
  | { type: 'SetPhone'; phone: string }
  | { type: 'SetOTP'; otp: string };

const reducer = (state: State, action: Action): State => {
  switch (action.type) {
    case 'SetPhone':
      return { ...state, phone: action.phone };
    case 'SetOTP':
      return { ...state, otp: action.otp };
    case 'SetLogin':
      return { ...state, ui: 'Login' };
    case 'SetVerifyOtp':
      return { ...state, ui: 'VerifyOtp' };
    case 'SetSaving':
      return { ...state, saving: true };
    case 'ClearSaving':
      return { ...state, saving: false };
    case 'OtpSend':
      return { ...state, ui: 'VerifyOtp', saving: false };
    default:
      return state;
  }
};

const initialState: State = { ui: 'Login', saving: false, phone: '', otp: '' };

const handlePhoneChange = (dispatch: React.Dispatch<Action>, event: React.ChangeEvent<HTMLInputElement>) =>
  dispatch({ type: 'SetPhone', phone: event.target.value });

const handleErrorCB = (dispatch: React.Dispatch<Action>) => dispatch({ type: 'ClearSaving' });

const handleGetOtpSuccess = (dispatch: React.Dispatch<Action>) => dispatch({ type: 'OtpSend' });

const handleVerifyOtpSuccess = (updateTokenCB: (token: string) => void, response: any) => {
  const token = response.access;
  updateTokenCB(token);
};

const verifyOtp = (state: State, dispatch: React.Dispatch<Action>, updateTokenCB: (token: string) => void) => {
  const payload = {
    phone_number: `+91${state.phone}`,
    otp: state.otp,
  };

  const requestUrl = url('otp/token/login/');
  dispatch({ type: 'SetSaving' });

  create(requestUrl, payload, (response) => handleVerifyOtpSuccess(updateTokenCB, response), () => handleErrorCB(dispatch));
};

const getOtp = (state: State, dispatch: React.Dispatch<Action>) => {
  const payload = {
    phone_number: `+91${state.phone}`,
  };

  const requestUrl = url('otp/token/');
  dispatch({ type: 'SetSaving' });

  create(requestUrl, payload, () => handleGetOtpSuccess(dispatch), () => handleErrorCB(dispatch));
};

const renderLogin = (state: State, dispatch: React.Dispatch<Action>) => (
  <div>
    <label htmlFor="phone" className="block text-sm font-medium leading-5 text-gray-700">
      Enter your registered Mobile Number
    </label>
    <div className="mt-2 rounded-md shadow-sm flex items-center">
      <span className="px-3 py-2 mr-1 border border-gray-300 rounded-md placeholder-gray-400 focus:outline-none focus:shadow-outline-blue focus:border-blue-300 transition duration-150 ease-in-out sm:text-sm sm:leading-5">
        +91
      </span>
      <input
        id="phone"
        type="number"
        placeholder="8888888888"
        required
        maxLength={10}
        onChange={(e) => handlePhoneChange(dispatch, e)}
        className="appearance-none block w-full px-3 py-2 border border-gray-300 rounded-md placeholder-gray-400 focus:outline-none focus:shadow-outline-blue focus:border-blue-300 transition duration-150 ease-in-out sm:text-sm sm:leading-5"
      />
    </div>
    <div className="pt-6">
      <span className="block w-full rounded-md shadow-sm">
        <button
          disabled={state.saving}
          onClick={() => getOtp(state, dispatch)}
          className="w-full flex justify-center py-2 px-4 border border-transparent text-sm font-medium rounded-md text-white bg-green-500 hover:bg-green-400 focus:outline-none focus:border-indigo-700 focus:shadow-outline-indigo active:bg-indigo-700 transition duration-150 ease-in-out"
        >
          Get One Time Password
        </button>
      </span>
    </div>
  </div>
);

const handleOtpChange = (dispatch: React.Dispatch<Action>, event: React.ChangeEvent<HTMLInputElement>) =>
  dispatch({ type: 'SetOTP', otp: event.target.value });

const renderVerifyOtp = (state: State, dispatch: React.Dispatch<Action>, updateTokenCB: (token: string) => void) => (
  <div>
    <label htmlFor="otp" className="block text-sm font-medium leading-5 text-gray-700">
      Enter your one time password
    </label>
    <div className="mt-2 rounded-md shadow-sm flex items-center">
      <input
        id="otp"
        placeholder="5 digit otp"
        required
        maxLength={5}
        onChange={(e) => handleOtpChange(dispatch, e)}
        className="appearance-none block w-full px-3 py-2 border border-gray-300 rounded-md placeholder-gray-400 focus:outline-none focus:shadow-outline-blue focus:border-blue-300 transition duration-150 ease-in-out sm:text-sm sm:leading-5"
      />
    </div>
    <div className="pt-6">
      <span className="block w-full rounded-md shadow-sm">
        <button
          disabled={state.saving || state.otp.trim().length < 5}
          onClick={() => verifyOtp(state, dispatch, updateTokenCB)}
          className="w-full flex justify-center py-2 px-4 border border-transparent text-sm font-medium rounded-md text-white bg-green-500 hover:bg-green-400 focus:outline-none focus:border-indigo-700 focus:shadow-outline-indigo active:bg-indigo-700 transition duration-150 ease-in-out"
        >
          Sign in
        </button>
      </span>
    </div>
  </div>
);

interface PatientLoginProps {
  updateTokenCB: (token: string) => void;
}

export const Patient__Login: React.FC<PatientLoginProps> = ({ updateTokenCB }) => {
  const [state, dispatch] = useReducer(reducer, initialState);

  return (
    <div className="md:flex items-center h-full">
      <div className="relative py-6 md:w-1/2">
        <div className="relative pb-1/2">
          <img className="absolute h-full w-full object-cover rounded-lg shadow" src={loginImage} />
        </div>
      </div>
      <div className="max-w-sm mx-auto md:w-1/2">
        <div className="md:px-6 md:pt-4">
          <div className="font-bold text-xl text-gray-700 text-center mt-6">Patient Login</div>
          {state.ui === 'Login' ? (
            <p className="text-gray-600 text-base text-center mt-2">
              We will send you an <strong>One Time Password </strong> on this mobile number
            </p>
          ) : (
            <p className="text-gray-600 text-base text-center mt-2">
              We have sent you a <strong>One Time Password </strong> to +91{state.phone}
            </p>
          )}
        </div>
        <div className="md:px-6 pt-6">
          {state.ui === 'Login' ? renderLogin(state, dispatch) : renderVerifyOtp(state, dispatch, updateTokenCB)}
        </div>
      </div>
    </div>
  );
};

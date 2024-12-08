import React, { useReducer } from 'react';
import { Patient__List } from './Patient__List';
import { Patient__Login } from './Patient__Login';
import { Storage } from '../../../routes/Storage';

type State = {
  token: string | null;
  loading: boolean;
};

type Action = { type: 'SetToken'; token: string };

const reducer = (state: State, action: Action): State => {
  switch (action.type) {
    case 'SetToken':
      return { ...state, token: action.token };
    default:
      return state;
  }
};

const updateToken = (dispatch: React.Dispatch<Action>, token: string) => {
  Storage.setToken(token);
  dispatch({ type: 'SetToken', token });
};

export const Patient__Root: React.FC = () => {
  const [state, dispatch] = useReducer(reducer, { token: Storage.getToken(), loading: false });

  return (
    <div className="bg-white h-full">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 md:px-8 h-full">
        {state.token ? (
          <Patient__List token={state.token} />
        ) : (
          <Patient__Login updateTokenCB={(token) => updateToken(dispatch, token)} />
        )}
      </div>
    </div>
  );
};

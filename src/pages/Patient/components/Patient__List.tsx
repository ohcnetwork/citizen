import React, { useState, useEffect } from 'react';
import { getWithToken } from '../../../shared/utils/Api';
import { url } from '../../../routes/Routes';
import { PatientInfo, Patient__Types } from '../types';
import { SkeletonLoading } from '../../../shared/components/SkeletonLoading';
import { Patient__ShowPatient } from './Patient__ShowPatient';

type UIState = 'Loading' | 'Loaded' | 'ShowPatient';

interface State {
  ui: UIState;
  patients: PatientInfo[];
}

const statusLabel = (status: Patient__Types.covidStatus) => {
  switch (status) {
    case 'POSITIVE':
      return 'bg-red-100 border border-red-300 flex-shrink-0 leading-normal text-red-600 font-semibold px-3 py-px rounded';
    case 'SUSPECTED':
      return 'bg-yellow-100 border border-yellow-300 flex-shrink-0 leading-normal text-yellow-400 font-semibold px-3 py-px rounded';
    default:
      return 'bg-yellow-100 border border-yellow-300 flex-shrink-0 leading-normal text-yellow-400 font-semibold px-3 py-px rounded';
  }
};

const handleErrorCB = () => console.log('Error');

const handleSuccessCB = (setState: React.Dispatch<React.SetStateAction<State>>, response: any) => {
  const patients = response.results.map((patient: any) => PatientInfo.decode(patient));
  setState({ ui: 'Loaded', patients });
};

const getPatientsList = (setState: React.Dispatch<React.SetStateAction<State>>, token: string) => {
  setState((state) => ({ ...state, ui: 'Loading' }));
  getWithToken(url('otp/patient/'), token, (response) => handleSuccessCB(setState, response), handleErrorCB);
};

const patientCardClasses = (patient: PatientInfo) =>
  `flex flex-col md:flex-row items-start md:items-center justify-between bg-white border-l-3 p-3 md:py-6 md:px-5 mt-4 border-l-4 cursor-pointer rounded-r-lg shadow hover:border-primary-500 hover:text-primary-500 hover:shadow-md ${
    PatientInfo.isActive(patient) ? 'border-green-400' : 'border-orange-400'
  }`;

const showPatientCard = (patient: PatientInfo, setState: React.Dispatch<React.SetStateAction<State>>) => (
  <div
    key={PatientInfo.id(patient)}
    className={patientCardClasses(patient)}
    onClick={() => setState((state) => ({ ...state, ui: 'ShowPatient', patients: [patient] }))}
  >
    <div className="w-full md:w-3/4">
      <div className="block text-sm md:pr-2">
        <span className="ml-1 font-semibold text-base">
          {PatientInfo.name(patient)} - {PatientInfo.age(patient)}
        </span>
      </div>
      <div className="mt-1 ml-px text-xs text-gray-900">
        <span className="ml-1">Last updated on {new Date(PatientInfo.modifiedDate(patient)).toLocaleDateString()}</span>
      </div>
    </div>
    <div className="w-auto md:w-1/4 text-xs flex justify-end mt-2 md:mt-0">
      <div className={statusLabel(Patient__Types.getStatusType(PatientInfo.diseaseStatus(patient)))}>
        {PatientInfo.diseaseStatus(patient)}
      </div>
    </div>
  </div>
);

interface PatientListProps {
  token: string;
}

export const Patient__List: React.FC<PatientListProps> = ({ token }) => {
  const [state, setState] = useState<State>({ ui: 'Loading', patients: [] });

  useEffect(() => {
    getPatientsList(setState, token);
  }, [token]);

  return (
    <div className="max-w-3xl mx-auto h-full">
      {state.ui === 'Loading' || state.ui === 'Loaded' ? (
        <h1 className="pt-6 text-gray-700 font-semibold text-3xl">Medical Records</h1>
      ) : (
        <div className="pt-4">
          <button onClick={() => setState((state) => ({ ...state, ui: 'Loaded' }))} className="btn btn-default mb-2">
            <i className="fas fa-arrow-left mr-2" /> Back
          </button>
        </div>
      )}
      {state.ui === 'Loading' ? (
        <SkeletonLoading multiple count={3} element={SkeletonLoading.card()} />
      ) : state.ui === 'Loaded' ? (
        state.patients.map((patient) => showPatientCard(patient, setState))
      ) : (
        <Patient__ShowPatient token={token} patientInfo={state.patients[0]} />
      )}
    </div>
  );
};

import React, { useState } from 'react';
import { useRouter } from 'next/router';
import Image from 'next/image';
import PatientRoot from './pages/Patient/components/PatientRoot';
import RRT from './pages/rrt/RRT';
import Landing from './pages/Landing/Landing';
import Storage from './routes/Storage';

const buttonClasses = (isActive: boolean) =>
  `w-full group flex items-center px-2 py-2 text-base leading-6 font-medium text-gray-600 rounded-md hover:text-gray-900 hover:bg-gray-50 focus:outline-none transition ease-in-out duration-150 ${
    isActive ? 'text-green-700' : ''
  }`;

const actions = (url: string) => {
  const current = url.includes('patients') ? 'patients' : url.includes('rrt') ? 'rrt' : '';
  return [
    <button
      key="home"
      onClick={() => router.push('/')}
      className="w-full group flex items-center px-2 py-2 text-base leading-6 font-medium text-gray-600 rounded-md hover:text-gray-900 hover:bg-gray-50 focus:outline-none focus:text-gray-900 focus:bg-gray-100 transition ease-in-out duration-150"
    >
      <i className="fas fa-home mr-2" /> Home
    </button>,
    <button
      key="patients"
      onClick={() => router.push('/patients')}
      className={buttonClasses(current === 'patients')}
    >
      <i className="fas fa-book-medical mr-2" /> Medical Records
    </button>,
    <a key="rrt" href="http://rrt.coronasafe.network/" className={buttonClasses(false)}>
      <i className="fas fa-tachometer-alt mr-2" /> RRT Directory
    </a>,
    <a key="dashboard" href="https://dashboard.coronasafe.network" className={buttonClasses(false)}>
      <i className="fas fa-tachometer-alt mr-2" /> Care Dashboard
    </a>,
    Storage.getToken() ? (
      <button
        key="logout"
        onClick={() => {
          Storage.deleteToken();
          router.push('/');
        }}
        className={buttonClasses(false)}
      >
        <i className="fas fa-sign-out-alt mr-2" /> Log Out
      </button>
    ) : null,
  ];
};

const Home: React.FC = () => {
  const [showNav, setShowNav] = useState(false);
  const router = useRouter();
  const url = router.pathname;

  return (
    <div className="h-screen flex overflow-hidden bg-gray-100">
      {showNav ? (
        <div className="md:hidden">
          <div className="fixed inset-0 flex z-40">
            <div className="fixed inset-0">
              <div className="absolute inset-0 bg-gray-600 opacity-75" />
            </div>
            <div className="relative flex-1 flex flex-col max-w-xs w-full pt-5 pb-4 bg-white">
              <div className="absolute top-0 right-0 -mr-14 p-1">
                <button className="flex items-center justify-center h-12 w-12 rounded-full focus:outline-none focus:bg-gray-600" />
              </div>
              <div className="flex-shrink-0 flex justify-between items-center px-4">
                <div className="flex-shrink-0 flex items-center">
                  <Image className="h-16 w-auto mr-2" src="/assets/logo.png" alt="Citizen" />
                </div>
                <button className="btn" onClick={() => setShowNav(!showNav)}>
                  <i className="fas fa-times" />
                </button>
              </div>
              <div className="mt-5 flex-1 h-0 overflow-y-auto">
                <nav className="px-2 space-y-1">{actions(url)}</nav>
              </div>
            </div>
            <div className="flex-shrink-0 w-14" />
          </div>
        </div>
      ) : null}
      <div className="hidden md:flex md:flex-shrink-0">
        <div className="flex flex-col w-64">
          <div className="flex flex-col flex-grow border-r border-gray-200 pt-5 pb-4 bg-white overflow-y-auto">
            <div className="flex items-end flex-shrink-0 px-4 mx-auto">
              <Image className="h-16 w-auto mr-2" src="/assets/logo.png" alt="Citizen" />
            </div>
            <div className="mt-5 flex-grow flex flex-col">
              <nav className="flex-1 px-4 bg-white space-y-1">{actions(url)}</nav>
            </div>
          </div>
        </div>
      </div>
      <div className="flex flex-col w-0 flex-1 overflow-hidden">
        <div className="md:hidden relative z-10 flex-shrink-0 flex h-16 bg-white shadow justify-between">
          <div className="flex-shrink-0 flex p-2">
            <Image className="h-12 w-auto mr-2" src="/assets/logo.png" alt="Citizen" />
          </div>
          <button
            onClick={() => setShowNav(!showNav)}
            className="px-4 text-gray-500 focus:outline-none focus:bg-gray-100 focus:text-gray-600 md:hidden"
          >
            <svg className="h-6 w-6" stroke="currentColor" fill="none" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M4 6h16M4 12h16M4 18h7" />
            </svg>
          </button>
        </div>
        <main className="flex-1 relative overflow-y-auto focus:outline-none bg-white">
          {url.includes('patients') ? (
            <PatientRoot />
          ) : url.includes('rrt') ? (
            <RRT />
          ) : (
            <Landing />
          )}
        </main>
      </div>
    </div>
  );
};

export default Home;

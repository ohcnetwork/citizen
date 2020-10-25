let str = React.string;
let logo: string = [%raw "require('./assets/logo.png')"];

[@react.component]
let make = () => {
  let (showNav, setShowNav) = React.useState(() => false);
  let url = ReasonReactRouter.useUrl();

  <div className="h-screen flex overflow-hidden bg-gray-100">
    // <!-- Off-canvas menu htmlFor mobile, show/hide based on off-canvas menu state. -->

      {showNav
         ? <div className="md:hidden">
             <div className="fixed inset-0 flex z-40">
               // <!--
               //   Off-canvas menu overlay, show/hide based on off-canvas menu state.
               //   Entering: "transition-opacity ease-linear duration-300"
               //     From: "opacity-0"
               //     To: "opacity-100"
               //   Leaving: "transition-opacity ease-linear duration-300"
               //     From: "opacity-100"
               //     To: "opacity-0"
               // -->

                 <div className="fixed inset-0">
                   <div className="absolute inset-0 bg-gray-600 opacity-75" />
                 </div>
                 // <!--
                 //   Off-canvas menu, show/hide based on off-canvas menu state.
                 //   Entering: "transition ease-in-out duration-300 transform"
                 //     From: "-translate-x-full"
                 //     To: "translate-x-0"
                 //   Leaving: "transition ease-in-out duration-300 transform"
                 //     From: "translate-x-0"
                 //     To: "-translate-x-full"
                 // -->
                 <div
                   className="relative flex-1 flex flex-col max-w-xs w-full pt-5 pb-4 bg-white">
                   <div className="absolute top-0 right-0 -mr-14 p-1">
                     <button
                       className="flex items-center justify-center h-12 w-12 rounded-full focus:outline-none focus:bg-gray-600"
                       // <svg className="h-6 w-6 text-white" stroke="currentColor" fill="none" viewBox="0 0 24 24">
                       //   <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                       // </svg>
                     />
                   </div>
                   <div
                     className="flex-shrink-0 flex justify-between items-center px-4">
                     <div className="flex-shrink-0 flex items-center">
                       <img
                         className="h-12 w-auto mr-2"
                         src=logo
                         alt="Ayushma"
                       />
                       <div className="text-xl font-semibold text-gray-700" />
                       {str("Ayushma")}
                     </div>
                     <button
                       className="btn" onClick={_ => setShowNav(nav => !nav)}>
                       <i className="fas fa-times" />
                     </button>
                   </div>
                   <div className="mt-5 flex-1 h-0 overflow-y-auto">
                     <nav className="px-2 space-y-1">
                       <button
                         href="#"
                         onClick={_ => ReasonReactRouter.push("./")}
                         className="w-full group flex items-center px-2 py-2 text-base leading-6 font-medium text-gray-600 rounded-md hover:text-gray-900 hover:bg-gray-50 focus:outline-none focus:text-gray-900 focus:bg-gray-100 transition ease-in-out duration-150">
                         {str("Dashboard")}
                       </button>
                       <button
                         href="#"
                         onClick={_ => ReasonReactRouter.push("/patients")}
                         className="w-full group flex items-center px-2 py-2 text-base leading-6 font-medium text-gray-600 rounded-md hover:text-gray-900 hover:bg-gray-50 focus:outline-none focus:text-gray-900 focus:bg-gray-100 transition ease-in-out duration-150">
                         {str("Patients")}
                       </button>
                     </nav>
                   </div>
                 </div>
                 <div
                   className="flex-shrink-0 w-14"
                   // <!-- Dummy element to force sidebar to shrink to fit close icon -->
                 />
               </div>
           </div>
         : React.null}
      // <!-- Static sidebar htmlFor desktop -->
      <div className="hidden md:flex md:flex-shrink-0">
        <div className="flex flex-col w-64">
          // <!-- Sidebar component, swap this element with another sidebar if you like -->

            <div
              className="flex flex-col flex-grow border-r border-gray-200 pt-5 pb-4 bg-white overflow-y-auto">
              <div className="flex items-end flex-shrink-0 px-4">
                <img className="h-12 w-auto mr-2" src=logo alt="Ayushma" />
                <div className="text-xl font-semibold text-gray-700">
                  {str("Ayushma")}
                </div>
              </div>
              <div className="mt-5 flex-grow flex flex-col">
                <nav className="flex-1 px-2 bg-white space-y-1">
                  <button
                    href="#"
                    onClick={_ => ReasonReactRouter.push("./")}
                    className="w-full group flex items-center px-2 py-2 text-base leading-6 font-medium text-gray-600 rounded-md hover:text-gray-900 hover:bg-gray-50 focus:outline-none focus:text-gray-900 focus:bg-gray-100 transition ease-in-out duration-150">
                    {str("Dashboard")}
                  </button>
                  <button
                    href="#"
                    onClick={_ => ReasonReactRouter.push("/patients")}
                    className="w-full group flex items-center px-2 py-2 text-base leading-6 font-medium text-gray-600 rounded-md hover:text-gray-900 hover:bg-gray-50 focus:outline-none focus:text-gray-900 focus:bg-gray-100 transition ease-in-out duration-150">
                    {str("Patients")}
                  </button>
                </nav>
              </div>
            </div>
          </div>
      </div>
      <div className="flex flex-col w-0 flex-1 overflow-hidden">
        <div
          className="md:hidden relative z-10 flex-shrink-0 flex h-16 bg-white shadow">
          <button
            onClick={_ => setShowNav(nav => !nav)}
            className="px-4 text-gray-500 focus:outline-none focus:bg-gray-100 focus:text-gray-600 md:hidden">
            <svg
              className="h-6 w-6"
              stroke="currentColor"
              fill="none"
              viewBox="0 0 24 24">
              <path
                strokeLinecap="round"
                strokeLinejoin="round"
                strokeWidth="2"
                d="M4 6h16M4 12h16M4 18h7"
              />
            </svg>
          </button>
        </div>
        <main className="flex-1 relative overflow-y-auto focus:outline-none">
          {switch (url.path) {
           | ["patients"] => <Patient__Root />
           | _ => React.null
           }}
        </main>
      </div>
    </div>;
};

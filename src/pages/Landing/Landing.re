let str = React.string;
let landingImg: string = [%raw "require('./assets/landing.png')"];
let medicalRecordImg: string = [%raw "require('./assets/medicalRecord.png')"];
let schoolImg: string = [%raw "require('./assets/school.png')"];
let bedsImg: string = [%raw "require('./assets/beds.png')"];
let rrtImg: string = [%raw "require('./assets/rrt.png')"];
let keralaImg: string = [%raw "require('./assets/kerala.png')"];

let showPage = (title, description, image, link, externalLink) => {
  <div className="w-full px-3 lg:px-5 md:w-1/2 mt-6 md:mt-10">
    <div
      className="flex overflow-hidden shadow bg-white rounded-lg flex-col h-full">
      <div className="relative">
        <div className="relative pb-1/2 bg-gray-200">
          <img
            alt=title
            className="absolute h-full w-full object-cover"
            src=image
          />
        </div>
        <div
          className="landing-page__title-container absolute w-full flex items-center h-16 bottom-0 z-50">
          <h4
            className="landing-page__title text-white font-semibold leading-tight pl-6 pr-4 text-lg md:text-xl">
            {str(title)}
          </h4>
        </div>
      </div>
      <div className="flex flex-col justify-between h-full">
        <div
          className="landing-page__description text-sm px-6 pt-6 w-full leading-relaxed">
          {str(description)}
        </div>
        <div className="flex w-full p-6 justify-center">
          {externalLink
             ? <a className="w-full btn btn-primary" target="blank" href=link>
                 <i className="fas fa-external-link-alt mr-2" />
                 {str(title)}
               </a>
             : <a className="w-full btn btn-primary" href=link>
                 <i className="fas fa-eye mr-2" />
                 {str(title)}
               </a>}
        </div>
      </div>
    </div>
  </div>;
};

[@react.component]
let make = () => {
  <div className="mx-auto">
    <div>
      <div className="relative pb-1/2 md:pb-1/3">
        <img className="absolute h-full w-full object-cover" src=landingImg />
      </div>
    </div>
    <div className="mx-auto max-w-5xl">
      <h1 className="text-3xl md:text-5xl mt-4 font-black text-center">
        {str("Together we fight")}
      </h1>
      <p className="-mt-1 text-sm font-sans text-center">
        {str("Powered by Coronasafe")}
      </p>
      <div className="flex flex-wrap flex-1 lg:-mx-5 ">
        {showPage(
           "Access Medical Record",
           "Login an access the details of your consultation details and testing data from care",
           medicalRecordImg,
           "/patients",
           false,
         )}
        {showPage(
           "Capacity Dashboard",
           "Realtime bed capacity dashboard from care that sources data directly from the hospitals",
           bedsImg,
           "https://dashboard.coronasafe.network",
           true,
         )}
        {showPage(
           "RRT Directory",
           "A curated directory of RRT members in kerala",
           rrtImg,
           "https://dashboard.coronasafe.network",
           false,
         )}
        {showPage(
           "Kerala Dashboard",
           "Daily Covid summary and district wise split of cases, confirmed, recovered, isolation, hospitalization, home isolation, etc",
           keralaImg,
           "https://keralamap.coronasafe.network/",
           true,
         )}
        {showPage(
           "Coronasafe School",
           "The school offers smart online courses, touching upon various subjects like healthcare, disaster management etc. to a wide range of audience from High School students to medical professionals. All of these courses are available without any fees to interested individuals.",
           schoolImg,
           "link",
           true,
         )}
      </div>
    </div>
  </div>;
};

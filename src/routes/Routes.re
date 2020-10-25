let baseUrl = () => {
  "https://careapi.coronasafe.in/api/v1/";
};

let url = path => {
  baseUrl() ++ path;
};

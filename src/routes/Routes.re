let baseUrl = () => {
  "/api/v1/";
};

let url = path => {
  baseUrl() ++ path;
};

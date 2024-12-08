import { Fetch } from "fetch";
import { Notification } from "../Notification";
import { PromiseUtils } from "../PromiseUtils";
import { Routes } from "../../routes/Routes";

type ApiError = {
  title: string;
};

const apiErrorTitle = (error: ApiError) => {
  switch (error.title) {
    case "UnexpectedResponse":
      return error.title;
    default:
      return "An unexpected error occurred";
  }
};

const acceptOrRejectResponse = (response: Response) => {
  if (response.ok || response.status === 422) {
    return response.json();
  } else {
    return Promise.reject({ title: "UnexpectedResponse", status: response.status });
  }
};

const handleResponseError = (error: any) => {
  const title = apiErrorTitle(error);
  Notification.error(
    title,
    "Our team has been notified of this error. Please reload the page and try again."
  );
};

const handleResponseJSON = (
  json: any,
  responseCB: (json: any) => void,
  errorCB: () => void,
  notify: boolean
) => {
  const error = json.error;
  if (error) {
    if (notify) Notification.error("Something went wrong!", error);
    errorCB();
  } else {
    responseCB(json);
  }
};

const handleResponse = (
  responseCB: (json: any) => void,
  errorCB: () => void,
  notify: boolean = true,
  promise: Promise<Response>
) => {
  promise
    .then((response) => acceptOrRejectResponse(response))
    .then((json) => handleResponseJSON(json, responseCB, errorCB, notify))
    .catch((error) => {
      errorCB();
      console.log(error);
      if (notify) handleResponseError(error);
    });
};

const sendPayload = (
  url: string,
  payload: any,
  responseCB: (json: any) => void,
  errorCB: () => void,
  method: string
) => {
  fetch(url, {
    method,
    body: JSON.stringify(payload),
    headers: { "Content-Type": "application/json" },
    credentials: "same-origin",
  }).then((response) => handleResponse(responseCB, errorCB, true, Promise.resolve(response)));
};

const sendFormData = (
  url: string,
  formData: FormData,
  responseCB: (json: any) => void,
  errorCB: () => void
) => {
  fetch(url, {
    method: "POST",
    body: formData,
    credentials: "same-origin",
  }).then((response) => handleResponse(responseCB, errorCB, true, Promise.resolve(response)));
};

const get = (url: string, responseCB: (json: any) => void, errorCB: () => void) => {
  fetch(url).then((response) => handleResponse(responseCB, errorCB, true, Promise.resolve(response)));
};

const create = (url: string, payload: any, responseCB: (json: any) => void, errorCB: () => void) => {
  sendPayload(url, payload, responseCB, errorCB, "POST");
};

const update = (url: string, payload: any, responseCB: (json: any) => void, errorCB: () => void) => {
  sendPayload(url, payload, responseCB, errorCB, "PATCH");
};

const getWithToken = (
  url: string,
  token: string,
  responseCB: (json: any) => void,
  errorCB: () => void
) => {
  fetch(url, {
    method: "GET",
    headers: { authorization: `Bearer ${token}` },
    credentials: "same-origin",
  }).then((response) => handleResponse(responseCB, errorCB, true, Promise.resolve(response)));
};

export { get, create, update, getWithToken, sendFormData };

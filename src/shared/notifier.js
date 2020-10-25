import {
  alert,
  notice,
  info,
  success,
  error,
  defaultModules,
} from "@pnotify/core";

import "@pnotify/core/dist/PNotify.css";
import "@pnotify/core/dist/BrightTheme.css";
import * as PNotifyMobile from "@pnotify/mobile";
import "@pnotify/mobile/dist/PNotifyMobile.css";

defaultModules.set(PNotifyMobile, {});

const notify = (title, text, type) => {
  const options = { title: title, text: text };
  switch (type) {
    case "alert":
      alert(options);
      break;
    case "notice":
      notice(options);
      break;
    case "info":
      info(options);
      break;
    case "success":
      success(options);
      break;
    case "error":
      error(options);
      break;
    default:
      notice(options);
  }
};

export default notify;

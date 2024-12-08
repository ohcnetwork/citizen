type jsNotify = (title: string, text: string, type: string) => void;

const jsNotify: jsNotify = require("./notifier").default;

const success = (title: string, text: string) => jsNotify(title, text, "success");
const error = (title: string, text: string) => jsNotify(title, text, "error");
const notice = (title: string, text: string) => jsNotify(title, text, "notice");

export { success, error, notice };

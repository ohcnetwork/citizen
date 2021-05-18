const defaultTheme = require("tailwindcss/defaultTheme");

module.exports = {
  theme: {
    extend: {
      fontFamily: {
        sans: ["Inter var", ...defaultTheme.fontFamily.sans],
      },
    },
  },
  variants: {},
  plugins: [],
  purge: {
    content: ["./src/**/*.html", "./src/**/*.res", "./src/**/*.bs.js"],
  },
  plugins: [require("@tailwindcss/ui")],
};

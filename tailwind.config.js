/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './app/helpers/**/*.rb',
    './app/views/**/*.{html,erb,haml}',
    './config/initializers/simple_form_tailwindcss.rb',
    './config/locales/simple_form.*.yml',
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}

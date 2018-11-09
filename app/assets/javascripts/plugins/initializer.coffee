//= require plugins/autosize

ready =->
  startAutosize()

startAutosize =->
  autosize($('textarea'))

$(document).on "turbolinks:load", ready

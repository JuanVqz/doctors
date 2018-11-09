//= require plugins/autosize
//= require plugins/select2

ready =->
  startAutosize()
  startSelect2()

startAutosize =->
  autosize($('textarea'))

startSelect2 =->
  $(".select2").select2({
    width: "100%"
  })

$(document).on "turbolinks:load", ready

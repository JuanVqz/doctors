//= require plugins/autosize
//= require plugins/select2

ready =->
  startAutosize()
  startSelect2()
  startNavbar()
  startFlash()

startFlash =->
  $("#flash").on "click", ->
    $(this).remove()

startNavbar =->
  burger = document.querySelector '.burger'
  nav = document.querySelector '#navMenu'

  burger.addEventListener 'click', ->
    burger.classList.toggle 'is-active'
    nav.classList.toggle 'is-active'

startAutosize =->
  autosize($('textarea'))

startSelect2 =->
  $(".select2").select2({
    width: "100%"
  })

$(document).on "turbolinks:load", ready

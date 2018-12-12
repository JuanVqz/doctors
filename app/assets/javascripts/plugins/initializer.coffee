//= require plugins/autosize
//= require plugins/select2

ready =->
  startScrollTable()
  startFlash()
  setTimeout flashCallback, 5000
  startNavbar()
  startAutosize()
  startSelect2()

startScrollTable =->
  $(".table-container").scrollLeft($(document).outerWidth())

startFlash =->
  $("#flash").on "click", ->
    $(this).remove()

flashCallback =->
  $("#flash").fadeOut()

startNavbar =->
  burger = document.querySelector '.burger'
  nav = document.querySelector '#navMenu'

  if burger
    burger.addEventListener 'click', ->
      burger.classList.toggle 'is-active'
      nav.classList.toggle 'is-active'

startAutosize =->
  autosize($('textarea'))

startSelect2 =->
  $(".select2").select2({width: "100%"})

$(document).on "turbolinks:load", ready

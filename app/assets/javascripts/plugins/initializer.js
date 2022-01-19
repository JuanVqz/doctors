//= require plugins/autosize
//= require plugins/select2
//= require plugins/bulma-tagsinput

function startBulmaTagsInput() {
  bulmaTagsinput.attach();
}

function startScrollTable() {
  $(".table-container").scrollLeft($(document).outerWidth());
}

function startFlash() {
  $("#flash").on("click", function () {
    $(this).remove();
  });
}

function flashCallback() {
  $("#flash").fadeOut();
}

function startNavbar() {
  var burger = document.querySelector(".burger");
  var nav = document.querySelector("#navMenu");
  if (!burger) {
    return;
  }

  burger.addEventListener("click", function () {
    burger.classList.toggle("is-active");
    nav.classList.toggle("is-active");
  });
}

function startAutosize() {
  autosize($("textarea"));
}

function startSelect2() {
  $(".select2").select2({ width: "100%" });
}

function initializerReady() {
  startBulmaTagsInput();
  startScrollTable();
  startFlash();
  setTimeout(flashCallback, 5000);
  startNavbar();
  startAutosize();
  startSelect2();
}

$(document).on("turbolinks:load", initializerReady);

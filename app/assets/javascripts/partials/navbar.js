document.addEventListener("DOMContentLoaded", function () {
  if (document.querySelector(".burger")) {
    let burger = document.querySelector(".burger");
    let nav = document.querySelector("#navMenu");

    burger.addEventListener("click", function () {
      burger.classList.toggle("is-active");
      nav.classList.toggle("is-active");
    });
  }
});

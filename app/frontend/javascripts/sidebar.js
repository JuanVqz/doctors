document.addEventListener("DOMContentLoaded", function() {
  const sidebarToggler = document.getElementById("sidebar_toggler")
  const sidebarBackgrond = document.getElementById("sidebar_background")

  sidebarToggler.addEventListener("click", toggleSidebar)
  sidebarBackgrond.addEventListener("click", toggleSidebar)

  function toggleSidebar() {
    sidebarToggler.querySelectorAll("svg").forEach(el => el.classList.toggle("hidden"))
    sidebarBackgrond.classList.toggle("hidden")
    document.getElementById("sidebar").classList.toggle("hidden")
  }
});
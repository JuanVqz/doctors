function focusSearch() {
  const search = document.querySelector("input[type='search']")
  if (!search) return
  search.focus()
}

document.addEventListener("DOMContentLoaded", focusSearch)
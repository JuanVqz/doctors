document.addEventListener('DOMContentLoaded', () => {
  if (document.querySelector('.burger')) {
    let burger = document.querySelector('.burger')
    let nav = document.querySelector('#navMenu')

    burger.addEventListener('click', () => {
      burger.classList.toggle('is-active')
      nav.classList.toggle('is-active')
    })
  }
})

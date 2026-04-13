const btn = document.getElementById('menuBtn');
const menu = document.getElementById('mobileMenu');
let open = false;
btn.addEventListener('click', () => {
    open = !open;
    if (open) {
        menu.classList.remove('max-h-0');
        menu.classList.add('max-h-[500px]');
    } else {
        menu.classList.remove('max-h-[500px]');
        menu.classList.add('max-h-0');
    }
});
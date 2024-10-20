console.log('working')
var zip_btn = document.getElementById('zip-btn');
var tracker_btn = document.getElementById('tracker-btn');
var tracker_form = document.getElementById('tracker');
var zip_form = document.getElementById('zip');

zip_btn.addEventListener('click', () => {
    console.log("zip clicked")
    zip_btn.classList.add('btn-active')
    tracker_btn.classList.remove('btn-active')
    // showing zip FormData
    zip_form.classList.add('display-flex')
    zip_form.classList.remove('hidden')
    //hidding tracker form
    tracker_form.classList.add('hidden')
    tracker_form.classList.remove('display-flex')

})
tracker_btn.addEventListener('click', () => {
    console.log("zip clicked")
    tracker_btn.classList.add('btn-active')
    zip_btn.classList.remove('btn-active')
    // showing zip FormData
    zip_form.classList.add('hidden')
    zip_form.classList.remove('display-flex')
    //hidding tracker form
    tracker_form.classList.add('display-flex')
    tracker_form.classList.remove('hidden')
})
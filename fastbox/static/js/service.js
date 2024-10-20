console.log('working')

var wlink= document.getElementById('wlink')
var tlink= document.getElementById('tlink')
var plink= document.getElementById('plink')
var llink= document.getElementById('llink')
var clink= document.getElementById('clink')
var slink= document.getElementById('slink')
// console.log(links)
var storage = document.getElementById('storage')
var temp = storage

slink.addEventListener('click',()=>{
    console.log('link clicked')
    temp.classList.add('hidden')
    temp = storage
    storage.classList.remove('hidden')

})
clink.addEventListener('click',()=>{
    let cargo = document.getElementById('cargo')
    console.log('link clicked')
    temp.classList.add('hidden')
    temp = cargo
    cargo.classList.remove('hidden')
    
})
llink.addEventListener('click',()=>{
    let logistics = document.getElementById('logistics')
    console.log('link clicked')
    temp.classList.add('hidden')
    temp = logistics
    logistics.classList.remove('hidden')
    
})
plink.addEventListener('click',()=>{
    let package = document.getElementById('package')
    console.log('link clicked')
    temp.classList.add('hidden')
    temp = package
    package.classList.remove('hidden')
    
})
wlink.addEventListener('click',()=>{
    let warehouse = document.getElementById('warehouse')
    console.log('link clicked')
    temp.classList.add('hidden')
    temp = warehouse
    warehouse.classList.remove('hidden')
    
})
tlink.addEventListener('click',()=>{
    let truck = document.getElementById('truck')
    console.log('link clicked')
    temp.classList.add('hidden')
    temp = truck
    truck.classList.remove('hidden')
    
})
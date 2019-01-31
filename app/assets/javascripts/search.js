$(document).on("turbolinks:load", function(){
    let submit_icon = document.getElementById("submit-icon");
    let form = document.getElementById("search-form");
    
    if(!(typeof(submit_icon) === "undefined")){
        submit_icon.addEventListener('click', (event)=>{
            form.submit();
        })
    }
})




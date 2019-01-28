$(document).on("turbolinks:load", function(){
    let submit_icon = document.getElementById("submit-icon");
    let query = document.getElementById("search-field-sm");
    let result_holder = document.getElementById("search-result")
    
    if(!(typeof(submit_icon) === "undefined")){
        submit_icon.addEventListener('click', (event)=>{
            loadSearch(result_holder)
        })
    }

    function loadSearch(result_holder) {
        let xhttp = new XMLHttpRequest();
        query = query.value
        xhttp.onreadystatechange = function() {
          if (this.readyState == 4 && this.status == 200) {
            console.log(JSON.parse(typeof((this.response))))
          }
        };
        xhttp.open("GET", "http://localhost:3000/latest?search[query]="+query, true);
        xhttp.send();
    }
})




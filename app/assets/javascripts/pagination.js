$(document).on('turbolinks:load', ()=>{
    if(typeof(pagination) === "undefined"){
        let pagination = (function(){
    
            let forward_btns = []
                backward_btns = [],
                pag_query_form = {},
                active_link = [],
                tot_nav_links = 0,
                current_page = document.getElementById('current_page') ? document.getElementById('current_page') : 0;

            let assign_vals = function(){
                if(!!current_page){
                    forward_btns = Array.from(document.getElementsByClassName('forward'));
                    backward_btns = Array.from(document.getElementsByClassName('backward'));
                    pag_query_form = document.forms['pag_query_form'];
                    active_link = Array.from(document.getElementsByClassName(current_page.value));
                    tot_nav_links = +document.getElementById('tot_nav_links_f').value;

                    return true;
                }
            }
            
            let forward = function(event){
                event.preventDefault();

                if( +current_page.value < tot_nav_links){
                    current_page.value = 1 + +current_page.value;
                    pag_query_form.submit();
                }
            }
    
            let backward = function (event){
                console.log("current page : ", current_page.value)
                console.log("total navigation links : ", tot_nav_links)
                event.preventDefault();
                if(current_page.value > 1){
                    current_page.value = +current_page.value - 1;
                    //pag_query_form.submit();
                }
            }
            
            let addListener = function(){
                forward_btns.forEach((elem)=> elem.addEventListener('click', forward))
                backward_btns.forEach((elem)=> elem.addEventListener('click', backward))
            }
    
            let makeActive = function(){
                active_link.forEach((elem)=> elem.style.color = 'green')
            }
    
            return {
                init : function(){
                    if(!!assign_vals()){
                        makeActive();
                        addListener();
                    }
                }
            }
        })()
        pagination.init()
        return;
    }
})
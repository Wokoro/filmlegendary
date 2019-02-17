$(document).on('turbolinks:load', ()=>{

  if(($('body').data('action')==='index') && ($('body').data('controller')==='films')){
    
    
    let xhttp = new XMLHttpRequest();
    let load_content = document.getElementById("load_content")
    let content_load_form = document.forms['per_page']
    let content_holder = document.getElementById("content_holder")
    let template = document.querySelector(".template")
    let queryOffset = document.querySelector("#offset")

    load_content.addEventListener('click', (event)=>{
        event.preventDefault();
        xhttp.open("GET", `/?offset=${queryOffset.value}` , true);
        xhttp.send();
    })

    content_load_form.addEventListener('submit', (event)=>{
        
     })
    
    xhttp.onreadystatechange = function(){
    if (this.readyState == 4 && this.status == 200) {
        let response = JSON.parse(this.response)
        queryOffset.value = response.query;
        response.contents.map((content)=>{
            let card = generateTemplate(template, content)
            appendToDOM(content_holder, card )
       }) 
    }
  }
  
  let generateTemplate = (temp, obj)=>{
      let holder = temp.cloneNode(true);
      holder.classList.remove('template')
      let a = holder.querySelector('.link')
      let poster = holder.querySelector('.poster')
      let title = holder.querySelector('.tag')
      let artist_name = holder.querySelector('.artist_name')

      a.href = `/${obj.media_type}/${obj.media_id}`
      poster.src = `${obj.media_poster}`
      title.textContent = `${obj.title}`
      artist_name.textContent = `${obj.artist_name}`

      holder.removeAttribute('hidden')
      return holder
  }

  let appendToDOM = (holder, node)=>{
      holder.append(node)
  }    
}
})

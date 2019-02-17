class Page
    body: $('body')
    controller: ()=> body.data('controller')
    actoin: ()=> body.data('action')

@page = new Page
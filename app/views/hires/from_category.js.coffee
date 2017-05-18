
$('#book<%=@cid %>-carousel').html '<%= escape_javascript(render partial: 'book_list', locals: { books: @selected, carousel_id: @cid } ) %>'

$('#book<%=@cid %>-carousel').owlCarousel
  items: 5
  navigation: true
  navigationText: [
    '<<'
    '>>'
  ]
  pagination: false
  lazyLoad: true
  lazyFollow: true
  transitionStyle: 'fade'

$('#book<%=@cid %>-carousel').show()

ListenForSelectedBook()
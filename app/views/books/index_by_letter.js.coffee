NProgress.done()
books_list = $("<%= escape_javascript(render partial: 'books_list', locals: { books: @books } ) %>").hide().fadeIn();
$(".book-zone").append(books_list);

$(".letter_<%=@cletter%>").addClass('active')


$(".book<%=@bookid%>").fadeOut();
$(".book<%=@bookid%>").remove();


numofbooks = $(".child<%=@childid%>").length

if numofbooks == 2
  $(".child<%=@childid%>").fadeOut();



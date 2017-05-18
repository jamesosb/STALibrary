
<% if @children.blank? %>

$('#results-container').hide()
$('#results-container').html '<%= escape_javascript(render partial: 'no_results') %>'
$('#results-container').fadeIn 'slow'

$('.search-term').html '<%= escape_javascript('You searched for "' + @search_term + '"') %>'

<% else %>

$('#results-container').hide()
$('#results-container').html '<%= escape_javascript(render partial: 'check_in_list', locals: { children: @children } ) %>'
$('#results-container').fadeIn 'slow'

$('.search-term').html '<%= escape_javascript(render partial: 'results_text', locals: { childcount: @childcount, search_term: @search_term } ) %>'

<% end %>

NProgress.done()
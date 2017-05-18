
$('#children-carousel').html '<%= escape_javascript(render partial: 'child_list', locals: { children: @selected_children } ) %>'

LoadChildrenCarousel()

ListenForSelectedChild()

BindEvents()


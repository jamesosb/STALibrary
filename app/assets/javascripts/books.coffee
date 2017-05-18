# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.ResetAll = ->
  book1clickcounter = 0
  book2clickcounter = 0
  childclickcounter = 0

  book1selection = 0
  book2selection = 0

  $('.childfield').val("");
  $('.hire_book').val("");
  $('.hire_book2').val("");

window.LoadChildrenCarousel = ->

  $('#children-carousel').owlCarousel
    items: 5
    itemsTablet: 3
    itemsMobile: 2
    navigation: true
    navigationText: [
      '<<'
      '>>'
    ]
    pagination: false
    lazyLoad: true
    lazyFollow: true
    transitionStyle: 'fade'

  $('#children-carousel').show()

  NProgress.done()



window.ListenForSelectedChild = ->

  $(".hires_headings:eq(0)").html('You');

  childclickcounter = 0

  $('.tapchild').on 'click', (event) ->

    $this = $(this)

    StepVar = 1

    childid = $this.data('id')

    if $this.hasClass('childclicked')
      $this.removeAttr('style').removeClass 'childclicked'
      childclickcounter = 0
      $('.childfield').val("");

    else if childclickcounter == 1
      alert 'Choose one child from this row'

    else
      $this.css('border-color', '#39AFD7').addClass 'childclicked'
      childclickcounter = 1
      $('.childfield').val(childid);

      findimage = $(this).find('.tilesimg').attr('src')
      findimage = "<img class='tilesimg' style='display: inline;' src='"+findimage+"'>"

      $(".signpost-inner-circle:first").html(findimage);
      findname = $(this).find('.child-name')
      $(".select-class:eq(1)").html(findname.html());

      $("#genre1_genre_id").fadeIn()

      $("#children-carousel").data('owlCarousel').destroy();

      $(".hires_headings:eq(0)").html(findname.html());
      $(".hires_headings:eq(0)").css
        'font-weight': 'normal'
        'opacity' : '0.5'
    return

window.ClassSelected = ->

  NProgress.start()

  $(".hires_headings:eq(0)").html('Thinking...');

  #set the bg colour of the mini-circle to green
  $(".signpost-inner-circle:first").css
    'background-color': '#90C854'


  #hide the boxes (after we've found everything)
  $(".class-boxes").fadeOut();

  #Display the remove option
  $(".delete-box:eq(0)").css
    'display': 'block'

  ## TODO: Work out why for some reason this always needs to be at the bottom of the function or it breaks. No idea why.

  if $('#children-carousel').length
    $("#children-carousel").data('owlCarousel').destroy();

window.ListenForSelectedBook = ->

  if $(".hires_headings:eq(1)").html() == 'Loading...'
    $(".hires_headings:eq(1)").html('First Book');
  else if $(".hires_headings:eq(2)").html() == 'Loading...'
    $(".hires_headings:eq(2)").html('Second Book');

  NProgress.done()

  book1clickcounter = 0
  book2clickcounter = 0

  book1selection = 0
  book2selection = 0

  $('.tapbook1').on 'click', (event) ->
    $this = $(this)

    book1id = $this.data('id')
    book1selection = book1id

    if $this.hasClass('bookclicked')

      $this.removeAttr('style').removeClass 'bookclicked'
      book1clickcounter = 0
      $('.hire_book').val("");
      book1selection = 0

    else if book1clickcounter == 1

      alert 'Choose one book from this row'

    else if book1id == book2selection

      alert "You've already picked this book"

    else

      book1clickcounter = 1
      $('.hire_book').val(book1id);

      $this.css
        'border-color' :'#39AFD7'

      $this.addClass 'bookclicked'

      #Display the remove option
      $(".delete-box:eq(1)").css
        'display': 'block'

      #Set big box name
      findbookname = $(this).find('.book1-name')
      findbookname = findbookname.html()
      $(".hires_headings:eq(1)").html(findbookname);
      $(".hires_headings:eq(1)").css
        'font-weight': 'normal'
        'opacity' : '0.5'

      if $(this).find('.no_image_tile').length == 0
        findbookimage = $(this).find('.tilesimg').attr('src')
        findbookimage = "<img class='tilesimg' style='display: inline;' src='"+findbookimage+"'>"
        $(".signpost-inner-circle:eq(1)").html(findbookimage)
      else
        hidebookimage = "<span class='glyphicon white-links glyphicon-ok' aria-hidden='true'></span>"
        #set the bg colour of the mini-circle to green
        $(".signpost-inner-circle:eq(1)").html(hidebookimage)
        $(".signpost-inner-circle:eq(1)").css
          'background-color': '#90C854'


      if findbookname.length > 11
        trunked = findbookname.slice(0, 11 - 3)
        findbooknametrunc = trunked + '...'
        findbooknametrunc
      else
        findbooknametrunc = findbookname

      $(".select-class:eq(3)").html(findbooknametrunc)

      $("#genre1_genre_id").fadeOut()
      $("#genre2_genre_id").fadeIn()

      #Kill the carousel
      $("#book1-carousel").data('owlCarousel').destroy();


  $('.tapbook2').on 'click', (event) ->

    StepVar = 3

    $this = $(this)
    book2id = $this.data('id')
    book2selection = book2id

    if $this.hasClass('book2clicked')
      $this.removeAttr('style').removeClass 'book2clicked'
      book2clickcounter = 0
      book1selection = 0
      $('.hire_book2').val("");
    else if book2clickcounter == 1
      alert 'Choose one book from this row'
    else if book1selection == book2id
      alert "You've already picked this book"
    else
      book2clickcounter = 1
      $('.hire_book2').val(book2id);

      $this.css
        'border-color' :'#39AFD7'

      $this.addClass 'bookclicked'

      #Display the remove option
      $(".delete-box:eq(2)").css
        'display': 'block'

      #Set big box name
      findbookname = $(this).find('.book1-name')
      findbookname = findbookname.html()
      $(".hires_headings:eq(2)").html(findbookname);
      $(".hires_headings:eq(2)").css
        'font-weight': 'normal'
        'opacity' : '0.5'

      if $(this).find('.no_image_tile').length == 0
        findbookimage = $(this).find('.tilesimg').attr('src')
        findbookimage = "<img class='tilesimg' style='display: inline;' src='"+findbookimage+"'>"
        $(".signpost-inner-circle:eq(2)").html(findbookimage)
      else
        hidebookimage = "<span class='glyphicon white-links glyphicon-ok' aria-hidden='true'></span>"
        #set the bg colour of the mini-circle to green
        $(".signpost-inner-circle:eq(2)").html(hidebookimage)
        $(".signpost-inner-circle:eq(2)").css
          'background-color': '#90C854'


      $("#genre2_genre_id").fadeOut()


      if findbookname.length > 11
        trunked = findbookname.slice(0, 11 - 3)
        findbooknametrunc = trunked + '...'
        findbooknametrunc
      else
        findbooknametrunc = findbookname

      $(".select-class:eq(5)").html(findbooknametrunc)

      #Kill the carousel
      $("#book2-carousel").data('owlCarousel').destroy();


window.ResetStep3 = (StepVar) ->

  $(".hires_headings:eq(2)").html('Second Book')
  $(".hires_headings:eq(2)").css
    'font-weight': 'lighter'
    'opacity' : '1'


  if StepVar == 0
    $("#genre1_genre_id").fadeOut()
    $("#genre2_genre_id").fadeOut()
  else if StepVar == 1
    $("#genre1_genre_id").fadeIn()
    $("#genre2_genre_id").fadeOut()
  else if StepVar == 2
    $("#genre1_genre_id").fadeOut()
    $("#genre2_genre_id").fadeIn()

  displaytext = '2nd Book'
  $(".select-class:eq(5)").html(displaytext);

  #Display the remove option
  $(".delete-box:eq(2)").css
    'display': 'none'

  #set the bg colour of the mini-circle to grey-green
  $(".signpost-inner-circle:eq(2)").css
    'background-color': '#8FAEAC';

  $('.hire_book2').val("");

  #Change the text
  displayblankicons = '<span class="double-book1 glyphicon white-links glyphicon-book" aria-hidden="true"><span class="double-book2 glyphicon white-links glyphicon-book" aria-hidden="true"></span>'
  $(".signpost-inner-circle:eq(2)").html(displayblankicons);

  $("#book2-carousel").data('owlCarousel').destroy();


window.ResetStep2 = (StepVar) ->

  $(".hires_headings:eq(1)").html('First Book')
  $(".hires_headings:eq(1)").css
    'font-weight': 'lighter'
    'opacity' : '1'


  if StepVar == 0
    $("#genre1_genre_id").fadeOut()
    $("#genre2_genre_id").fadeOut()
  else if StepVar == 1
    $("#genre1_genre_id").fadeIn()
    $("#genre2_genre_id").fadeOut()
  else if StepVar == 2
    $("#genre1_genre_id").fadeOut()
    $("#genre2_genre_id").fadeIn()


  displaytext = '1st Book'
  $(".select-class:eq(3)").html(displaytext);

  #Display the remove option
  $(".delete-box:eq(1)").css
    'display': 'none'

  #set the bg colour of the mini-circle to green
  $(".signpost-inner-circle:eq(1)").css
    'background-color': '#8FAEAC';

  $('.hire_book').val("");

  #Change the text
  displayblankicons = "<span class='glyphicon white-links glyphicon-book' aria-hidden='true'></span>"
  $(".signpost-inner-circle:eq(1)").html(displayblankicons);

  ResetStep3()

  $("#book1-carousel").data('owlCarousel').destroy();


window.ResetStep1 = (StepVar) ->

  $(".hires_headings:eq(0)").html('You')
  $(".hires_headings:eq(0)").css
    'font-weight': 'lighter'
    'opacity' : '1'

  $(".class-boxes").delay(600).fadeIn();

  if StepVar == 0
    $("#genre1_genre_id").fadeOut()
    $("#genre2_genre_id").fadeOut()
  else if StepVar == 1
    $("#genre1_genre_id").fadeIn()
    $("#genre2_genre_id").fadeOut()
  else if StepVar == 2
    $("#genre1_genre_id").fadeOut()
    $("#genre2_genre_id").fadeIn()

  displaytext = 'You'
  $(".select-class:eq(1)").html(displaytext);

  $('.childfield').val("");

  #Display the remove option
  $(".delete-box:eq(0)").css
    'display': 'none'

  #set the bg colour of the mini-circle to green
  $(".signpost-inner-circle:first").css
    'background-color': '#8FAEAC';

  #Change the text
  displayblankicons = "<span class='glyphicon white-links glyphicon-user' aria-hidden='true'></span>"
  $(".signpost-inner-circle:first").html(displayblankicons);

  ResetStep2()
  ResetStep3()

  $("#children-carousel").data('owlCarousel').destroy();



window.BindEvents = ->

########## Show the class name and icon - fade out the big buttons ##########

  $( "#genre1_genre_id" ).on 'change', (event) ->

    NProgress.start()

    $(".hires_headings:eq(1)").html('Thinking...');

    $("#book1-carousel").data('owlCarousel').destroy();


  $( "#genre2_genre_id" ).on 'change', (event) ->

    NProgress.start()

    $(".hires_headings:eq(2)").html('Loading...');

    $("#book2-carousel").data('owlCarousel').destroy();


  $('.select-class').on 'click', (event) ->

    #TODO: work out how to pass $this variable properly so I can tidy up this bit of script
    $this = $(this)

    #Change the text
    findspan = $this.find('.select-circle')
    $(".signpost-inner-circle:first").html(findspan.html());

    findtext = $(this).data("classroom")
    $(".select-class:eq(1)").html(findtext);

    ClassSelected()

  $('.delete-box:eq(0)').on 'click', (event) ->
    StepVar = 0
    ResetStep1(StepVar)

  $('.delete-box:eq(1)').on 'click', (event) ->
    StepVar = 1
    ResetStep2(StepVar)

  $('.delete-box:eq(2)').on 'click', (event) ->
    StepVar = 2
    ResetStep3(StepVar)


$(document).on 'ready page:load', ->

  StepVar = 0

  BindEvents()

  $('.letter_link').on 'click', (event) ->
    $(".books-table").fadeOut();
    $('.letter_link').removeClass('active');
    NProgress.start()

  book1carousel = $("#book1-carousel")
  book2carousel = $('#book2-carousel')

  ResetAll()



  $('#children-carousel').owlCarousel items: 5, lazyLoad : true, lazyFollow: true



  ####### on click table route to link #######

  jQuery ($) ->
  $('td[data-link]').click ->
    window.location = @dataset.link
    return
  return

return
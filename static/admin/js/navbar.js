var drawer_open = true;
$(window).resize(function() {
  if ($(window).width() < 1025 && !drawer_open) {
      opendrawer();
  }
});
$(document).ready(function(){
   $('.navbar-ul li:has(ul)').click(function(e){
      //e.preventDefault();

      if ($(this).hasClass ('index-li')){
            if (!drawer_open) {
                  opendrawer();
            }
            $(".open").addClass('index-li');
            $(".open").children('ul').slideUp();
            // $(".open").find('i').addClass('fa-chevron-right');
            // $(".open").find('i').removeClass('fa-chevron-down');
            if ($(this).find('ul').length > 0) {
                  console.log("Hello");     
                  //$(this).removeClass('index-li');   
                  $(this).find('ul').slideDown();
                  $(this).removeClass('index-li'); 
                  $(this).addClass('open');
                  // $(this).find('i').removeClass('fa-chevron-right');
                  // $(this).find('i').addClass('fa-chevron-down');
            }

      }
      else{
            if ($(this).find('ul').length > 0) {

                  $(this).children('ul').slideUp();
                  $(this).addClass('index-li');
                  // $(this).find('i').addClass('fa-chevron-right');
                  // $(this).find('i').removeClass('fa-chevron-down');
                  $(this).removeClass('open');
            }
            
      }

   });
});
function closedrawer()
{
      var drawer = $(".mdl-layout__drawer");
      var content = $(".mdl-layout__content");
      drawer_width = drawer.width() - 170;
      content_width = content.width() + 170;
      drawer.animate({width: drawer_width});
      content.animate({left: '-=170px' });
      content.width(content_width);
      drawer.find('li span').hide();
      $(".mdl-layout-title").height(50).css('padding', '10px 10px');
      $(".mdl-layout-title").find('img').attr('src', 'img/amoogli_logo_small.png').css('width', '50px').removeClass('img-responsive');
      $('#closedrawer').hide();
      $('#opendrawer').show();

      $(".open").addClass('index-li');
      $(".open").children('ul').slideUp();
      drawer_open = false;
}
function opendrawer()
{
      var drawer = $(".mdl-layout__drawer");
      var content = $(".mdl-layout__content");
      drawer_width = drawer.width() + 171;
      content_width = content.width() - 170; 
      //drawer.animate({width: drawer_width});
      drawer.width(drawer_width);
      content.animate({left: '+=170px' });
      content.width(content_width);
      
      $(".mdl-layout-title").css('height', 'auto').css('padding', '15px 30px');
      $(".mdl-layout-title").find('img').attr('src', 'img/amoogli_logo.png').css('width', 'auto').addClass('img-responsive');
      drawer.find('li span').delay(2000).show();
      $('#opendrawer').hide();
      $('#closedrawer').show();
      drawer_open = true;
}

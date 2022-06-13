/*global $*/
document.addEventListener("turbolinks:load", function() {
  $(function(){
    $('#tab-contents .tab[id != "post_index"]').hide();
    
    $('#tab-menu a').on('click', function(event) {
      $("#tab-contents .tab").hide();
      $("#tab-menu .active").removeClass("active");
      $(this).addClass("active");
      $($(this).attr("href")).show();
      event.preventDefault();
    });
  })
})

$(function(){
  setTimeout("$('.flash').fadeOut('slow')", 2000);
});

$(window).on('load',function(){
  $(".three-dot-spinner").delay(1500).fadeOut('slow');
});
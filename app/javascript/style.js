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

$('.custom-file-input').on('change',function(){
  $(this).next('.custom-file-label').html($(this)[0].files[0].name);
})
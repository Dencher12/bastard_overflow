$(document).ready(function(){
 $('.edit-question-link').click(function(e){
   e.preventDefault();

   if ($(this).html() == 'Edit question') {
    $(this).html('Close');
   } else {
    $(this).html('Edit question');
   }

   $('.edit_question').toggle();
   
 });
});
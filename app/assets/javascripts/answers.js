$(document).ready(function(){
  console.log("fdgsfg");
 $('.edit-answer-link').click(function(e){
   e.preventDefault();

   answer_id = $(this).data('answerId');

   if ($(this).html() == 'Edit') {
    $(this).html('Close');
   } else {
    $(this).html('Edit');
   }

   $('.edit-answer-' + answer_id).toggle();
   
 });
});
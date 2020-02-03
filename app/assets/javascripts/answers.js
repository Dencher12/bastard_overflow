$(document).ready(function(){
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

 $('.rate_up').bind('ajax:success', success_rating_update);
 $('.rate_down').bind('ajax:success', success_rating_update);

 function success_rating_update(e) {
  answer = e.detail[0]
  $('.answer_id_'+answer.id+' .rating').html(answer.rating);
 }

});
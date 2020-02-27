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

 $('.rate_up').bind('ajax:success', success_rating_update)
              .bind('ajax:error', error_rating_update);

 $('.rate_down').bind('ajax:success', success_rating_update)
                .bind('ajax:error', error_rating_update);

 function success_rating_update(e) {
  answer = e.detail[0];
  $('.answer_id_'+answer.id+' .rating').html(answer.rating);
 }

 function error_rating_update(e) {
  answer_id = e.detail[0].answer_id;
  error = e.detail[0].error;
 
  $('.answer_id_'+answer_id+' .errors').html(error);
 }

 App.cable.subscriptions.create('AnswersChannel', 
    { 
      connected: function() {
        console.log('Connected!');
        this.perform('follow')
      },
      received: function(data) {
        console.log(data)
        $('.answers').append(data.answer)
      }
    }
  );

});
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

 
  App.cable.subscriptions.create('QuestionsChannel', 
    { 
      connected: function() {
        console.log('Connected!');
        this.perform('follow')
      },
      received: function(data) {
        $('tbody.questions').append(data)
      }
    }
  );

});


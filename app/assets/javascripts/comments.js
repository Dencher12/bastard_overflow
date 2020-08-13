$(document).ready(function(){
     App.cable.subscriptions.create('CommentsChannel', 
       { 
         connected: function() {
           console.log('Connected!');
           this.perform('follow')
         },
         received: function(data) {
           if (data.comment_type == "answer") {
            $(".answer_id_" + data.answer_id + " .comments").append(data.comment)
           } else {
            $(".question .comments").append(data.comment)
           } 
         }
       }
     );
   
   });
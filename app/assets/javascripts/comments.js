$(document).ready(function(){
     App.cable.subscriptions.create('CommentsChannel', 
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
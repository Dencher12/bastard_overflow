//= require jquery
//= require rails-ujs
//= require cocoon
//= require action_cable
//= require_tree .

var App = App || {}
App.cable = ActionCable.createConsumer();
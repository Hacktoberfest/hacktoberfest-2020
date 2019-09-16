(function() {
  this.App || (this.App = {});

  App.cable = ActionCable.createConsumer();

}).call(this);

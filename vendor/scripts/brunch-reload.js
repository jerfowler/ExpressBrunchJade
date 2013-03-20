$(function() {
  if(window.io){
    var brunch = window.io.connect('/brunch', {
      'connect timeout': 500,
      'reconnect': true,
      'reconnection delay': 500,
      'reopen delay': 500,
      'max reconnection attempts': 10
    });
    brunch.on('reload', function (delay) {
      console.log('Server content changed, reloading in...'+delay+'ms');
      setTimeout(function(){
        window.location.reload(true);
      }, delay);
    });
  }
});
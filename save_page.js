var system = require('system');
var page = require('webpage').create();

function sleep(milliseconds) {
  var start = new Date().getTime();
  while((new Date().getTime() - start) < milliseconds){
    page.render('scotch.png')
  }
}

page.open(system.args[1], function()
{
    sleep(30000);
    page.render('scotch.png');
    console.log(page.content);
    phantom.exit();
    
});

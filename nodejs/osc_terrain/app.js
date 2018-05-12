var express = require('express');

var app = express();

var osc = require('node-osc');

var server = app.listen(3000);
var io = require('socket.io')(server);

app.use(express.static('public'));

app.get('/', function(req, res){
  res.sendFile(__dirname + '/index.html');
});

var oscServer = new osc.Server(8000, '0.0.0.0');
oscServer.on("message", function(msg, rinfo){
  console.log(msg);
  io.sockets.emit('mysocket', msg);
});

const Consul = require('consul');
const express = require('express');

const SERVICE_NAME='web2';
const SERVICE_ID='m'+process.argv[2];
const SCHEME='http';
const HOST='192.168.100.6';
const PORT=process.argv[2]*1;
const PID = process.pid;

/* Inicializacion del server */
const app = express();
const consul = new Consul();

app.get('/health', function (req, res) {
    console.log('Health check!');
    res.end( "Ok." );
    });

app.get('/', (req, res) => {
  console.log('GET /', Date.now());
  res.end("Hello, from  Web Server 2! :)");
});

app.listen(PORT, function () {
    console.log('Servicio iniciado en:'+SCHEME+'://'+HOST+':'+PORT+'!');
    });

/* Registro del servicio */
var check = {
  id: SERVICE_ID,
  name: SERVICE_NAME,
  address: HOST,
  port: PORT, 
  check: {
	   http: SCHEME+'://'+HOST+':'+PORT+'/health',
	   ttl: '5s',
	   interval: '5s',
     timeout: '5s',
     deregistercriticalserviceafter: '1m'
	   }
  };
 
consul.agent.service.register(check, function(err) {
  	if (err) throw err;
  	});

var exec = require('cordova/exec');

var mediabrix = {};
var PLUGIN_NAME = "MediaBrix";

mediabrix.initialize = function(manifest_url, app_id){
	console.log("initialize");
	cordova.exec( null, null, PLUGIN_NAME, 'initialize', [manifest_url,app_id]);
};

mediabrix.load = function(zone){
	cordova.exec( null, null, PLUGIN_NAME, 'load', [zone]);
};

mediabrix.show= function(zone){
	cordova.exec( null, null, PLUGIN_NAME, 'show', [zone]);
};


mediabrix.resume = function(){
	cordova.exec( null, null, PLUGIN_NAME, 'resume', [""]);
};

mediabrix.pause= function(){
	cordova.exec( null, null, PLUGIN_NAME, 'pause', [""]);
};

module.exports = mediabrix;

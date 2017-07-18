# mediabrix-phonegap

## Install Plugin
* After downloading the plugin, save the plugin project to path of your choice. 
* In your terminal, go to the path of your project.
* Once you're in project's path, run this command in your terminal
  ```cordova plugin add path_to_mediabrix_plugin```
 * After running that command, the mb_plugin will be added to your project.
  
 ## Initialization 
 The view that would attempt to load an ad must call resume function whenever view is presented:
 ```
  initialize: function() {
    document.addEventListener('deviceready', this.onDeviceReady, false);
    document.addEventListener("resume", this.onResume, false);
    document.addEventListener("pause", onPause, false);
  }

  onResume:function() {
    window.cordova.plugins.MediaBrix.resume();
  }
 ```
 
 That same view should call the pause function whenever view disappears:
 ```
   onPause:function() {
    window.cordova.plugins.MediaBrix.pause();
  }
 ```
 
 In your onDeviceReady function, you will need to listen to these events: 
 ```
  onDeviceReady: function() {
    document.addEventListener("onStarted", this.onStarted, false);
    document.addEventListener("onAdReady", this.onAdReady, false);
    document.addEventListener("onAdUnavailable", this.onAdUnavailable, false);
    document.addEventListener("onAdShown", this.onAdShown, false);
    document.addEventListener("onAdRewardConfirmation", this.onAdRewardConfirmation, false);
    document.addEventListener("onAdClicked", this.onAdClicked, false);
    document.addEventListener("onAdClosed", this.onAdClosed, false);
  }
 ```
 
 Afterwards call the initialization function:
 ```
 window.cordova.plugins.MediaBrix.initialize('http://mobile.mediabrix.com/v2/manifest/','APP_ID');
 ```

## Load
To load an ad, call the load function below:
```
window.cordova.plugins.MediaBrix.load('ZONE');
```

## Show
To show an ad, call the show function below:
```
window.cordova.plugins.MediaBrix.show('ZONE');
```

## Ad Events
Callback methods made from the sdk. 
```
onStarted: function(e){
// MediaBrix SDK has been initialized successfully, and can now attempt to load ads. DOES NOT HAVE A ZONE!!
},

onAdReady: function(e){ 
//The SDK has successfully downloaded an ad, and is ready to show for a zone. To get the zone, call e.zone
},

onAdUnavailable: function(e){
// The SDK was not able to download an ad for a zone. To get the zone, call e.zone
},
   
onAdShown: function(e){
// The user is currently viewing the ad for a zone. To get the zone, call e.zone
},

onAdRewardConfirmation: function(e) {
// The user has watched an ad that offers an incentive. To get the zone, call e.zone 
// The user should be granted some award. 
},

onAdClicked: function(e) {
 // The user has clicked on the ad. To get the zone, call e.zone 
},

onAdClosed: function(e) {
  // The ad that was being displayed to the user has been closed. To get the zone, call e.zone
}
```

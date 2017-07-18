package com.cordova.MediaBrix;

import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaInterface;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CordovaWebView;
import org.apache.cordova.PluginResult;
import org.apache.cordova.PluginResult.Status;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.mediabrix.android.api.*;
import android.util.Log;
import android.content.Context;

/**
 * This class echoes a string called from JavaScript.
 */
public class MediaBrix extends CordovaPlugin implements IAdEventsListener {
    CordovaWebView webView;
    @Override
    public void initialize(CordovaInterface cordova, CordovaWebView webView) {
        super.initialize(cordova, webView);
        this.webView = webView;
    }

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        Context context= this.cordova.getActivity(); 
        Log.d("PHONEGAP", args.toString());
        if (action.equals("initialize")) {
            MediabrixAPI.getInstance().initialize(context, args.getString(0), args.getString(1), this); 
            return true;
        } else if(action.equals("load")){
            MediabrixAPI.getInstance().load(context, args.getString(0)); 
            return true;
        } else if(action.equals("show")){
            MediabrixAPI.getInstance().show(context, args.getString(0)); 
            return true;
        } else if(action.equals("resume")){
            MediabrixAPI.getInstance().onResume(context);
            return true;
        } else if(action.equals("pause")){
            MediabrixAPI.getInstance().onPause(context);
            return true;
        }
        return false;
    }

    @Override
    public void onStarted(final String status) {
       // MediaBrix SDK has been initialized successfully, and can now attempt to load ads.
         this.cordova.getActivity().runOnUiThread(new Runnable() {
            @Override
            public void run() {
                String event = "javascript:cordova.fireDocumentEvent('onStarted', {})";
                webView.loadUrl(event);
            }
        });

    }
     
    //The target refers to zone that you are attempting to load/show 

    @Override
    public void onAdReady(final String target) {
       // The SDK has successfully downloaded an ad, and is ready to show
         this.cordova.getActivity().runOnUiThread(new Runnable() {
            @Override
            public void run() {
                String event = "javascript:cordova.fireDocumentEvent('onAdReady', {'zone':'"+target+"'})";
                webView.loadUrl(event);
            }
        });

    }
     
    @Override
    public void onAdUnavailable(final String target) {
      // The SDK was not able to download an ad
        this.cordova.getActivity().runOnUiThread(new Runnable() {
            @Override
            public void run() {
               String event = "javascript:cordova.fireDocumentEvent('onAdUnavailable', {'zone':'"+target+"'})";
                webView.loadUrl(event);
            }
        });

    }

    @Override
    public void onAdShown(final String target){
       // The user is currently viewing the ad
        this.cordova.getActivity().runOnUiThread(new Runnable() {
            @Override
            public void run() {
               String event = "javascript:cordova.fireDocumentEvent('onAdShown', {'zone':'"+target+"'})";
                webView.loadUrl(event);
            }
        });
    }
     
    @Override
    public void onAdRewardConfirmation(final String target) {
      // The user has watched an ad that offers an incentive. 
      // The user should be granted some award. 
        this.cordova.getActivity().runOnUiThread(new Runnable() {
            @Override
            public void run() {
               String event = "javascript:cordova.fireDocumentEvent('onAdRewardConfirmation', {'zone':'"+target+"'})";
                webView.loadUrl(event);
            }
        });
    }

    @Override
    public void onAdClicked(final String target){
     // The user has clicked on the ad
        this.cordova.getActivity().runOnUiThread(new Runnable() {
            @Override
            public void run() {
               String event = "javascript:cordova.fireDocumentEvent('onAdClicked', {'zone':'"+target+"'})";
                webView.loadUrl(event);
            }
        });
    }
     
    @Override
    public void onAdClosed(final String target) {
      // The ad that was being displayed to the user has been closed
        this.cordova.getActivity().runOnUiThread(new Runnable() {
            @Override
            public void run() {
               String event = "javascript:cordova.fireDocumentEvent('onAdClosed', {'zone':'"+target+"'})";
                webView.loadUrl(event);
            }
        });
    }
}

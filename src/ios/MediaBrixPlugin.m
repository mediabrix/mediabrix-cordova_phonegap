/********* MediaBrixPlugin.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>
#import "MediaBrix.h"

@interface MediaBrixPlugin : CDVPlugin  <MediaBrixDelegate> {
}

- (void)initialize:(CDVInvokedUrlCommand*)command;
- (void)load:(CDVInvokedUrlCommand*)command;
- (void)show:(CDVInvokedUrlCommand*)command;
@end

@implementation MediaBrixPlugin

- (void)initialize:(CDVInvokedUrlCommand*)command {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
            isStarted = true;
            id callbackDelegate = self;
            NSString* baseURL = [command.arguments objectAtIndex:0];
            NSString* appid = [command.arguments objectAtIndex:1];
            [MediaBrix initMediaBrixDelegate:callbackDelegate withBaseURL:baseURL withAppID:appid]; // Replace APP_ID with the app id provided to you by MediaBrix
        }];
}
- (void)load:(CDVInvokedUrlCommand*)command {
    [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
        NSString* zone = [command.arguments objectAtIndex:0];
        [[MediaBrix sharedInstance] loadAdWithIdentifier:zone withViewController:nil];
    }];
    
}
- (void)show:(CDVInvokedUrlCommand*)command {
    [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
        NSString* zone = [command.arguments objectAtIndex:0];
        
            [[MediaBrix sharedInstance]showAdWithIdentifier:zone fromViewController:[UIApplication sharedApplication].keyWindow.rootViewController reloadWhenFinish:NO];}
     ];
}
#pragma mark - <MediaBrixDelegate>
-(void)mediaBrixStarted {
    //Invoked when the sdk has been initialized
    [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
        [self.commandDelegate evalJs:@"javascript:cordova.fireDocumentEvent('onStarted', {})"];
    }];
}
-(void)mediaBrixAdReady:(NSString *)identifier {
    [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
        NSString * event = [NSString stringWithFormat:@"javascript:cordova.fireDocumentEvent('onAdReady', {'zone':'%@'})", identifier];
        [self.commandDelegate evalJs:event];
    }];
    // Invoked when ad has succesfully downloaded and is ready to show
}
- (void)mediaBrixAdWillLoad:(NSString *)identifier {
    // Invoked when the ad has been requested
}
- (void)mediaBrixAdFailed:(NSString *)identifier {
    // Invoked when the ad fails to load an ad
    [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
        NSString * event = [NSString stringWithFormat:@"javascript:cordova.fireDocumentEvent('onAdUnavailable', {'zone':'%@'})", identifier];
        [self.commandDelegate evalJs:event];
    }];
}
- (void)mediaBrixAdShow:(NSString *)identifier {
    // Invoked when ad is being shown to the user
    [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
        NSString * event = [NSString stringWithFormat:@"javascript:cordova.fireDocumentEvent('onAdShown', {'zone':'%@'})", identifier];
        [self.commandDelegate evalJs:event];
    }];
    
}
- (void)mediaBrixAdDidClose:(NSString *)identifier {
    // Invoked when the ad is closed
    [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
        NSString * event = [NSString stringWithFormat:@"javascript:cordova.fireDocumentEvent('onAdClosed', {'zone':'%@'})", identifier];
        [self.commandDelegate evalJs:event];
    }];
}
- (void)mediaBrixAdReward:(NSString *)identifier {
    // Invoked when the user has watched an ad that offers an incentive and reward should be given
    [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
        NSString * event = [NSString stringWithFormat:@"javascript:cordova.fireDocumentEvent('onAdRewardConfirmation', {'zone':'%@'})", identifier];
        [self.commandDelegate evalJs:event];
    }];
    
}
- (void)mediaBrixAdClicked:(NSString *)identifier {
    // Invoked when the user has clicked the ad
    [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
        NSString * event = [NSString stringWithFormat:@"javascript:cordova.fireDocumentEvent('onAdClicked', {'zone':'%@'})", identifier];
        [self.commandDelegate evalJs:event];
    }];
}   

@end

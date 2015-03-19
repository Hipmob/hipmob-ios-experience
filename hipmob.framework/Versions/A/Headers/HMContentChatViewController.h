//
//  HMContentChatViewController.h
//  hipmob
//
//  Created by Olufemi Omojola on 6/1/13.
//  Copyright (c) 2012 - 2015 Orthogonal Labs, Inc.
//
#ifndef _hipmob_hmcontentchatviewcontroller_h_
#define _hipmob_hmcontentchatviewcontroller_h_

#import <UIKit/UIKit.h>
#import "HMChatView.h"

/** The HMContentChatViewControllerDelegate protocol defines the optional methods implemented by delegates of HMContentChatViewController instances. This is largely a wrapper around the internal HMChatView instance, with a number of helpful extras thrown in.
 *
 * The delegate will be notified when a URL is received.
 * All methods are optional
 */
@protocol HMContentChatViewControllerDelegate <NSObject>;

@optional
/** Tells the delegate that a URL was pushed from the server. The delegate may choose to handle the URL itself: if it does, it should
 * return TRUE or YES. If the delegate does not implement this method or if it returns FALSE or NO (i.e. it either does not handle
 * URLs of this format or if it doesn't want to implement any special logic) then the URL will be opened in either an internal WebView OR the platform browser (i.e. Safari) depending on the value of the shouldUseSystemBrowser property.
 *
 * @param contentChatViewController The HMContentChatViewController instance that received the URL.
 * @param url The URL that was received.
 * @param messageId The id of the message that contained the URL. If you have the delegate associated with multiple chat view instances then you may receive multiple calls: you can use the messageId to ensure you only take action a single time.
 * @result TRUE If the delegate handled the URL, FALSE otherwise.
 */
-(BOOL)contentChatViewController:(id)contentChatViewController willHandleURL:(NSString*)url messageId:(NSString*)messageId;

/**
 * Tells the delegate that an error occured in the underlying chat view.
 *
 * @param contentChatViewController The HMContentChatViewController instance that received the error.
 * @param error The error message that occured.
 */
-(void)contentChatViewController:(id)contentChatViewController didErrorOccur:(NSString *)error;

/**
 * Tells the delegate that a message we care about was received.
 *
 * @param contentChatViewController The HMContentChatViewController instance that received the message.
 * @param message The message that was received.
 */
-(void)contentChatViewController:(id)contentChatViewController didReceiveMessage:(HMChatMessage *)message;

/**
 * Tells the delegate that a JSON message we care about was received.
 *
 * @param contentChatViewController The HMContentChatViewController instance that received the message.
 * @param message The message that was received.
 * @param contents An NSDictionary, NSArray, NSString or NSNumber that represents the JSON contents that were received.
 */
-(void)contentChatViewController:(id)contentChatViewController didReceiveMessage:(HMChatMessage *)message withContents:(id)contents;

/**
 * Tells the delegate that a binary message we care about was received.
 *
 * @param contentChatViewController The HMContentChatViewController instance that received the message.
 * @param message The message that was received.
 * @param data An NSData instance that represents the binary contents that were received.
 */
-(void)contentChatViewController:(id)contentChatViewController didReceiveMessage:(HMChatMessage *)message withData:(NSData *)data;

/**
 * Tells the delegate that a message we care about was sent.
 *
 * @param contentChatViewController The HMContentChatViewController instance that received the message.
 * @param message The message that was sent.
 */
-(void)contentChatViewController:(id)contentChatViewController didSendMessage:(HMChatMessage *)message;

/**
 * Tells the delegate that the view controller is closing.
 *
 * @param contentChatViewController The HMContentChatViewController instance that is closing.
 */
-(void)contentChatViewControllerWillDismiss:(id)contentChatViewController;

/**
 * Tells the delegate that an operator came online.
 *
 * @param contentChatViewController The HMContentChatViewController instance that was updated.
 */
-(void)contentChatViewControllerDidOperatorComeOnline:(id)contentChatViewController;

/**
 * Tells the delegate that all operators went offline.
 *
 * @param contentChatViewController The HMContentChatViewController instance that was updated.
 */
-(void)contentChatViewControllerDidOperatorGoOffline:(id)contentChatViewController;

/**
 * Tells the delegate that a specific peer came online.
 *
 * @param contentChatViewController The HMContentChatViewController instance that was updated.
 * @param peer The peer that came online.
 */
-(void)contentChatViewController:(id)contentChatViewController didPeerComeOnline:(NSString *)peer;

/**
 * Tells the delegate that a specific peer went offline.
 *
 * @param contentChatViewController The HMContentChatViewController instance that was updated.
 * @param peer The peer that wend offline.
 */
-(void)contentChatViewController:(id)contentChatViewController didPeerGoOffline:(NSString *)peer;

/**
 * Tells the delegate that a specific picture message was clicked.
 *
 * @param contentChatViewController The HMContentChatViewController instance that generated the click.
 * @param message The message that was clicked. The actual image can be loaded from the file specified in the "file" entry in the message attributes dictionary.
 *
 * @result TRUE If the delegate handled the URL and no further action should be taken, FALSE otherwise (and it should be handled internally).
 */
-(BOOL)contentChatViewController:(id)contentChatViewController didClickPictureMessage:(HMChatMessage *)message;

/**
 * Tells the delegate that a specific audio message message was clicked.
 *
 * @param contentChatViewController The HMContentChatViewController instance that generated the click.
 * @param message The message that was clicked. The actual image can be loaded from the file specified in the "file" entry in the message attributes dictionary.
 *
 * @result TRUE If the delegate handled the URL and no further action should be taken, FALSE otherwise (and it should be handled internally).
 */
-(BOOL)contentChatViewController:(id)contentChatViewController didClickAudioMessage:(HMChatMessage *)message;

/** Tells the delegate that the user wants to send a picture: the delegate will need to take the appropriate steps to obtain a picture and then invoke the sendPictureMessage method on the chatView property.
 *
 * @param contentChatViewController The HMContentChatViewController instance that generated the request.
 *
 */
-(void)contentChatViewControllerDidRequestPictureMessage:(id)contentChatViewController;

/** Tells the delegate that the user wants to send an audio message: the delegate will need to take the appropriate steps to obtain a recording and then invoke the sendAudioMessage method on the chatView property.
 *
 * @param contentChatViewController The HMContentChatViewController instance that generated the request.
 *
 */
-(void)contentChatViewControllerDidRequestAudioMessage:(id)contentChatViewController;

/**
 * Tells the delegate that the connection is ready.
 *
 * @param contentChatViewController The HMContentChatViewController instance that generated the request.
 * @param connectionDefaults The connection defaults received from the server.
 */
-(void)contentChatViewController:(id)contentChatViewController isReady:(NSDictionary *)connectionDefaults;

/**
 * Asks the delegate to give us the height of a specific row. If a value less than 0 is returned then the internal height calculation will be used: this can allow for simple visual overrides of only specific rows.
 *
 * @param contentChatViewController The HMContentChatViewController instance that generated the request.
 * @param message The HMChatMessage instance. This instance is auto released: if it is further retained by the delegate then any additional memory management tasks will need to be handled by the delegate.
 * @param tableView The tableView instance used to render the messages.
 */
-(CGFloat)contentChatViewController:(id)contentChatViewController heightForMessageRow:(HMChatMessage *)message withTableView:(UITableView *)tableView;

/**
 * Asks the delegate to give us the UITableViewCell for a specific message. If a nil value is returned then the default table view cell rendering is used: this can allow for simple visual overrides of only specific rows.
 *
 * @param contentChatViewController The HMContentChatViewController instance that generated the request.
 * @param message The HMChatMessage instance. This instance is auto released: if it is further retained by the delegate then any additional memory management tasks will need to be handled by the delegate.
 * @param tableView The tableView instance used to render the messages.
 */
- (UITableViewCell *)contentChatViewController:(id)contentChatViewController cellForMessageRow:(HMChatMessage *)message withTableView:(UITableView *)tableView;

/**
 * Informs the delegate that a specific message was clicked on.
 *
 * @param contentChatViewController The HMContentChatViewController instance that generated the request.
 * @param message The HMChatMessage instance. This instance is auto released: if it is further retained by the delegate then any additional memory management tasks will need to be handled by the delegate.
 */
- (void)contentChatViewController:(id)contentChatViewController didSelectMessage:(HMChatMessage *)message;
@end

/** Provides a simple UIViewController that renders a full-screen chat window.
 
 This can be used inside a container view controller to embed a chat view within a more complex user interface.
 */
@interface HMContentChatViewController : UIViewController <HMChatViewDelegate, UIGestureRecognizerDelegate>
{
    HMChatView * chatView;
}

/**
 * Returns the actual HMChatView instance that handles the chat.
 */
@property (readonly,nonatomic,retain) HMChatView * chatView;

/**
 * Returns the status indicator that shows online/offline. This can then be hidden.
 */
@property (readonly, nonatomic, retain) UIView * statusView;

/**
 * Set to YES to have the controller open URLs in an external browser. By default URLs are opened in a web view presented in a view controller (defaults to NO).
 */
@property (nonatomic, assign) BOOL shouldUseSystemBrowser;

/**
 * Set to FALSE to prevent the use of swipe gestures for forward/backward navigation when using the built in web view (defaults to NO).
 */
@property (nonatomic, assign) BOOL disableWebViewGestures;

/**
 * Set to YES to have the controller stay in portrait mode (defaults to NO).
 */
@property (nonatomic, assign) BOOL forcePortrait;

/**
 * Set to YES to have the controller require full screen (defaults to NO).
 */
@property (nonatomic, assign) BOOL requireFullscreen;

/**
 * Set to YES to prevent the controller from adjusting for keyboard show/hide (defaults to NO). This is particularly useful when embedding in popover view controllers.
 */
@property (nonatomic, assign) BOOL disableKeyboardAdjustment;

/**
 * Set to YES to prevent the controller from showing the availability indicator.
 */
@property (nonatomic, assign) BOOL hidesAvailabilityIndicator;

/**
 * Sets/return the extra UIBarButtonItems to be shown on the right for this controller. If this is nil
 * then no extra button items are shown.
 */
@property(nonatomic, copy) NSArray * extraBarButtonItems;

/** The HMContentChatViewControllerDelegate for this chat view.
 */
@property (assign) id<HMContentChatViewControllerDelegate> chatDelegate;

///------------------------------------------------------------------------------------------
/// @name Initialization
///------------------------------------------------------------------------------------------
/** Initializes the HMContentChatViewController object to connect with a specific Hipmob app identifier. By default
 * support messages will be shown (messages sent to/from the Hipmob app's operators).
 *
 * The application identifier can be obtained from https://manage.hipmob.com/#apps and will
 * let the Hipmob communication network identify which set of operators, users and other resources
 * to use for this connection. Typically there will be one application identifier for each app.
 * After this call a private connection will be made to the Hipmob communication network for this
 * chat view. Not that when the view is dismissed the connection will be closed.
 *
 * @param appid The Hipmob application identifier for this app.
 * @param user The user identifier for this user. Can be set to nil to use an internally generated id.
 */
-(id) initWithAppID:(NSString *)appid andUser:(NSString *)user;

/** Initializes the HMContentChatViewController object to connect with a specific Hipmob app identifier. By default
 * support messages will be shown (messages sent to/from the Hipmob app's operators).
 *
 * The application identifier can be obtained from https://manage.hipmob.com/#apps and will
 * let the Hipmob communication network identify which set of operators, users and other resources
 * to use for this connection. Typically there will be one application identifier for each app.
 * After this call a private connection will be made to the Hipmob communication network for this
 * chat view. Not that when the view is dismissed the connection will be closed.
 *
 * @param appid The Hipmob application identifier for this app.
 * @param user The user identifier for this user. Can be set to nil to use an internally generated id.
 * @param info Additional connection information to be provided to the connection. Acceptable keys are *name*,
 * *email*, *context* and *pushtoken*.
 */
-(id) initWithAppID:(NSString *)appid andUser:(NSString *)user andInfo:(NSDictionary *)info;

/** Initializes the HMContentChatViewController object to connect with a specific Hipmob app identifier and to show
 * messages to/from a specific peer.
 *
 * The application identifier can be obtained from https://manage.hipmob.com/#apps and will
 * let the Hipmob communication network identify which set of operators, users and other resources
 * to use for this connection. Typically there will be one application identifier for each app.
 * After this call a private connection will be made to the Hipmob communication network for this
 * chat view. Not that when the view is dismissed the connection will be closed.
 *
 * @param appid The Hipmob application identifier for this app.
 * @param user The user identifier for this user. For peer messaging the user identifier MUST NOT be nil.
 * @param peer The device identifier for the peer.
 */
-(id) initWithAppID:(NSString *)appid andUser:(NSString *)user andPeer:(NSString*)peer;

///------------------------------------------------------------------------------------------
/// @name Connection Control
///------------------------------------------------------------------------------------------
/** Connects the chat (if it isn't already connected).
 *
 */
-(void) connect;

/** Disconnects the chat (if it is already connected).
 *
 */
-(void) disconnect;

///------------------------------------------------------------------------------------------
/// @name Connection Status
///------------------------------------------------------------------------------------------
/** Returns TRUE if the chat is connected, false otherwise.
 *
 * @result TRUE if the chat is connected, false otherwise.
 */
-(BOOL) isConnected;

/** Notifies the delegate that a close has been requested.
 *
 */
-(void)closeRequested;
@end
#endif
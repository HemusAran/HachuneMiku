//
//  QCWindow.m
//  HachuneMiku
//
//  Created by mitsuba on 10/04/20.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "QCWindow.h"


@implementation QCWindow

@synthesize initialLocation;


- (void)mouseDown:(NSEvent *)theEvent {    
    // Get the mouse location in window coordinates.
    self.initialLocation = [theEvent locationInWindow];
}


/*
 Once the user starts dragging the mouse, move the window with it. The window has no title bar for the user to drag (so we have to implement dragging ourselves)
 */
- (void)mouseDragged:(NSEvent *)theEvent {
//    NSRect screenVisibleFrame = [[NSScreen mainScreen] visibleFrame];
    NSRect windowFrame = [self frame];
    NSPoint newOrigin = windowFrame.origin;
	
    // Get the mouse location in window coordinates.
    NSPoint currentLocation = [theEvent locationInWindow];
    // Update the origin with the difference between the new mouse location and the old mouse location.
    newOrigin.x += (currentLocation.x - initialLocation.x);
    newOrigin.y += (currentLocation.y - initialLocation.y);
	
    // Don't let window get dragged up under the menu bar
//    if ((newOrigin.y + windowFrame.size.height) > (screenVisibleFrame.origin.y + screenVisibleFrame.size.height)) {
//        newOrigin.y = screenVisibleFrame.origin.y + (screenVisibleFrame.size.height - windowFrame.size.height);
//    }
    
    // Move the window to the new location
    [self setFrameOrigin:newOrigin];
}

///*
- (id)initWithContentRect:(NSRect)contentRect
				styleMask:(NSUInteger)aStyle
				  backing:(NSBackingStoreType)bufferingType
					defer:(BOOL)flag;
//- (id) initWithContentRect : (NSRect) contentRect 
//                 styleMask : (unsigned int) aStyle 
//                   backing : (NSBackingStoreType) bufferingType 
//                     defer : (BOOL) flag 
{
	NSWindow* result = [ super initWithContentRect : contentRect 
										 styleMask : NSBorderlessWindowMask 
										   backing : NSBackingStoreBuffered 
											 defer : NO ]; 
    
	[ result setBackgroundColor : [ NSColor clearColor ] ]; // 透明色で塗る
	[ result setAlphaValue : 1.0 ]; 
	[ result setOpaque : NO ]; 
	[ result setHasShadow : YES ]; 
//	[ result setLevel : NSStatusWindowLevel ];
	
	return result; 
}
//*/

/*
 Spacesで移動しても付いてくるよう設定
 */
- (NSWindowCollectionBehavior)collectionBehavior {
	return NSWindowCollectionBehaviorCanJoinAllSpaces;
}

@end

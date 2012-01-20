//
//  QCWindow.h
//  HachuneMiku
//
//  Created by mitsuba on 10/04/20.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface QCWindow : NSWindow {
    NSPoint initialLocation;
}
@property (assign) NSPoint initialLocation;
@end

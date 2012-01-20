//
//  HachuneMikuAppDelegate.h
//  HachuneMiku
//
//  Created by mitsuba on 10/04/20.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>

#import "QCWindow.h"

@interface HachuneMikuAppDelegate : NSObject { //<NSApplicationDelegate> {
	IBOutlet QCWindow *window;
	IBOutlet QCView* qcView;
	NSTimer *mouseTimer;
	BOOL bMouseTimer;
	
	float width;
	float height;
	
	IBOutlet NSMenuItem *negi1;
	IBOutlet NSMenuItem *negi2;
	IBOutlet NSMenuItem *negi3;
	IBOutlet NSMenuItem *negi4;
	
	IBOutlet NSMenuItem *tati1_1;
	IBOutlet NSMenuItem *tati1_2;
	IBOutlet NSMenuItem *tati1_3;
	IBOutlet NSMenuItem *tati2_1;
	IBOutlet NSMenuItem *tati2_2;
	IBOutlet NSMenuItem *tati2_3;
	
	IBOutlet NSMenuItem *mouseMode;
	IBOutlet NSMenuItem *cpuMode;
    IBOutlet NSMenuItem *mirrorMode;
	
	int viewSizeCount;
}

@property (assign) IBOutlet NSWindow *window;

-(IBAction)mikuSpeedHigh:(id)sender;
-(IBAction)mikuSpeedNormal:(id)sender;
-(IBAction)mikuSpeedLow:(id)sender;
-(IBAction)mikuSpeedSleep:(id)sender;

-(IBAction)windowViewFront:(id)sender;
-(IBAction)windowViewNormal:(id)sender;
-(IBAction)windowViewBack:(id)sender;
-(void)setLevel:(NSInteger)level;

-(void)windowResizeCount:(int)_count;
-(IBAction)windowResizeNormal:(id)sender;
-(IBAction)windowResizeSmall:(id)sender;
-(IBAction)windowResizeBig:(id)sender;

-(IBAction)windowPositionNormal:(id)sender;

-(IBAction)CpuMode:(id)sender;
-(IBAction)mouseFollowMode:(id)sender;
-(IBAction)mirrorMode:(id)sender;
-(void)followCursorUpdate:(NSTimer *)timer;

-(IBAction)help:(id)sender;

@end

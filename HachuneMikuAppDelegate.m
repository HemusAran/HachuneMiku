//
//  HachuneMikuAppDelegate.m
//  HachuneMiku
//
//  Created by mitsuba on 10/04/20.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "HachuneMikuAppDelegate.h"
#include <sys/sysctl.h>

@implementation HachuneMikuAppDelegate

@synthesize window;

- (void) awakeFromNib
{	
	if(![qcView loadCompositionFromFile:[[NSBundle mainBundle] pathForResource:@"miku" ofType:@"qtz"]]) {
		NSLog(@"Could not load composition");
	}
	
	[qcView setValue:[NSNumber numberWithDouble:.1] forInputKey:@"Speed"];
	
	[self windowResizeNormal:nil];
	[self mikuSpeedNormal:nil];
	
	// 起動後にアイコン変更
	NSString *path = [[NSBundle mainBundle] pathForResource:@"sub" ofType:@"icns"];
	NSImage *icns = [[NSImage alloc] initWithContentsOfFile:path];
	[NSApp setApplicationIconImage:icns];
	[icns release];
	
	viewSizeCount = 0;
	bMouseTimer = FALSE;
}


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	// Insert code here to initialize your application 
}



/*
 アプリがアクティブなら操作可、アクティブじゃないなら操作不可（後ろのが操作できる）
 */
- (void)applicationDidResignActive:(NSNotification *)aNotification
{
    [window setIgnoresMouseEvents:YES];
}
- (void)applicationDidBecomeActive:(NSNotification *)aNotification
{
    [window setIgnoresMouseEvents:NO];
}



/*
 ネギ振りスピード
 */
-(void)mikuSpeed:(double)speed
{
	[qcView setValue:[NSNumber numberWithDouble:speed] forInputKey:@"Speed"];
}

-(IBAction)mikuSpeedHigh:(id)sender
{
	[self mikuSpeed:0.15];
}

-(IBAction)mikuSpeedNormal:(id)sender
{
	[self mikuSpeed:0.6];
}

-(IBAction)mikuSpeedLow:(id)sender
{
	[self mikuSpeed:1.2];
}

-(IBAction)mikuSpeedSleep:(id)sender
{
	[self mikuSpeed:1.8];
}


/*
 ウィンドウレベル
 */
-(IBAction)windowViewFront:(id)sender
{
	//[window setLevel:kCGHelpWindowLevel];
	[self setLevel:kCGHelpWindowLevel];
	NSLog(@"%ld",[sender tag]);
}

-(IBAction)windowViewNormal:(id)sender
{
	//[window setLevel:NSNormalWindowLevel];
	[self setLevel:NSNormalWindowLevel];
}

-(IBAction)windowViewBack:(id)sender
{
	//[window setLevel:kCGDesktopWindowLevel];
	[self setLevel:kCGDesktopWindowLevel];
}

-(void)setLevel:(NSInteger)level
{
	if (level == kCGHelpWindowLevel) {
		[tati2_1 setState:NSOnState];
		[tati2_2 setState:NSOffState];
		[tati2_3 setState:NSOffState];
	} else if (level == kCGDesktopWindowLevel) {
		[tati2_1 setState:NSOffState];
		[tati2_2 setState:NSOffState];
		[tati2_3 setState:NSOnState];
	} else {
		level = NSNormalWindowLevel;
		[tati2_1 setState:NSOffState];
		[tati2_2 setState:NSOnState];
		[tati2_3 setState:NSOffState];
	}
	
	[window setLevel:level];
}


/*
 ウィンドウサイズの変更
 */
-(void)windowResizeCount:(int)_count
{
	viewSizeCount += _count;
	float w = 6*_count;
	float h = 4*_count;
	
	NSRect nowRect = [window frame];
	width = nowRect.size.width+w*2;
	height = nowRect.size.height+h*2;
	[window setFrame:NSMakeRect(nowRect.origin.x-w, nowRect.origin.y-h, width, height)
			 display:YES];	
}


/*
 標準サイズに戻す
 */
-(IBAction)windowResizeNormal:(id)sender
{
	float w = 6*viewSizeCount;
	float h = 4*viewSizeCount;
	viewSizeCount = 0;
	
	width = 512.0;
	height = 384.0;
	
	NSRect nowRect = [window frame];
	[window setFrame:NSMakeRect(nowRect.origin.x+w, nowRect.origin.y+h, width, height)
			 display:YES];
}

-(IBAction)windowResizeSmall:(id)sender
{
	[self windowResizeCount:-1];
}

-(IBAction)windowResizeBig:(id)sender
{
	[self windowResizeCount:1];
}


/*
 標準位置に戻す（右下）
 */
-(IBAction)windowPositionNormal:(id)sender
{
	NSRect screen = [[NSScreen mainScreen] frame];
	NSRect nowRect = [window frame];
	[window setFrame:NSMakeRect(screen.size.width-nowRect.size.width, 0, nowRect.size.width, nowRect.size.height)
			 display:YES];
}


/*
 CPUモード
 */
-(IBAction)CpuMode:(id)sender
{
	int state = [cpuMode state];
	
	switch (state) {
		case NSOffState:	// ONにする動作
			[cpuMode setState:NSOnState];
			[negi1 setEnabled:FALSE];
			[negi2 setEnabled:FALSE];
			[negi3 setEnabled:FALSE];
			[negi4 setEnabled:FALSE];
			[qcView setValue:[NSNumber numberWithBool:YES] forInputKey:@"CPUMode"];
			break;
			
		default:	
			[cpuMode setState:NSOffState];
			[negi1 setEnabled:TRUE];
			[negi2 setEnabled:TRUE];
			[negi3 setEnabled:TRUE];
			[negi4 setEnabled:TRUE];
			[qcView setValue:[NSNumber numberWithBool:NO] forInputKey:@"CPUMode"];
			break;
	}	
}


/*
 マウス追跡モード
 */
-(IBAction)mouseFollowMode:(id)sender
{
	int state = [mouseMode state];
	
	switch (state) {
		case NSOffState:	// ONにする動作
			[self windowViewFront:nil];
			[mouseMode setState:NSOnState];
			[tati2_1 setEnabled:FALSE];
			[tati2_2 setEnabled:FALSE];
			[tati2_3 setEnabled:FALSE];	
			bMouseTimer = TRUE;
			break;
			
		default:	
			[mouseMode setState:NSOffState];
			[tati2_1 setEnabled:TRUE];
			[tati2_2 setEnabled:TRUE];
			[tati2_3 setEnabled:TRUE];
			bMouseTimer = FALSE;
			break;
	}
}


/*
 左右逆にするモード
 */
-(IBAction)mirrorMode:(id)sender
{
    int state = [mirrorMode state];
	
	switch (state) {
		case NSOffState:	// ONにする動作
			[mirrorMode setState:NSOnState];
			[qcView setValue:[NSNumber numberWithBool:YES] forInputKey:@"Mirror"];
			break;
			
		default:	
			[mirrorMode setState:NSOffState];
			[qcView setValue:[NSNumber numberWithBool:NO] forInputKey:@"Mirror"];
			break;
	}	
}


/*
 マウスを追いかける処理
 NSTimerではなくNSThreadにしたほうがよい？
 */
-(void)followCursorUpdate:(NSTimer *)timer
{
	NSPoint mouse = [NSEvent mouseLocation];

	[window setFrame:NSMakeRect(mouse.x-width*1/20, mouse.y-height*9/10, width, height)
			 display:YES];
}


/*
 アクティブでなくなるときに呼ばれる
 */
-(void)applicationWillResignActive:(NSNotification *)notif
{
	if (bMouseTimer) {
		mouseTimer = [[NSTimer scheduledTimerWithTimeInterval:0.01 
													   target:self
													 selector:@selector(followCursorUpdate:)
													 userInfo:nil
													  repeats:YES] retain];
	}
}


/*
 アクティブになるときに呼ばれる
 */
-(void)applicationWillBecomeActive:(NSNotification *)notif
{
	if (mouseTimer != nil) {
		[mouseTimer invalidate];
		mouseTimer = nil;
	}	
}


/*
 へるぷ
 */
-(IBAction)help:(id)sender
{
	NSString *url = @"http://sites.google.com/site/nicohemus/home/hachune";
	NSTask *task = [ NSTask launchedTaskWithLaunchPath : @"/usr/bin/open"
											 arguments : [ NSArray arrayWithObjects : 
														  url,
														  nil ] ];
	[ task launch ];
	[ task waitUntilExit ];
	
	[ url release ];
	[ task release ];
}


@end

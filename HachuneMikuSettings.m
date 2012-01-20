#import "HachuneMikuAppDelegate.h"


@interface HachuneMikuAppDelegate (Settings)
@end

@implementation HachuneMikuAppDelegate (Settings)



/*
 アプリケーション開始時に実行
 設定ファイルを読み込んでウィンドウ位置など反映
 */
- (void)applicationWillFinishLaunching : (NSNotification *)aNotification
{	
	NSUserDefaults* ud = [ NSUserDefaults standardUserDefaults ];
	
	[self windowResizeCount:[ud integerForKey:@"viewSizeCount"]];
	//[window setLevel:[ud integerForKey:@"QCWindowLevel"]];
	[self setLevel:[ud integerForKey:@"QCWindowLevel"]];
	
	NSRect nowRect = [window frame];
	[window setFrame:NSMakeRect([ud floatForKey:@"QCWindowOriginX"]
								,[ud floatForKey:@"QCWindowOriginY"]
								,nowRect.size.width
								,nowRect.size.height)
			 display:YES];
	
	if ([ud integerForKey:@"mouseFollowMode"] == NSOnState) {
		[self mouseFollowMode:nil];
	}
	if ([ud integerForKey:@"cpuMode"] == NSOnState) {
		[self CpuMode:nil];
	}

	[window makeKeyAndOrderFront:self];
}


/*
 アプリケーション終了時に実行
 設定ファイルにウィンドウ位置などを保存
 */
- (void)applicationWillTerminate : (NSNotification *)aNotification
{
	NSUserDefaults* ud = [NSUserDefaults standardUserDefaults];
	[ud setInteger:viewSizeCount
			forKey:@"viewSizeCount"];
	
	NSRect nowRect = [window frame];
	[ud setFloat:nowRect.origin.x forKey:@"QCWindowOriginX"];
	[ud setFloat:nowRect.origin.y forKey:@"QCWindowOriginY"];
	
	[ud setInteger:[window level] forKey:@"QCWindowLevel"];
	
	[ud setInteger:[mouseMode state] forKey:@"mouseFollowMode"];
	[ud setInteger:[cpuMode state] forKey:@"cpuMode"];
	
	// 設定ファイルに反映
	[ ud synchronize ];
}


@end

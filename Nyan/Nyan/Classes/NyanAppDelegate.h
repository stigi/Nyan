//
//  NyanAppDelegate.h
//  Nyan
//
//  Created by Ullrich Schäfer on 03.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@class NXNyanControl;

@interface NyanAppDelegate : NSObject <NSApplicationDelegate> {
    NSStatusItem *statusItem;
    NXNyanControl *nyanView;
}

@property (assign) IBOutlet NSMenu *statusMenu;

- (IBAction)quit:(id)sender;

@end

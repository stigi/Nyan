//
//  NyanAppDelegate.m
//  Nyan
//
//  Created by Ullrich Schäfer on 03.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NyanAppDelegate.h"

#import "NXNyanControl.h"


@implementation NyanAppDelegate

#pragma mark Lifecycle

- (void)dealloc;
{
    [nyanView release];
    [statusItem release];
    [super dealloc];
}


#pragma mark Accessors

@synthesize statusMenu;


#pragma mark NSApplicationDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [NSApp setMainMenu:nil];
    statusItem = [[[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength] retain];
    nyanView = [[NXNyanControl alloc] initWithFrame:CGRectMake(0, 0, 150, 22)];
    nyanView.statusItem = statusItem;
    [statusItem setTitle:@"Nyan"];
    [statusItem setView:nyanView];
    [statusItem setMenu:self.statusMenu];
}


#pragma mark Actions

- (IBAction)quit:(id)sender;
{
    [NSApp terminate:sender];
}


@end

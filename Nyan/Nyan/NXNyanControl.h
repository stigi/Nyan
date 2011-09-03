//
//  NXNyanView.h
//  Nyan
//
//  Created by Ullrich Schäfer on 03.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//



@interface NXNyanControl : NSControl {
    NSStatusItem *statusItem;
    BOOL isMenuVisible;
    
    NSArray *frames;
    NSImage *rainbowImage;
    NSImage *spaceImage;
    
    NSTimer *frameTimer;
    NSUInteger currentFrame;
}

@property (retain, nonatomic) NSStatusItem *statusItem;

@end

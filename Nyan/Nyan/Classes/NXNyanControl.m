//
//  NXNyanView.m
//  Nyan
//
//  Created by Ullrich Schäfer on 03.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NXNyanControl.h"

const NSUInteger NXNyanNumberOfFrames = 6;


@interface NXNyanControl ()
- (NSArray *)loadFrames;
- (void)nextFrame:(NSTimer *)timer;
@end


@implementation NXNyanControl

#pragma mark Lifecycle

- (id)initWithFrame:(NSRect)frameRect;
{
    self = [super initWithFrame:frameRect];
    if (self) {
        currentFrame = 0;
        frames = [[self loadFrames] retain];
        spaceImage = [[NSImage imageNamed:@"space.png"] retain];
        rainbowImage = [[NSImage imageNamed:@"rainbow.png"] retain];
        [NSTimer scheduledTimerWithTimeInterval:0.2
                                         target:self
                                       selector:@selector(nextFrame:)
                                       userInfo:nil
                                        repeats:YES];
    }
    return self;
}

- (void)dealloc;
{
    [frameTimer invalidate];
    [frames release];
    [spaceImage release];
    [rainbowImage release];
    [statusItem release];
    [super dealloc];
}


#pragma mark Accessors

@synthesize statusItem;


#pragma mark NSView

- (void)drawRect:(NSRect)dirtyRect;
{
    CGRect bounds = self.bounds;
    [statusItem drawStatusBarBackgroundInRect:bounds
                                withHighlight:isMenuVisible];
    
    NSImage *frameImage = [frames objectAtIndex:currentFrame];
    
    NSRect spaceSrcRect = NSMakeRect(0, 0, spaceImage.size.width, spaceImage.size.height);
    NSRect frameSrcRect = NSMakeRect(0, 0, frameImage.size.width, frameImage.size.height);
    NSRect rainbowSrcRect = NSMakeRect(0, 0, rainbowImage.size.width, rainbowImage.size.height);
    
    CGFloat y = NSMinY(bounds) + (NSHeight(bounds) - NSHeight(frameSrcRect)) / 2;
    y =  roundf(y);
    
    NSRect spaceRect = NSMakeRect(NSMaxX(bounds) - NSWidth(spaceSrcRect) - 5,
                                  y,
                                  NSWidth(spaceSrcRect) + 5,
                                  NSHeight(spaceSrcRect));
    NSRect frameRect = NSMakeRect(NSMinX(spaceRect) - NSWidth(frameSrcRect),
                                  y,
                                  NSWidth(frameSrcRect),
                                  NSHeight(frameSrcRect));
    NSRect rainbowRect = NSMakeRect(NSMinX(bounds),
                                    y,
                                    NSMinX(frameRect),
                                    NSHeight(rainbowSrcRect));
    
    [rainbowImage drawInRect:rainbowRect
                    fromRect:rainbowSrcRect
                   operation:NSCompositeSourceOver
                    fraction:1.0];
    
    [frameImage drawInRect:frameRect
                  fromRect:frameSrcRect
                 operation:NSCompositeSourceOver
                  fraction:1.0];
    
    [spaceImage drawInRect:spaceRect
                  fromRect:spaceSrcRect
                 operation:NSCompositeSourceOver
                  fraction:1.0];
}


#pragma mark Private

- (NSArray *)loadFrames;
{
    NSMutableArray *mutableFrames = [NSMutableArray arrayWithCapacity:NXNyanNumberOfFrames];
    for (NSUInteger frameIndex = 0; frameIndex < NXNyanNumberOfFrames; frameIndex++) {
        NSImage *frame = [NSImage imageNamed:[NSString stringWithFormat:@"nyan-%d.png", frameIndex]];
        [mutableFrames addObject:frame];
    }
    return [[mutableFrames copy] autorelease];
}

- (void)nextFrame:(NSTimer *)timer;
{
    currentFrame++;
    if (currentFrame >= frames.count) {
        currentFrame = 0;
    }
    [self setNeedsDisplay];
}


#pragma mark NSControl

- (void)mouseDown:(NSEvent *)theEvent;
{
    [NSMenu popUpContextMenu:self.statusItem.menu
                   withEvent:theEvent
                     forView:self];
}

@end

//
//  AppController.m
//  NSStatusItemTest
//
//  Created by Matt Gemmell on 04/03/2008.
//  Copyright 2008 Magic Aubergine. All rights reserved.
//

#import "AppController.h"
#import "CustomView.h"
#import "MAAttachedWindow.h"


@implementation AppController


- (void)awakeFromNib
{
    // Create an NSStatusItem.
    float width = 30.0;
    float height = [[NSStatusBar systemStatusBar] thickness];
    NSRect viewFrame = NSMakeRect(0, 0, width, height);
    statusItem = [[[NSStatusBar systemStatusBar] statusItemWithLength:width] retain];
    [statusItem setView:[[[CustomView alloc] initWithFrame:viewFrame controller:self] autorelease]];
}


- (void)dealloc
{
    [[NSStatusBar systemStatusBar] removeStatusItem:statusItem];
    [super dealloc];
}


- (void)toggleAttachedWindowAtPoint:(NSPoint)pt
{
    // Attach/detach window.
    if (!attachedWindow) {
        attachedWindow = [[MAAttachedWindow alloc] initWithView:view 
                                                attachedToPoint:pt 
                                                       inWindow:nil 
                                                         onSide:MAPositionBottom 
                                                     atDistance:5.0];
        [textField setTextColor:[attachedWindow borderColor]];
        [textField setStringValue:@"Your text goes here..."];
        [attachedWindow makeKeyAndOrderFront:self];
    } else {
        [attachedWindow orderOut:self];
        [attachedWindow release];
        attachedWindow = nil;
    }    
}


@end

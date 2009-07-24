//
//  ASSEvent.h
//  GrosoSub
//
//  Created by Josu López Fernández on 14/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ASSTime.h"

@interface ASSEvent : NSObject <NSCopying> {
	Boolean dialogue;
	NSInteger layer;
	ASSTime *start, *end, *duration;;
	NSString *style, *name;
	NSInteger marginL, marginR, marginV;
	NSString *effect, *text;
}

@property (assign) Boolean dialogue;
@property (assign) NSInteger layer;
@property (retain) ASSTime *start;
@property (retain) ASSTime *end;
@property (retain) ASSTime *duration;
@property (copy) NSString *style;
@property (copy) NSString *name;
@property (assign) NSInteger marginL;
@property (assign) NSInteger marginR;
@property (assign) NSInteger marginV;
@property (copy) NSString *effect;
@property (copy) NSString *text;

- (NSString *) description;
- (NSString *) descriptionSRT;

- (void) parseString:(NSString *)aString;
- (id) initWithString:(NSString *)aString; // Designated initializer
- (id) init;

- (void) joinWithEvent:(ASSEvent *)aEvent;

@end

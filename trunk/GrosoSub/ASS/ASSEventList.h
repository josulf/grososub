//
//  ASSEventList.h
//  GrosoSub
//
//  Created by Josu López Fernández on 15/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ASSEvent.h"

@interface ASSEventList : NSObject <NSFastEnumeration> {
	NSMutableArray *events;
	NSMutableArray *actorNames;
}

@property (retain) NSMutableArray *events;
@property (retain) NSMutableArray *actorNames;

- (void) addEventFromString:(NSString *)aString;
- (void) addEventFromString:(NSString *)aString atIndex:(NSUInteger)index;
- (void) addEvent:(ASSEvent *)aEvent;
- (void) addEvent:(ASSEvent *)aEvent atIndex:(NSUInteger)index;
- (void) changeEventFromString:(NSString *)aString atIndex:(NSUInteger)index;
- (void) delEventAtIndex:(NSUInteger)index;
- (void) addDefaultEventAtIndex:(NSUInteger)index;
- (void) dupplicateEventAtIndex:(NSUInteger)index;
- (void) joinEventAtIndex:(NSUInteger)aIndex withEventAtIndex:(NSUInteger)bIndex;
														 
- (ASSEvent *) getEventAtIndex:(NSUInteger)index;

- (NSUInteger) countEvents;
- (void) clean;

- (void) parseString:(NSString *)aString;

- (id) initWithString:(NSString *)aString;
- (id) init;

- (NSString *) description;


@end

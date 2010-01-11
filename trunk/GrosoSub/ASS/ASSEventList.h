//
//  ASSEventList.h
//  GrosoSub
//
//  Created by Josu López Fernández on 15/07/09.
//  Copyright (C) 2009 Josu López Fernández <fregona@fregona.biz>.
//	All rights reserved.
//
//	This program is free software; you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation; only version 2 of the License.
//
//	This program is distributed in the hope that it will be useful,
//	but WITHOUT ANY WARRANTY; without even the implied warranty of
//	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//	GNU General Public License for more details.
//
//	You should have received a copy of the GNU General Public License along
//	with this program; if not, write to the Free Software Foundation, Inc.,
//  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
//

#import <Cocoa/Cocoa.h>
@class ASSEvent;

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
- (NSArray *)eventsAtIndexes:(NSIndexSet *)indexes;

- (NSUInteger) countEvents;
- (void) clean;

- (void) parseString:(NSString *)aString;

- (id) initWithString:(NSString *)aString;
- (id) init;

- (NSString *) description;


@end

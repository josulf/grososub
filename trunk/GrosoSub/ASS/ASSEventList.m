//
//  ASSEventList.m
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

#import "ASSEventList.h"
#import "ASSEvent.h"

@implementation ASSEventList

@synthesize events;
@synthesize actorNames;

- (void) addEventFromString:(NSString *)aString
{
	[events addObject:[[ASSEvent alloc] initWithString:aString]];
	NSArray *elements = [aString componentsSeparatedByString:@","];
	NSString *actor = [elements objectAtIndex:4];
	
	if (![actorNames containsObject:actor]) {
		[actorNames addObject:actor];
		[actorNames sortUsingSelector:@selector(compare:)];
	}
}

- (void) addEventFromString:(NSString *)aString atIndex:(NSUInteger)index
{
	[events insertObject:[[ASSEvent alloc] initWithString:aString] atIndex:index];
	NSArray *elements = [aString componentsSeparatedByString:@","];
	NSString *actor = [elements objectAtIndex:4];
	
	if (![actorNames containsObject:actor]) {
		[actorNames addObject:actor];
		[actorNames sortUsingSelector:@selector(compare:)];
	}
}

- (void) addEvent:(ASSEvent *)aEvent
{
	[events addObject:[aEvent copy]];
	
	NSString *actor = [aEvent name];
	
	if (![actorNames containsObject:actor]) {
		[actorNames addObject:actor];
		[actorNames sortUsingSelector:@selector(compare:)];
	}
}

- (void) addEvent:(ASSEvent *)aEvent atIndex:(NSUInteger)index
{
	[events insertObject:[aEvent copy] atIndex:index];
	
	NSString *actor = [aEvent name];
	
	if (![actorNames containsObject:actor]) {
		[actorNames addObject:actor];
		[actorNames sortUsingSelector:@selector(compare:)];
	}
}

- (void) delEventAtIndex:(NSUInteger)index
{
	[events removeObjectAtIndex:index];
}

- (void) changeEventFromString:(NSString *)aString atIndex:(NSUInteger)index
{
	ASSEvent *new = [[ASSEvent alloc] initWithString:aString];
	NSString *actor = [new name];
	[events replaceObjectAtIndex:index withObject:new];
	if (![actorNames containsObject:actor]) {
		[actorNames addObject:actor];
		[actorNames sortUsingSelector:@selector(compare:)];
	}
}

- (void) addDefaultEventAtIndex:(NSUInteger)index
{
	[self addEventFromString:@"Dialogue: 0,0:00:00.00,0:00:00.00,Default,Default,0000,0000,0000,," atIndex:index];
}

- (void) dupplicateEventAtIndex:(NSUInteger)index
{
	ASSEvent *new = [[self getEventAtIndex:index] copy];
	[events insertObject:new atIndex:index+1];
}

- (void) joinEventAtIndex:(NSUInteger)aIndex withEventAtIndex:(NSUInteger)bIndex
{
	ASSEvent *a = [events objectAtIndex:aIndex];
	ASSEvent *b = [events objectAtIndex:bIndex];
	
	[a joinWithEvent:b];
}

- (ASSEvent *) getEventAtIndex:(NSUInteger)index
{
	return [events objectAtIndex:index];
}

- (NSUInteger) countEvents
{
	return [events count];
}

- (void) clean
{
	[events removeAllObjects];
	[actorNames removeAllObjects];
}

- (void) parseString:(NSString *)aString
{
	NSArray *lines = [aString componentsSeparatedByString:@"\n"];
	
	for (NSString *line in lines) {
		if (([line length] > 0) & ![line isEqualToString:@"\r"]) {
			NSScanner *scanner = [NSScanner scannerWithString:line];
			NSString *aux;
			[scanner scanUpToCharactersFromSet:[NSCharacterSet characterSetWithCharactersInString:@"\r\n"] intoString:&aux];
			[self addEventFromString:aux];
		}
	}
}

- (id) initWithString:(NSString *)aString
{
	if (self = [super init]) {
		events = [[NSMutableArray alloc] init];
		actorNames = [[NSMutableArray alloc] init];
		
		[self parseString:aString];
	}
	return self;
}

- (id) init
{
	[self initWithString:@"Dialogue: 0,0:00:00.00,0:00:00.00,Default,Default,0000,0000,0000,,"];
	return self;
}
	
- (NSString *) description
{
	NSString *out = [[NSString alloc] init];
	
	for (ASSEvent *line in events) {
		out = [out stringByAppendingFormat:@"%@\n", line];
	}
	
	return out;
}

#pragma mark NSFastEnumeration
- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id *)stackbuf count:(NSUInteger)len
{
	return [events countByEnumeratingWithState:state objects:stackbuf count:len];
}

@end

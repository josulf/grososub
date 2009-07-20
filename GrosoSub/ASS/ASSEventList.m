//
//  ASSEventList.m
//  GrosoSub
//
//  Created by Josu López Fernández on 15/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ASSEventList.h"


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
	}
}

- (void) addEventFromString:(NSString *)aString atIndex:(NSUInteger)index
{
	[events insertObject:[[ASSEvent alloc] initWithString:aString] atIndex:index];
	NSArray *elements = [aString componentsSeparatedByString:@","];
	NSString *actor = [elements objectAtIndex:4];
	
	if (![actorNames containsObject:actor]) {
		[actorNames addObject:actor];
	}
}

- (void) addEvent:(ASSEvent *)aEvent atIndex:(NSUInteger)index
{
	[self addEventFromString:[aEvent description] atIndex:index];
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

@end

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

- (void) addEventFromString:(NSString *)aString
{
	[events addObject:[[ASSEvent alloc] initWithString:aString]];
}

- (void) addEventFromString:(NSString *)aString atIndex:(NSUInteger)index
{
	[events insertObject:[[ASSEvent alloc] initWithString:aString] atIndex:index];
}

- (void) delEventAtIndex:(NSUInteger)index
{
	[events removeObjectAtIndex:index];
}

- (void) changeEventFromString:(NSString *)aString atIndex:(NSUInteger)index
{
	[events replaceObjectAtIndex:index withObject:[[ASSEvent alloc] initWithString:aString]];
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

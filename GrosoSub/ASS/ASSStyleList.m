//
//  ASSStyleList.m
//  GrosoSub
//
//  Created by Josu López Fernández on 15/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ASSStyleList.h"


@implementation ASSStyleList

@synthesize styles;
@synthesize styleNames;

- (void) addStyleFromString:(NSString *)aString
{
	[styles addObject:[[ASSStyle alloc] initWithString:aString]];
	[styleNames addObject:[[styles lastObject] name]];
	[styleNames sortUsingSelector:@selector(compare:)];
}

- (void) addStyleFromString:(NSString *)aString atIndex:(NSUInteger)index
{
	[styles insertObject:[[ASSStyle alloc] initWithString:aString] atIndex:index];
	[styleNames addObject:[[styles objectAtIndex:index] name]];
	[styleNames sortUsingSelector:@selector(compare:)];
}

- (void) changeStyleFromString:(NSString *)aString atIndex:(NSUInteger)index
{
	[styleNames removeObject:[[styles objectAtIndex:index] name]];
	[styles replaceObjectAtIndex:index withObject:[[ASSStyle alloc] initWithString:aString]];
	[styleNames addObject:[[styles objectAtIndex:index] name]];
	[styleNames sortUsingSelector:@selector(compare:)];
}

- (void) delStyleAtIndex:(NSUInteger)index
{
	[styleNames removeObject:[[styles objectAtIndex:index] name]];
	[styles removeObjectAtIndex:index];
}

- (ASSStyle *) getStyleAtIndex:(NSUInteger)index
{
	return [styles objectAtIndex:index];
}

- (NSUInteger) countStyles
{
	return [styles count];
}

- (void) clean
{
	[styles removeAllObjects];
	[styleNames removeAllObjects];
}

- (void) parseString:(NSString *)aString
{
	NSArray *lines = [aString componentsSeparatedByString:@"\n"];
	for (NSString *style in lines) {
		if (([style length] > 0) & ![style isEqualToString:@"\r"]) {
			NSScanner *scanner = [NSScanner scannerWithString:style];
			NSString *aux;
			[scanner scanUpToCharactersFromSet:[NSCharacterSet characterSetWithCharactersInString:@"\r\n"] intoString:&aux];
			[self addStyleFromString:aux];
		}
	}
}

- (id) initWithString:(NSString *)aString
{
	if (self = [super init]) {
		styles = [[NSMutableArray alloc] init];
		styleNames = [[NSMutableArray alloc] init];
		
		[self parseString:aString];
	}
	return self;
}

- (id) init
{
	[self initWithString:@"Style: Default,Arial,20,&H00FFFFFF,&H0000FFFF,&H00000000,&H00000000,0,0,0,0,100.00,100.00,0.00,0.00,1,2.00,2.00,2,10,10,10,0"];
	return self;
}

- (NSString *) description
{
	NSString *out = [[NSString alloc] init];
	
	for (ASSStyle *style in styles) {
		
		out = [out stringByAppendingFormat:@"%@\n", [style description]];
	}
	
	return out;
}

@end

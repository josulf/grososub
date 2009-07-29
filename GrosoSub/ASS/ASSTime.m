//
//  ASSTime.m
//  GrosoSub
//
//  Created by Josu López Fernández on 14/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ASSTime.h"

@implementation ASSTime

@synthesize	time;

- (NSString *) description {
	NSString *out;
	NSInteger h, m, s, ht;
	
	h = time / 3600000;
	m = (time - (3600000 * h)) / 60000;
	s = (time - (3600000 * h) - (60000 * m)) / 1000;
	ht = time - (3600000 * h) - (60000 * m) - (1000 * s);

	if (ht >= 100) ht /= 10;
	out = [NSString stringWithFormat:@"%d:%.2d:%.2d.%.2d", h, m, s, ht];
	
	return out;
}

- (NSString *) descriptionSRT
{
	NSString *out;
	NSInteger h, m, s, ht;
	
	h = time / 3600000;
	m = (time - (3600000 * h)) / 60000;
	s = (time - (3600000 * h) - (60000 * m)) / 1000;
	ht = time - (3600000 * h) - (60000 * m) - (1000 * s);
	
	//ht *= 10; //FIX LOL
	out = [NSString stringWithFormat:@"%.2d:%.2d:%.2d,%.3d", h, m, s, ht];
	
	return out;
}

- (void) parseString:(NSString *)aString
{
	NSInteger h, m, s, ht;
	NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@":."];
	NSArray *sections = [aString componentsSeparatedByCharactersInSet:set];
	
	if ([sections count] == 4) {
		h = [[sections objectAtIndex:0] integerValue];
		m = [[sections objectAtIndex:1] integerValue];
		s = [[sections objectAtIndex:2] integerValue];
		ht = [[sections objectAtIndex:3] integerValue];
		
		time = ht + (s * 1000) + (m * 60000) + (h * 3600000);
	}
}

- (id) initWithString:(NSString *)aString
{
	if (self = [super init]) {
		[self parseString:aString];
	}
	return self;
}

- (NSComparisonResult)compare:(ASSTime *)aTime
{
	if ([self time] > [aTime time]) {
		return NSOrderedDescending;
	} else if ([self time] < [aTime time]) {
		return NSOrderedAscending;
	}
	return NSOrderedSame;
}

#pragma mark NSCopying protocol
- (id) copyWithZone:(NSZone *)zone
{
	ASSTime *new = [[ASSTime alloc] init];
	
	[new setTime:[self time]];
	
	return new;
}
@end

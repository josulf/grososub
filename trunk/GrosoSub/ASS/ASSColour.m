//
//  ASSColour.m
//  GrosoSub
//
//  Created by Josu López Fernández on 15/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ASSColour.h"

@implementation ASSColour

@synthesize alpha;
@synthesize red;
@synthesize green;
@synthesize blue;

- (NSString *) description
{
	return [NSString stringWithFormat:@"&H%.2X%.2X%.2X%.2X", alpha, red, green, blue];
}

- (void) parseString:(NSString *)aString
{
	NSScanner *scanner = [NSScanner scannerWithString:aString];
	unsigned p;
	
	[scanner scanString:@"&H" intoString:NULL];
	[scanner scanHexInt:&p];
	alpha = p / 0x1000000;
	red = (p - (alpha*0x1000000)) / 0x10000;
	green = (p - (alpha*0x1000000) - (red*0x10000)) / 0x100;
	blue = p - (alpha*0x1000000) - (red*0x10000) - (green*0x100);
}

- (id) initWithString:(NSString *)aString
{
	if (self = [super init]) {
		[self parseString:aString];
	}
	return self;
}

- (id) init
{
	[self initWithString:@"&H00000000"];
	return self;
}

@end

//
//  ASSColourTest.m
//  GrosoSub
//
//  Created by Josu López Fernández on 15/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ASSColourTest.h"
#import "../ASS/ASSColour.h"

@implementation ASSColourTest

- (void) testNewColour
{
	ASSColour *c = [[ASSColour alloc] init];
	
	STAssertTrue([[c description] isEqualToString:@"&H00000000"], @"A new colour should be &H00000000, but this was %@ instead!", [c description]);
	
	[c release];
}

- (void) testLimitColour
{
	ASSColour *c = [[ASSColour alloc] initWithString:@"&HFFFFFFFF"];
	
	STAssertTrue([[c description] isEqualToString:@"&HFFFFFFFF"], @"The limit colour should be &HFFFFFFFF, but this was %@ instead!", [c description]);
	
	[c release];
}

- (void) testRandomColour
{
	ASSColour *c = [[ASSColour alloc] initWithString:@"&HA4D7830D"];
	
	STAssertTrue([[c description] isEqualToString:@"&HA4D7830D"], @"The limit colour should be &HA4D7830D, but this was %@ instead!", [c description]);
	
	[c release];
}

@end

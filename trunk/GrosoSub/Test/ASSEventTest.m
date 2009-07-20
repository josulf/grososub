//
//  ASSEventTest.m
//  GrosoSub
//
//  Created by Josu López Fernández on 14/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ASSEventTest.h"
#import "../ASS/ASSEvent.h"

@implementation ASSEventTest

- (void) testNewPrintingFormat
{
	ASSEvent *e = [[ASSEvent alloc] init];
	
	STAssertTrue([[e description] isEqualToString:@"Dialogue: 0,0:00:00.00,0:00:00.00,Default,Default,0000,0000,0000,,"],
				 @"A new ASSEvent printed should be Dialogue: 0,0:00:00.00,0:00:00.00,Default,Default,0000,0000,0000,, but was %@ instead!",
				 e);

	[e release];
}

- (void) testParseString
{
	ASSEvent *e = [[ASSEvent alloc] initWithString:@"Dialogue: 0,1:46:18.52,1:46:22.45,Gurren,Simon,0000,0000,0000,,No lo sé, pero por qué has nacido o que seas una princesa no son cosas importantes."];
	
	STAssertTrue([[e description] isEqualToString:@"Dialogue: 0,1:46:18.52,1:46:22.45,Gurren,Simon,0000,0000,0000,,No lo sé, pero por qué has nacido o que seas una princesa no son cosas importantes."],
				  @"This ASSEvent should be Dialogue: 0,1:46:18.52,1:46:22.45,Gurren,Simon,0000,0000,0000,,No lo sé, pero por qué has nacido o que seas una princesa no son cosas importantes. but was %@ instead!",
				  e);
	
	[e release];
}

- (void) testJoin
{
	ASSEvent *a1 = [[ASSEvent alloc] initWithString:@"Dialogue: 0,0:00:00.00,0:00:00.00,Default,Default,0000,0000,0000,,Bat"];
	ASSEvent *a2 = [[ASSEvent alloc] initWithString:@"Dialogue: 0,0:00:00.00,0:00:00.00,Default,Default,0000,0000,0000,,Bi"];
	
	ASSEvent *b3 = [[ASSEvent alloc] initWithString:@"Dialogue: 0,1:00:00.00,2:00:00.00,Default,Default,0000,0000,0000,,Hiru"];
	ASSEvent *b4 = [[ASSEvent alloc] initWithString:@"Dialogue: 0,2:00:00.00,3:00:00.00,Default,Default,0000,0000,0000,,Lau"];
	
	ASSEvent *c3 = [[ASSEvent alloc] initWithString:@"Dialogue: 0,1:00:00.00,2:00:00.00,Default,Default,0000,0000,0000,,Hiru"];
	ASSEvent *c4 = [[ASSEvent alloc] initWithString:@"Dialogue: 0,2:00:00.00,3:00:00.00,Default,Default,0000,0000,0000,,Lau"];
	
	ASSEvent *d3 = [[ASSEvent alloc] initWithString:@"Dialogue: 0,1:00:00.00,2:00:00.00,Default,Default,0000,0000,0000,,Hiru"];
	ASSEvent *d5 = [[ASSEvent alloc] initWithString:@"Dialogue: 0,3:00:00.00,4:00:00.00,Default,Default,0000,0000,0000,,Bost"];
	
	ASSEvent *e1 = [[ASSEvent alloc] initWithString:@"Dialogue: 0,0:00:00.00,0:00:00.00,Default,Default,0000,0000,0000,,Bat"];
	ASSEvent *e6 = [[ASSEvent alloc] initWithString:@"Dialogue: 0,1:00:00.00,4:00:00.00,Default,Default,0000,0000,0000,,Sei"];
	
	[a1 joinWithEvent:a2];
	[b3 joinWithEvent:b4];
	[c4 joinWithEvent:c3];
	[d3 joinWithEvent:d5];
	[e1 joinWithEvent:e6];
	
	STAssertTrue([[a1 description] isEqualToString:@"Dialogue: 0,0:00:00.00,0:00:00.00,Default,Default,0000,0000,0000,,Bat\\NBi"],
				 @"This should be Dialogue: 0,0:00:00.00,0:00:00.00,Default,Default,0000,0000,0000,,Bat\\NBi, but was %@ instead!", [a1 description]);
	STAssertTrue([[b3 description] isEqualToString:@"Dialogue: 0,1:00:00.00,3:00:00.00,Default,Default,0000,0000,0000,,Hiru\\NLau"],
				 @"This should be Dialogue: 0,1:00:00.00,3:00:00.00,Default,Default,0000,0000,0000,,Hiru\\NLau, but was %@ instead!", [b3 description]);
	STAssertTrue([[c4 description] isEqualToString:@"Dialogue: 0,1:00:00.00,3:00:00.00,Default,Default,0000,0000,0000,,Lau\\NHiru"],
				 @"This should be Dialogue: 0,1:00:00.00,3:00:00.00,Default,Default,0000,0000,0000,,Lau\\NHiru, but was %@ instead!", [c4 description]);
	STAssertTrue([[d3 description] isEqualToString:@"Dialogue: 0,1:00:00.00,4:00:00.00,Default,Default,0000,0000,0000,,Hiru\\NBost"],
				 @"This should be Dialogue: 0,1:00:00.00,4:00:00.00,Default,Default,0000,0000,0000,,Hiru\\NBost, but was %@ instead!", [d3 description]);
	STAssertTrue([[e1 description] isEqualToString:@"Dialogue: 0,0:00:00.00,4:00:00.00,Default,Default,0000,0000,0000,,Bat\\NSei"],
				 @"This should be Dialogue: 0,0:00:00.00,4:00:00.00,Default,Default,0000,0000,0000,,Bat\\NSei, but was %@ instead!", [e1 description]);
}
@end

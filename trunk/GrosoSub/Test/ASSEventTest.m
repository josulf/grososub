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

@end

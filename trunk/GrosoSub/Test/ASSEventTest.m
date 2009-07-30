//
//  ASSEventTest.m
//  GrosoSub
//
//  Created by Josu López Fernández on 14/07/09.
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

#import "ASSEventTest.h"
#import "ASSEvent.h"

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

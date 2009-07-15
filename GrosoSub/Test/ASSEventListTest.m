//
//  ASSEventListTest.m
//  GrosoSub
//
//  Created by Josu López Fernández on 15/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ASSEventListTest.h"
#import "../ASS/ASSEventList.h"

@implementation ASSEventListTest

- (void) testCreateASSEventList
{
	ASSEventList *el = [[ASSEventList alloc] init];
	
	STAssertEquals((NSUInteger)1, [el countEvents], @"A new ASSEventList should have 1 event, but this has %d objects!", [el countEvents]);
	
	[el release];
}

- (void) testAddGetReplaceDelEvent
{
	ASSEventList *el = [[ASSEventList alloc] init];
	[el addEventFromString:@"Dialogue: 0,1:51:35.34,1:51:37.11,Gurren,Lordgenome,0000,0000,0000,,No temáis."];
	STAssertEquals((NSUInteger)2, [el countEvents], @"This should have 2 object, but has %d objects!", [el countEvents]);
	STAssertTrue([[[el getEventAtIndex:1] description] isEqualToString:@"Dialogue: 0,1:51:35.34,1:51:37.11,Gurren,Lordgenome,0000,0000,0000,,No temáis."],
				 @"Two events should be the same, by they aren't!");
	
	[el addEventFromString:@"Dialogue: 0,1:46:25.73,1:46:28.31,Gurren,Simon,0000,0000,0000,,Por eso deberías vivir a tu manera."];
	STAssertEquals((NSUInteger)3, [el countEvents], @"This should have 3 objects, but has %d objects!", [el countEvents]);
	STAssertTrue([[[el getEventAtIndex:2] description] isEqualToString:@"Dialogue: 0,1:46:25.73,1:46:28.31,Gurren,Simon,0000,0000,0000,,Por eso deberías vivir a tu manera."],
				 @"Two events should be the same, by they aren't!");
	
	[el delEventAtIndex:0];
	STAssertEquals((NSUInteger)2, [el countEvents], @"This should have 2 object, but has %d objects!", [el countEvents]);
	STAssertTrue([[[el getEventAtIndex:1] description] isEqualToString:@"Dialogue: 0,1:46:25.73,1:46:28.31,Gurren,Simon,0000,0000,0000,,Por eso deberías vivir a tu manera."],
				 @"Two events should be the same, by they aren't!");
	
	[el changeEventFromString:@"Dialogue: 0,1:46:46.99,1:46:47.72,Gurren,Simon,0000,0000,0000,,Yoko..." atIndex:0];
	STAssertEquals((NSUInteger)2, [el countEvents], @"This should have 2 object, but has %d objects!", [el countEvents]);
	STAssertTrue([[[el getEventAtIndex:0] description] isEqualToString:@"Dialogue: 0,1:46:46.99,1:46:47.72,Gurren,Simon,0000,0000,0000,,Yoko..."],
				 @"Two events should be the same, by they aren't!");
	
	[el addEventFromString:@"Dialogue: 0,1:39:30.48,1:39:31.42,Gurren,Simon,0000,0000,0000,,¡Unámonos!" atIndex:0];
	STAssertEquals((NSUInteger)3, [el countEvents], @"This should have 3 objects, but has %d objects!", [el countEvents]);
	STAssertTrue([[[el getEventAtIndex:0] description] isEqualToString:@"Dialogue: 0,1:39:30.48,1:39:31.42,Gurren,Simon,0000,0000,0000,,¡Unámonos!"],
				 @"Two events should be the same, by they aren't!");
	
	[el release];
}

- (void) testParseString
{
	ASSEventList *el = [[ASSEventList alloc] initWithString:@"Dialogue: 0,1:39:32.29,1:39:32.85,Gurren,Rossiu,0000,0000,0000,,¡Sí!\nDialogue: 0,1:39:37.71,1:39:38.94,Gurren,Viral,0000,0000,0000,,¡Maldito...!\nDialogue: 0,1:39:41.83,1:39:42.96,Gurren,Viral,0000,0000,0000,,¿Qué estás intentando?"];
	
	STAssertEquals((NSUInteger)3, [el countEvents], @"This should have 3 objects, but has %d objects!", [el countEvents]);
	STAssertTrue([[[el getEventAtIndex:0] description] isEqualToString:@"Dialogue: 0,1:39:32.29,1:39:32.85,Gurren,Rossiu,0000,0000,0000,,¡Sí!"],
				 @"Two events aren't the same");
	STAssertTrue([[[el getEventAtIndex:1] description] isEqualToString:@"Dialogue: 0,1:39:37.71,1:39:38.94,Gurren,Viral,0000,0000,0000,,¡Maldito...!"],
				 @"Two events aren't the same");
	STAssertTrue([[[el getEventAtIndex:2] description] isEqualToString:@"Dialogue: 0,1:39:41.83,1:39:42.96,Gurren,Viral,0000,0000,0000,,¿Qué estás intentando?"],
				 @"Two events aren't the same");
	
	[el release];

}

@end

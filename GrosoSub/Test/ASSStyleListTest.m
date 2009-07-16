//
//  ASSStyleListTest.m
//  GrosoSub
//
//  Created by Josu López Fernández on 15/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ASSStyleListTest.h"
#import "../ASS/ASSStyleList.h"

@implementation ASSStyleListTest

- (void) testCreateASSStyleList
{
	ASSStyleList *sl = [[ASSStyleList alloc] init];
	
	STAssertEquals((NSUInteger)1, [sl countStyles], @"A new ASSStyleList should have 1 style, but this has %d objects!", [sl countStyles]);
	
	[sl release];
}

- (void) testParseString
{
	ASSStyleList *sl = [[ASSStyleList alloc] initWithString:@"Style: Gurren,FrancophilSans,33,&H00FFFFFF,&H00FFFFFF,&H0A000000,&H96000000,-1,0,0,0,85,100,0,0,1,1.5,0.5,2,20,20,20,0\n"
						"Style: TS,DFMincho-Edit,55,&H00FFFFFF,&H000000FF,&H00000000,&H00000000,0,0,0,0,83,100,0,0,1,0,2.3,2,10,10,10,1\n"
						"Style: TS2,DFMincho-Edit,55,&H00000000,&H000000FF,&H00D7D7D7,&H00000000,0,0,0,0,83,100,0,0,1,1.5,0,2,10,10,10,1"];
	
	STAssertEquals((NSUInteger)3, [sl countStyles], @"This should have 3 objects, but has %d objects!", [sl countStyles]);
	STAssertTrue([[[sl getStyleAtIndex:0] description] isEqualToString:@"Style: Gurren,FrancophilSans,33,&H00FFFFFF,&H00FFFFFF,&H0A000000,&H96000000,-1,0,0,0,85,100,0,0,1,1.5,0.5,2,20,20,20,0"],
				 @"Two events aren't the same");
	STAssertTrue([[[sl getStyleAtIndex:1] description] isEqualToString:@"Style: TS,DFMincho-Edit,55,&H00FFFFFF,&H000000FF,&H00000000,&H00000000,0,0,0,0,83,100,0,0,1,0,2.3,2,10,10,10,1"],
				 @"Two events aren't the same");
	STAssertTrue([[[sl getStyleAtIndex:2] description] isEqualToString:@"Style: TS2,DFMincho-Edit,55,&H00000000,&H000000FF,&H00D7D7D7,&H00000000,0,0,0,0,83,100,0,0,1,1.5,0,2,10,10,10,1"],
				 @"Two events aren't the same");
	
	[sl release];
	
}

- (void) testPerry
{
	ASSStyleList *sl = [[ASSStyleList alloc] initWithString:@"Style: Gurren,FrancophilSans,33,&H00FFFFFF,&H00FFFFFF,&H0A000000,&H96000000,-1,0,0,0,85.00,100.00,0.00,0.00,1,1.50,0.50,2,20,20,20,0\n"
	"Style: TS,DFMincho-Edit,55,&H00FFFFFF,&H000000FF,&H00000000,&H00000000,0,0,0,0,83.00,100.00,0.00,0.00,1,0.00,2.30,2,10,10,10,1\n"
	"Style: TS2,DFMincho-Edit,55,&H00000000,&H000000FF,&H00D7D7D7,&H00000000,0,0,0,0,83.00,100.00,0.00,0.00,1,1.50,0.00,2,10,10,10,1\n"
						"Style: Title,LeviBrush,70,&H00000000,&H000000FF,&H00D7D7D7,&H00000000,0,0,0,0,100,100,0,0,1,0,0,1,10,10,10,1"];
	NSLog([sl description]);
	
}

@end

//
//  ASSStyleTest.m
//  GrosoSub
//
//  Created by Josu López Fernández on 15/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ASSStyleTest.h"
#import "../ASS/ASSStyle.h"

@implementation ASSStyleTest

- (void) testNewStyle
{
	ASSStyle *s = [[ASSStyle alloc] init];
	
	STAssertTrue([[s description] isEqualToString:@"Style: Default,Arial,20,&H00FFFFFF,&H0000FFFF,&H00000000,&H00000000,0,0,0,0,100,100,0,0,1,2,2,2,10,10,10,0"],
				 @"The new style should be Style: Default,Arial,20,&H00FFFFFF,&H0000FFFF,&H00000000,&H00000000,0,0,0,0,100,100,0,0,1,2,2,2,10,10,10,0, but was %@ instead!",
				 [s description]);
	
	[s release];
}

- (void) testRandomStyle
{
	ASSStyle *s = [[ASSStyle alloc] initWithString:@"Style: TS2,DFMincho-Edit,55,&H00000000,&H000000FF,&H00D7D7D7,&H00000000,0,0,0,0,83,100,0,0,1,1.5,0,2,10,10,10,1"];
	
	STAssertTrue([[s description] isEqualToString:@"Style: TS2,DFMincho-Edit,55,&H00000000,&H000000FF,&H00D7D7D7,&H00000000,0,0,0,0,83,100,0,0,1,1.5,0,2,10,10,10,1"],
				 @"The random style should be Style: TS2,DFMincho-Edit,55,&H00000000,&H000000FF,&H00D7D7D7,&H00000000,0,0,0,0,83,100,0,0,1,1.5,0,2,10,10,10,1, but was %@ instead!",
				 [s description]);
	
	[s release];
}

- (void) testBoolean
{
	ASSStyle *s = [[ASSStyle alloc] initWithString:@"Style: Default,Arial,20,&H00FFFFFF,&H0000FFFF,&H00000000,&H00000000,-1,-1,-1,-1,100,100,0,0,1,2,2,2,10,10,10,0"];
	
	STAssertTrue([[s description] isEqualToString:@"Style: Default,Arial,20,&H00FFFFFF,&H0000FFFF,&H00000000,&H00000000,-1,-1,-1,-1,100,100,0,0,1,2,2,2,10,10,10,0"],
				 @"This style should be Style: Default,Arial,20,&H00FFFFFF,&H0000FFFF,&H00000000,&H00000000,-1,-1,-1,-1,100,100,0,0,1,2,2,2,10,10,10,0, but was %@ instead!",
				 [s description]);
	
	[s release];
}

@end

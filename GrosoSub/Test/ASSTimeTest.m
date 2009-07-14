//
//  ASSTimeTest.m
//  GrosoSub
//
//  Created by Josu López Fernández on 14/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ASSTimeTest.h"
#import "../ASS/ASSTime.h"

@implementation ASSTimeTest
- (void) testNewPrintingFormat
{
	ASSTime *t = [[ASSTime alloc] init];

	STAssertTrue([[t description] isEqualToString:@"0:00:00.00"],
				   @"A new ASSTime printed should be 0:00:00.00, but was %@ instead!", t);
	
	[t release];
}

- (void) testPrintingFormat
{
	ASSTime *t = [[ASSTime alloc] init];
	[t setTime:5555555.0f];
	
	STAssertTrue([[t description] isEqualToString:@"1:32:35.55"],
				 @"A new ASSTime printed should be 1:32:35.55, but was %@ instead!", t);
	
	[t release];
}

- (void) testParseString
{
	ASSTime *t = [[ASSTime alloc] init];
	[t parseString:@"1:44:03.88"];

	STAssertTrue([[t description] isEqualToString:@"1:44:03.88"],
				 @"This should be 1:44:03.88, but was %@ instead!", t);
	
	[t release];
}

- (void) testDesignatedInitializer
{
	ASSTime *t = [[ASSTime alloc] initWithString:@"1:44:03.88"];
	
	STAssertTrue([[t description] isEqualToString:@"1:44:03.88"],
				 @"This should be 1:44:03.88, but was %@ instead!", t);
	
	[t release];
	
}

@end

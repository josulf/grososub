//
//  ASSTimeTest.m
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

#import "ASSTimeTest.h"
#import "ASSTime.h"

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

- (void) testCompare
{
	ASSTime *t1 = [[ASSTime alloc] initWithString:@"1:44:03.88"];
	ASSTime *t2 = [[ASSTime alloc] initWithString:@"1:44:03.88"];
	ASSTime *t3 = [[ASSTime alloc] initWithString:@"1:44:06.88"];
	
	STAssertTrue([t1 compare:t2] == NSOrderedSame, @"This should be the same");
	STAssertTrue([t1 compare:t3] == NSOrderedAscending, @"t1 should be less than t3");
	STAssertTrue([t3 compare:t2] == NSOrderedDescending, @"t3 should be greater than t2");
}

@end

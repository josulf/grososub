//
//  ASSStyleListTest.m
//  GrosoSub
//
//  Created by Josu López Fernández on 15/07/09.
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

#import "ASSStyleListTest.h"
#import "ASSStyleList.h"

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

@end

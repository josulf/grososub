//
//  ASSStyleTest.m
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

#import "ASSStyleTest.h"
#import "ASSStyle.h"

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

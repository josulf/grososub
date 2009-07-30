//
//  ASSHeaderTest.m
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

#import "ASSHeaderTest.h"
#import "ASSHeader.h"

@implementation ASSHeaderTest

- (void) testDefaultHeader
{
	ASSHeader *h = [[ASSHeader alloc] init];
	
	STAssertTrue([[h getValueForKey:@"Title"] isEqualToString:@"Default GrosoSub script"], @"Title is not equal!");
	STAssertTrue([[h getValueForKey:@"PlayResX"] isEqualToString:@"640"], @"PlayResX is not equal!");
	STAssertTrue([[h getValueForKey:@"PlayResY"] isEqualToString:@"480"], @"PlayResY is not equal!");
	STAssertTrue([[h getValueForKey:@"ScriptType"] isEqualToString:@"v4.00+"], @"ScriptType is not equal!");
	STAssertEquals([[h headerList] count], [[h order] count], @"order has %d elements and headerList %d, they should have the same!", [[h headerList] count], [[h order] count]);
	
	[h release];
}

- (void) testHeaderImport
{
	ASSHeader *h = [[ASSHeader alloc] initWithString:@"Title: Default Aegisub file\n"
					"ScriptType: v4.00+\n"
					"WrapStyle: 0\n"
					"PlayResX: 720\n"
					"PlayResY: 480\n"
					"ScaledBorderAndShadow: yes\n"
					"Video Aspect Ratio: 0\n"
					"Video Zoom: 6\n"
					"Video Position: 0\n"
					"Collisions: Normal\n"
					"Last Style Storage: GurrenMovie\n"
					"Audio File: audiodump.wav\n"
					"AutoComplete: Nia|Adiane|Leeron|Yoko|Simon|Rey|Viral|Otros|Kittan|Guame|Cytomander|Rossiu|Cartel|Especial|Kamina|Mecha|Gimmy|Gulaparl|Darry|Antiespiral|Boota|Espiral|Lordgenome|Rey Espiral|Gunmen|Cytomander el Veloz|Guame el Firme|Adiane la Elegante|Thymilph el Torbellino|Dayakka|Attenborough|Kiyoh|Kinon|Kiyal|Jougan|Barinbou|Brigada Gurren|Thymilph|Generales Supremos\n"
					"PerrySubVersion: PerrySub 0.8.12.1"];

	STAssertTrue([[h getValueForKey:@"PerrySubVersion"] isEqualToString:@"PerrySub 0.8.12.1"], @"PerrySubVersion is not equal!");
	STAssertTrue([h count] == (NSUInteger) 14, @"This should have 14 headers, but has %d instead!", [h count]);
	
	[h release];
}

- (void) testHeaderAddDel
{
	ASSHeader *h = [[ASSHeader alloc] init];
	
	STAssertTrue([[h getValueForKey:@"Title"] isEqualToString:@"Default GrosoSub script"], @"Title is not equal!");
	STAssertTrue([[h getValueForKey:@"PlayResX"] isEqualToString:@"640"], @"PlayResX is not equal!");
	STAssertTrue([[h getValueForKey:@"PlayResY"] isEqualToString:@"480"], @"PlayResY is not equal!");
	STAssertTrue([[h getValueForKey:@"ScriptType"] isEqualToString:@"v4.00+"], @"ScriptType is not equal!");
	STAssertEquals([[h headerList] count], [[h order] count], @"headerList has %d elements and order %d, they should have the same!", [[h headerList] count], [[h order] count]);
	[h setValue:@"Perry" forKey:@"Mason"];
	STAssertEquals([[h headerList] count], [[h order] count], @"headerList has %d elements and order %d, they should have the same!", [[h headerList] count], [[h order] count]);
	[h setValue:@"Tolín" forKey:@"Mason"];
	STAssertEquals([[h headerList] count], [[h order] count], @"headerList has %d elements and order %d, they should have the same!", [[h headerList] count], [[h order] count]);
	[h delKey:@"Title"];
	STAssertEquals([[h headerList] count], [[h order] count], @"headerList has %d elements and order %d, they should have the same!", [[h headerList] count], [[h order] count]);

	[h release];
}

@end

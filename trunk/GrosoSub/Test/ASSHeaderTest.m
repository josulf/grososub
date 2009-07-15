//
//  ASSHeaderTest.m
//  GrosoSub
//
//  Created by Josu López Fernández on 15/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ASSHeaderTest.h"
#import "../ASS/ASSHeader.h"

@implementation ASSHeaderTest

- (void) testDefaultHeader
{
	ASSHeader *h = [[ASSHeader alloc] init];
	
	STAssertTrue([[h getValueForKey:@"Title"] isEqualToString:@"Default GrosoSub script"], @"Title is not equal!");
	STAssertTrue([[h getValueForKey:@"PlayResX"] isEqualToString:@"640"], @"PlayResX is not equal!");
	STAssertTrue([[h getValueForKey:@"PlayResY"] isEqualToString:@"480"], @"PlayResY is not equal!");
	STAssertTrue([[h getValueForKey:@"ScriptType"] isEqualToString:@"v4.00+"], @"ScriptType is not equal!");
	
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

@end

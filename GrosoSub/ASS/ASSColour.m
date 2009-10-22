//
//  ASSColour.m
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

#import "ASSColour.h"

@implementation ASSColour

@synthesize alpha;
@synthesize red;
@synthesize green;
@synthesize blue;

- (NSString *) description
{
	//AABBGGRR
	return [NSString stringWithFormat:@"&H%.2X%.2X%.2X%.2X", alpha, blue, green, red];
}

- (void) parseString:(NSString *)aString
{
	NSScanner *scanner = [NSScanner scannerWithString:aString];
	unsigned p;
	
	[scanner scanString:@"&H" intoString:NULL];
	[scanner scanHexInt:&p];
	alpha = p / 0x1000000;
	blue = (p - (alpha*0x1000000)) / 0x10000;
	green = (p - (alpha*0x1000000) - (blue*0x10000)) / 0x100;
	red = p - (alpha*0x1000000) - (blue*0x10000) - (green*0x100);
}

- (id) initWithString:(NSString *)aString
{
	if (self = [super init]) {
		[self parseString:aString];
	}
	return self;
}

- (id) initWithColor:(NSColor *)color
{
	if (self = [super init]) {
		CGFloat r,g,b,a;
		[color getRed:&r green:&g blue:&b alpha:&a];
		[self setRed:r*255.0];
		[self setGreen:g*255.0];
		[self setBlue:b*255.0];
	}
	return self;
}

- (id) init
{
	[self initWithString:@"&H00000000"];
	return self;
}

- (NSColor *) nsColor
{
	CGFloat r = (CGFloat) red / 255.0;
	CGFloat g = (CGFloat) green / 255.0;
	CGFloat b = (CGFloat) blue / 255.0;
	return [NSColor colorWithCalibratedRed:r green:g blue:b alpha:1.0];
}

@end

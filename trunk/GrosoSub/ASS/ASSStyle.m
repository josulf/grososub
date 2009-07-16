//
//  ASSStyle.m
//  GrosoSub
//
//  Created by Josu López Fernández on 15/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ASSStyle.h"


@implementation ASSStyle

@synthesize name;
@synthesize fontName;
@synthesize fontSize;
@synthesize primaryColour;
@synthesize secondaryColour;
@synthesize outlineColour;
@synthesize backColour;
@synthesize bold;
@synthesize italic;
@synthesize underline;
@synthesize strikeOut;
@synthesize scaleX;
@synthesize scaleY;
@synthesize spacing;
@synthesize angle;
@synthesize borderStyle;
@synthesize outline;
@synthesize shadow;
@synthesize alignment;
@synthesize marginL;
@synthesize marginR;
@synthesize marginV;
@synthesize encoding;

- (NSString *) description
{
	return [NSString stringWithFormat:@"Style: %@,%@,%d,%@,%@,%@,%@,%d,%d,%d,%d,%@,%@,%@,%@,%d,%@,%@,%d,%d,%d,%d,%d",
									  name, fontName, fontSize, primaryColour, secondaryColour, outlineColour, backColour,
									  (bold? -1 : 0), (italic? -1 : 0), (underline? -1 : 0), (strikeOut? -1 : 0),
									  [ASSStyle beautyfulFloat:scaleX], [ASSStyle beautyfulFloat:scaleY], [ASSStyle beautyfulFloat:spacing],
									  [ASSStyle beautyfulFloat:angle], borderStyle, [ASSStyle beautyfulFloat:outline], [ASSStyle beautyfulFloat:shadow],
									  alignment, marginL, marginR, marginV, encoding];
}

- (void) parseString:(NSString *)aString
{
	NSString *style;
	NSScanner *scanner = [NSScanner scannerWithString:aString];
	[scanner scanString:@"Style: " intoString:NULL];
	[scanner scanUpToString:@"\n" intoString:&style];
	
	NSArray *elements = [style componentsSeparatedByString:@","];
	
	//name = [[elements objectAtIndex:0] description];
	name = [name stringByAppendingString:[elements objectAtIndex:0]];
	//fontName = [[elements objectAtIndex:1] description];
	fontName = [fontName stringByAppendingString:[elements objectAtIndex:1]];
	fontSize = [[elements objectAtIndex:2] integerValue];
	[primaryColour parseString:[elements objectAtIndex:3]];
	[secondaryColour parseString:[elements objectAtIndex:4]];
	[outlineColour parseString:[elements objectAtIndex:5]];
	[backColour parseString:[elements objectAtIndex:6]];
	bold = ([[elements objectAtIndex:7] integerValue] == -1 ? YES : NO);
	italic = ([[elements objectAtIndex:8] integerValue] == -1 ? YES : NO);
	underline = ([[elements objectAtIndex:9] integerValue] == -1 ? YES : NO);
	strikeOut = ([[elements objectAtIndex:10] integerValue] == -1 ? YES : NO);
	scaleX = [[elements objectAtIndex:11] floatValue];
	scaleY = [[elements objectAtIndex:12] floatValue];
	spacing = [[elements objectAtIndex:13] floatValue];
	angle = [[elements objectAtIndex:14] floatValue];
	borderStyle = [[elements objectAtIndex:15] boolValue];
	outline = [[elements objectAtIndex:16] floatValue];
	shadow = [[elements objectAtIndex:17] floatValue];
	alignment = [[elements objectAtIndex:18] integerValue];
	marginL = [[elements objectAtIndex:19] integerValue];
	marginR = [[elements objectAtIndex:20] integerValue];
	marginV = [[elements objectAtIndex:21] integerValue];
	encoding = [[elements objectAtIndex:22] integerValue];
	
}

- (id) initWithString:(NSString *)aString
{
	if (self = [super init]) {
		name = [[NSString alloc] init];
		fontName = [[NSString alloc] init];
		primaryColour = [[ASSColour alloc] init];
		secondaryColour = [[ASSColour alloc] init];
		outlineColour = [[ASSColour alloc] init];
		backColour = [[ASSColour alloc] init];
		
		[self parseString:aString];
	}
	return self;
}

- (id) init
{
	return [self initWithString:@"Style: Default,Arial,20,&H00FFFFFF,&H0000FFFF,&H00000000,&H00000000,0,0,0,0,100.00,100.00,0.00,0.00,1,2.00,2.00,2,10,10,10,0"];
}

+ (NSString *) beautyfulFloat:(CGFloat)aFloat
{
	NSInteger decimals;
	NSString *out = [NSString stringWithFormat:@"%.2f", aFloat]; // "10.00" string
	NSScanner *scanner = [NSScanner scannerWithString:out]; // a scanner with the "10.00" string
	[scanner scanUpToString:@"." intoString:NULL];
	NSUInteger p = [scanner scanLocation]; // save location of point
	[scanner scanString:@"." intoString:NULL];
	[scanner scanInteger:&decimals]; // read decimal part of the string
	if (decimals == 0) { // 10.00 -> 10
		return [out substringToIndex:p];
	} else if ((decimals % 10) == 0) { //10.30 -> 10.3
		return [out substringToIndex:p+2];
	}
	// The other cases: 10.03 and 10.33
	return out;
}


@end

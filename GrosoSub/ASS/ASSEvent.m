//
//  ASSEvent.m
//  GrosoSub
//
//  Created by Josu López Fernández on 14/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ASSEvent.h"


@implementation ASSEvent

@synthesize dialogue;
@synthesize layer;
@synthesize start;
@synthesize end;
@synthesize style;
@synthesize name;
@synthesize marginL;
@synthesize marginR;
@synthesize marginV;
@synthesize effect;
@synthesize text;

- (NSString *) description
{
	NSString *out = [[NSString alloc] init];
	
	if (dialogue == YES) {
		out = [out stringByAppendingString:@"Dialogue: "];
	} else {
		out = [out stringByAppendingString:@"Comment: "];
	}
	
	out = [out stringByAppendingFormat:@"%d,%@,%@,%@,%@,%.4d,%.4d,%.4d,%@,%@",
		   layer, start, end, style, name, marginL, marginR, marginV, effect, text];
		
	return out;
}

- (void) parseString:(NSString *)aString
{
	NSString *type, *st, *ed;
	NSScanner *scanner = [NSScanner scannerWithString:aString];
	[scanner scanUpToString:@":" intoString:&type];
	if ([type isEqualToString:@"Dialogue"]) {
		dialogue = YES;
	} else {
		dialogue = NO;
	}
	[scanner scanString:@": " intoString:NULL]; //skip ": "
	
	[scanner scanInteger:&layer];
	[scanner scanString:@"," intoString:NULL]; //skip comma
	
	[scanner scanUpToString:@"," intoString:&st];
	[start parseString:st];
	[scanner scanString:@"," intoString:NULL]; //skip comma
	
	[scanner scanUpToString:@"," intoString:&ed];
	[end parseString:ed];
	[scanner scanString:@"," intoString:NULL]; //skip comma
	
	[scanner scanUpToString:@"," intoString:&style];
	[scanner scanString:@"," intoString:NULL]; //skip comma
	
	[scanner scanUpToString:@"," intoString:&name];
	[scanner scanString:@"," intoString:NULL]; //skip comma
	
	[scanner scanInteger:&marginL];
	[scanner scanString:@"," intoString:NULL]; //skip comma
	
	[scanner scanInteger:&marginR];
	[scanner scanString:@"," intoString:NULL]; //skip comma
	
	[scanner scanInteger:&marginV];
	[scanner scanString:@"," intoString:NULL]; //skip comma
	
	[scanner scanUpToString:@"," intoString:&effect];
	[scanner scanString:@"," intoString:NULL]; //skip comma
	
	[scanner scanUpToString:@"\n" intoString:&text];
}

- (id) initWithString:(NSString *)aString
{
	if (self = [super init]) {
		start = [[ASSTime alloc] init];
		end = [[ASSTime alloc] init];
		effect = [[NSString alloc] init];
		text = [[NSString alloc] init];
		
		[self parseString:aString];
	}
	return self;
}

- (id) init
{
	[self initWithString:@"Dialogue: 0,0:00:00.00,0:00:00.00,Default,Default,0000,0000,0000,,"];
	return self;
}

@end

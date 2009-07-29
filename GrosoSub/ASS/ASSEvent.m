//
//  ASSEvent.m
//  GrosoSub
//
//  Created by Josu López Fernández on 14/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ASSEvent.h"
#import "ASSTime.h"

@implementation ASSEvent

@synthesize dialogue;
@synthesize layer;
@synthesize start;
@synthesize end;
@synthesize duration;
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

- (NSString *) descriptionSRT
{
	NSString *out = @"";
	if (dialogue == YES) {
		out = [out stringByAppendingFormat:@"%@ --> %@\n", [[self start] descriptionSRT], [[self end] descriptionSRT]];
		NSArray *lines = [[self text] componentsSeparatedByString:@"\\N"];
		for (NSString *line in lines) {
			line = [line stringByReplacingOccurrencesOfString:@"{\\i1}" withString:@"<i>"];
			line = [line stringByReplacingOccurrencesOfString:@"{\\i0}" withString:@"</i>"];
			
			out = [out stringByAppendingFormat:@"%@\n", line];
		}
		out = [out stringByAppendingString:@"\n"];
	}
	
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
	
	// Calculate duration (end - start)
	[duration setTime:([end time] - [start time])];
}

- (id) initWithString:(NSString *)aString
{
	if (self = [super init]) {
		start = [[ASSTime alloc] init];
		end = [[ASSTime alloc] init];
		duration = [[ASSTime alloc] init];
		effect = [[NSString alloc] init];
		text = [[NSString alloc] init];
		style = [[NSString alloc] init];
		name = [[NSString alloc] init];
		
		[self parseString:aString];
	}
	return self;
}

- (id) init
{
	[self initWithString:@"Dialogue: 0,0:00:00.00,0:00:00.00,Default,Default,0000,0000,0000,,"];
	return self;
}

- (void) joinWithEvent:(ASSEvent *)aEvent
{
	ASSTime *sStart = [self start];
	ASSTime *sEnd = [self end];
	ASSTime *aStart = [aEvent start];
	ASSTime *aEnd = [aEvent end];
	
	NSComparisonResult cStart = [sStart compare:aStart];
	NSComparisonResult cEnd = [sEnd compare:aEnd];
	
	if (cStart == NSOrderedDescending) { //aStart < sStart
		[self setStart:aStart];
	}
	if (cEnd == NSOrderedAscending) { //aEnd > sEnd
		[self setEnd:aEnd];
	}
	
	text = [text stringByAppendingFormat:@"\\N%@", [aEvent text]];
}

#pragma mark NSCopying protocol
- (id) copyWithZone:(NSZone *)zone
{
	ASSEvent *new = [[ASSEvent alloc] init];
	[new setDialogue:[self dialogue]];
	[new setLayer:[self layer]];
	[new setStart:[[self start] copy]];
	[new setEnd:[[self end] copy]];
	[new setDuration:[[self duration] copy]];
	[new setStyle:[self style]];
	[new setName:[self name]];
	[new setMarginL:[self marginL]];
	[new setMarginR:[self marginR]];
	[new setMarginV:[self marginV]];
	[new setEffect:[self effect]];
	[new setText:[self text]];
	return new;
}

@end
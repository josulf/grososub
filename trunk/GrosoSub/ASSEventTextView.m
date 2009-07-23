//
//  ASSEventTextView.m
//  GrosoSub
//
//  Created by Josu López Fernández on 21/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ASSEventTextView.h"


@implementation ASSEventTextView
- (void)setEnabled:(Boolean)flag
{
	NSRange area;
	area.location = 0;
	area.length = [[self string] length];
	if (flag == YES) {
		[self setEditable:YES];
		[self setSelectable:YES];
		[[self textStorage] addAttribute:NSForegroundColorAttributeName value:[NSColor blackColor] range:area];
	} else {
		[self setEditable:NO];
		[self setSelectable:NO];
		[[self textStorage] addAttribute:NSForegroundColorAttributeName value:[NSColor grayColor] range:area];
	}
}

- (NSString *)string
{
	NSString *out = [[self textStorage] string];
	return [out stringByReplacingOccurrencesOfString:@"\n" withString:@"\\N"];
	
}

@end

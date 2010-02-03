//
//  ASSSATextView.m
//  GrosoSub
//
//  Created by Josu López Fernández on 03/02/10.
//  Copyright 2010 Euskal Herriko Unibertsitatea. All rights reserved.
//

#import "ASSSATextView.h"


@implementation ASSSATextView
- (void)keyDown:(NSEvent *)theEvent
{
	if ([theEvent modifierFlags] & NSCommandKeyMask) {
		// Command key
		switch ([theEvent keyCode]) {
			case 123: // Left - Go to previous
				[[NSNotificationCenter defaultCenter] postNotificationName:@"ASSStylingAssistantPrevious" object:self];
				break;
			case 124: // Right - Go to next
				[[NSNotificationCenter defaultCenter] postNotificationName:@"ASSStylingAssistantNext" object:self];
				break;
			default:
				break;
		}
	} else {
		// Without modifiers
		switch ([theEvent keyCode]) {
			case 36: // Enter - Commit
				[[NSNotificationCenter defaultCenter] postNotificationName:@"ASSStylingAssistantCommit" object:self];
				break;
			default:
				//NSLog(@"%d, %d", [theEvent keyCode], [theEvent modifierFlags]);
				[super keyDown:theEvent];
				break;
		}
	}
}
@end

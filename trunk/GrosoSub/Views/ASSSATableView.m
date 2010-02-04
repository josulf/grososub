//
//  ASSSATableView.m
//  GrosoSub
//
//  Created by Josu López Fernández on 03/02/10.
//  Copyright (C) 2010 Josu López Fernández <fregona@fregona.biz>.
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

#import "ASSSATableView.h"

@implementation ASSSATableView
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

- (void)mouseDown:(NSEvent *)theEvent {
	[super mouseDown:theEvent];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ASSStylingAssistantCommit" object:self];
}

@end

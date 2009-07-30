//
//  ASSEventTextView.m
//  GrosoSub
//
//  Created by Josu López Fernández on 21/07/09.
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

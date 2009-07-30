//
//  ASSEventTableView.m
//  GrosoSub
//
//  Created by Josu López Fernández on 17/07/09.
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

#import "ASSEventTableView.h"

@implementation ASSEventTableView

- (NSMenu *)menuForEvent:(NSEvent *)theEvent
{
	if ([theEvent type] == NSRightMouseDown) {
		NSIndexSet *selectedRowsIndexes = [self selectedRowIndexes];
		
		NSPoint mousePoint = [self convertPoint:[theEvent locationInWindow] fromView:nil];
		int row = [self rowAtPoint:mousePoint];
		
		if (! [selectedRowsIndexes containsIndex:row]) {
			[self selectRow:row byExtendingSelection:NO];
		}
	}
	
	return [super menuForEvent:theEvent];
}

- (void)selectRow:(NSInteger)rowIndex byExtendingSelection:(BOOL)flag
{
	[super selectRow:rowIndex byExtendingSelection:flag];
	
	NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
	[nc postNotificationName:NSTableViewSelectionDidChangeNotification object:self];
}

@end

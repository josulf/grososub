//
//  ASSEventTableView.m
//  GrosoSub
//
//  Created by Josu López Fernández on 17/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
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

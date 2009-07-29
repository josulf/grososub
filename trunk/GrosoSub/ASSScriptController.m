//
//  ASSScriptController.m
//  GrosoSub
//
//  Created by Josu López Fernández on 28/07/09.
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

#import "ASSScriptController.h"
#import "ASSEventTableView.h"
#import "ASSEventTextView.h"
#import "ASS/ASSEventList.h"
#import "ASS/ASSStyleList.h"
#import "ASS/ASSTime.h"
#import "ASS/ASSEvent.h"
#import "ASSScript.h"

@implementation ASSScriptController

@synthesize eTable;

#pragma mark Actions
- (IBAction) commitEvent:(void *)sender
{
	ASSEvent *newEvent = [[ASSEvent alloc] init];
	[newEvent setDialogue:![commentB state]];
	[newEvent setLayer:[layerTF intValue]];
	ASSTime *s = [[ASSTime alloc] initWithString:[startTF stringValue]];
	[newEvent setStart:s];
	ASSTime *e = [[ASSTime alloc] initWithString:[endTF stringValue]];
	[newEvent setEnd:e];
	ASSTime *d = [[ASSTime alloc] init];
	[d setTime:[e time] - [s time]];
	[newEvent setDuration:d];
	[newEvent setStyle:[styleCB stringValue]];
	[newEvent setName:[actorCB stringValue]];
	[newEvent setMarginL:[lTF intValue]];
	[newEvent setMarginR:[rTF intValue]];
	[newEvent setMarginV:[vTF intValue]];
	[newEvent setEffect:[effectTF stringValue]];
	[newEvent setText:[textTV string]];
	NSLog([textTV string]);
	
	[[self document] replaceEventAtIndex:[eTable selectedRow] withEvent:newEvent];
}

- (IBAction)textActions:(void *)sender
{
	switch ([textSC selectedSegment]) {
		case 0:
			NSLog(@"B");
			break;
		case 1:
			NSLog(@"I");
			break;
		case 2:
			NSLog(@"U");
			break;
		case 3:
			NSLog(@"S");
			break;
		default:
			NSLog(@"LOL");
			break;
	}
}

#pragma mark Events Menu
- (IBAction)addEventBefore:(void *)sender
{
	[[self document] addDefaultEventAtIndex:[eTable selectedRow]];
}

- (IBAction)addEventAfter:(void *)sender
{
	[[self document] addDefaultEventAtIndex:[eTable selectedRow]+1];
}

- (IBAction)addEvent:(void *)sender
{
	[[self document] addDefaultEventAtIndex:0];
}

- (IBAction)removeEvent:(void *)sender
{
	[[self document] delEventAtIndex:[eTable selectedRow]];
}

- (IBAction)dupplicateEvent:(void *)sender
{
	[[self document] dupplicateEventAtIndex:[eTable selectedRow]];
}

- (IBAction)joinEvents:(void *)sender
{
	NSIndexSet *selected = [eTable selectedRowIndexes];
	[[self document] joinEventAtIndex:[selected firstIndex] withEventAtIndex:[selected lastIndex]];
}

- (BOOL)validateMenuItem:(NSMenuItem *)menuItem
{
	/*
	 * 0 - 9 Single event actions
	 * 10 - 20 Two continuous event actions
	 * ------------------------------
	 * 0: Add before
	 * 1: Add after
	 * 2: Remove
	 * 3: Dupplicate
	 * 4: Add to empty file
	 * ------------------------------
	 * 10: Join
	 */
	
	NSInteger t = [menuItem tag];
	NSInteger c = [[eTable selectedRowIndexes] count];
	NSInteger e = [[self document] countEvents];
	if (t == 4) {
		if (e == 0) {
			return YES;
		}
	} else if (t < 10) {
		if (c == 1) {
			return YES;
		}
	} else if (t < 20) {
		if (c == 2) {
			NSIndexSet *selected = [eTable selectedRowIndexes];
			if ([selected firstIndex]+1 == [selected lastIndex]) {
				return YES;
			}
		}
	}
	
	return NO;		
}

#pragma mark ASSEventTableView delegates
- (void)tableViewSelectionDidChange:(NSNotification *)aNotification
{
	if ([aNotification object] == eTable) { // if the event came from the event table
		NSInteger row = [eTable selectedRow];
		if ((row != -1) && ([[eTable selectedRowIndexes] count] == 1)) {
			// if there is only one selected line, display the event
			ASSEvent *event = [[self document] getEventAtIndex:[eTable selectedRow]];
			
			[commentB setEnabled:YES];
			[styleCB setEnabled:YES];
			[actorCB setEnabled:YES];
			[effectTF setEnabled:YES];
			[layerTF setEnabled:YES];
			[layerS setEnabled:YES];
			[startTF setEnabled:YES];
			[endTF setEnabled:YES];
			[durationTF setEnabled:YES];
			[durationTF setEnabled:YES];
			[lTF setEnabled:YES];
			[rTF setEnabled:YES];
			[vTF setEnabled:YES];
			[textTV setEnabled:YES];
			[commitB setEnabled:YES];
			[textSC setEnabled:YES];
			[colourSC setEnabled:YES];
			
			[commentB setState:![event dialogue]];
			
			[styleCB removeAllItems];
			for (NSString *style in [[self document] styleNames]) {
				[styleCB addItemWithObjectValue:style];
			}
			[styleCB selectItemWithObjectValue:[event style]];
			
			[actorCB removeAllItems];
			for (NSString *actor in [[self document] actorNames]) {
				[actorCB addItemWithObjectValue:actor];
			}
			[actorCB selectItemWithObjectValue:[event name]];
			
			[effectTF setStringValue:[event effect]];
			[layerTF setIntValue:[event layer]];
			[layerS setIntValue:[event layer]];
			[startTF setStringValue:[[event start] description]];
			[endTF setStringValue:[[event end] description]];
			[durationTF setStringValue:[[event duration] description]];
			[lTF setIntValue:[event marginL]];
			[rTF setIntValue:[event marginR]];
			[vTF setIntValue:[event marginV]];
			[textTV setString:[event text]];
		} else {
			[commentB setEnabled:NO];
			[styleCB setEnabled:NO];
			[actorCB setEnabled:NO];
			[effectTF setEnabled:NO];
			[layerTF setEnabled:NO];
			[layerS setEnabled:NO];
			[startTF setEnabled:NO];
			[endTF setEnabled:NO];
			[durationTF setEnabled:NO];
			[durationTF setEnabled:NO];
			[lTF setEnabled:NO];
			[rTF setEnabled:NO];
			[vTF setEnabled:NO];
			[textTV setEnabled:NO];
			[commitB setEnabled:NO];
			[textSC setEnabled:NO];
			[colourSC setEnabled:NO];
		}
	}
}

#pragma mark NSDataSource informal protocol
- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(int)rowIndex
{
	ASSEvent *e = [[self document] getEventAtIndex:rowIndex];
	NSString *ident = [aTableColumn identifier];
	
	if ([ident isEqualToString:@"number"]) {
		return [NSString stringWithFormat:@"%d", rowIndex+1];
	} else if ([ident isEqualToString:@"type"]) {
		if ([e dialogue] == YES) {
			return @"D";
		} else {
			return @"C";
		}
	} else if ([ident isEqualToString:@"layer"]) {
		return [NSString stringWithFormat:@"%d", [e layer]];
	} else if ([ident isEqualToString:@"start"]) {
		return [[e start] description];
	} else if ([ident isEqualToString:@"end"]) {
		return [[e end] description];
	} else if ([ident isEqualToString:@"style"]) {
		return [e style];
	} else if ([ident isEqualToString:@"name"]) {
		return [e name];
	} else if ([ident isEqualToString:@"marginL"]) {
		return [NSString stringWithFormat:@"%.4d", [e marginL]];
	} else if ([ident isEqualToString:@"marginR"]) {
		return [NSString stringWithFormat:@"%.4d", [e marginR]];
	} else if ([ident isEqualToString:@"marginV"]) {
		return [NSString stringWithFormat:@"%.4d", [e marginV]];
	} else if ([ident isEqualToString:@"effect"]) {
		return [e effect];
	} else if ([ident isEqualToString:@"text"]) {
		return [e text];
	}
	
	return @"WTF";	
}

- (int)numberOfRowsInTableView:(NSTableView *)aTableView
{
	return [[self document] countEvents];
}

#pragma mark NSWindowController
- (id)init
{
	self = [super initWithWindowNibName:@"ASSScript"];
	
	return self;
}

@end

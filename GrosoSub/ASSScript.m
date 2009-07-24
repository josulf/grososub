//
//  MyDocument.m
//  GrosoSub
//
//  Created by Josu López Fernández on 19/11/08.
//  Copyright (C) 2008 Josu López Fernández <fregona@fregona.biz>.
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

#import "ASSScript.h"

@implementation ASSScript

@synthesize name;
@synthesize headers;
@synthesize styles;
@synthesize events;

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
	
	[self replaceEventAtIndex:[eTable selectedRow] withEvent:newEvent];

	NSLog([newEvent description]);
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
	[self addDefaultEventAtIndex:[eTable selectedRow]];
}

- (IBAction)addEventAfter:(void *)sender
{
	[self addDefaultEventAtIndex:[eTable selectedRow]+1];
}

- (IBAction)addEvent:(void *)sender
{
	[self addDefaultEventAtIndex:0];
}

- (IBAction)removeEvent:(void *)sender
{
	[self delEventAtIndex:[eTable selectedRow]];
}

- (IBAction)dupplicateEvent:(void *)sender
{
	[self dupplicateEventAtIndex:[eTable selectedRow]];
}

- (IBAction)joinEvents:(void *)sender
{
	NSIndexSet *selected = [eTable selectedRowIndexes];
	[self joinEventAtIndex:[selected firstIndex] withEventAtIndex:[selected lastIndex]];
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
	NSInteger e = [events countEvents];
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

#pragma mark Controller
- (void)addDefaultEventAtIndex:(NSUInteger)aIndex
{
	NSUndoManager *undo = [self undoManager];
	[[undo prepareWithInvocationTarget:self] delEventAtIndex:aIndex];
	if (![undo isUndoing]) {
		[undo setActionName:@"Add Event"];
		[self updateChangeCount:NSChangeDone];
	} else {
		[self updateChangeCount:NSChangeUndone];
	}
	
	[events addDefaultEventAtIndex:aIndex];
	
	[eTable reloadData];
	[eTable selectRow:aIndex byExtendingSelection:NO];
}

- (void)delEventAtIndex:(NSUInteger)aIndex
{
	ASSEvent *rem = [events getEventAtIndex:aIndex];
	NSUndoManager *undo = [self undoManager];
	[[undo prepareWithInvocationTarget:self] addEvent:rem atIndex:aIndex];
	if (![undo isUndoing]) {
		[undo setActionName:@"Delete Event"];
		[self updateChangeCount:NSChangeDone];
	} else {
		[self updateChangeCount:NSChangeUndone];
	}
	
	[events delEventAtIndex:aIndex];
	
	[eTable reloadData];
	[eTable selectRow:aIndex byExtendingSelection:NO];
}

- (void)addEvent:(ASSEvent *)aEvent atIndex:(NSUInteger)aIndex
{
	NSUndoManager *undo = [self undoManager];
	[[undo prepareWithInvocationTarget:self] delEventAtIndex:aIndex];
	if (![undo isUndoing]) {
		[undo setActionName:@"Add Event"];
		[self updateChangeCount:NSChangeDone];
	} else {
		[self updateChangeCount:NSChangeUndone];
	}
	
	[events addEvent:aEvent atIndex:aIndex];
	
	[eTable reloadData];
	[eTable selectRow:aIndex byExtendingSelection:NO];
}

- (void)dupplicateEventAtIndex:(NSUInteger)aIndex
{
	NSUndoManager *undo = [self undoManager];
	[[undo prepareWithInvocationTarget:self] delEventAtIndex:aIndex+1];
	if (![undo isUndoing]) {
		[undo setActionName:@"Dupplicate Event"];
		[self updateChangeCount:NSChangeDone];
	}
	
	[events dupplicateEventAtIndex:aIndex];
	
	[eTable reloadData];
}

- (void)joinEventAtIndex:(NSUInteger)aIndex withEventAtIndex:(NSUInteger)bIndex
{
	NSUndoManager *undo = [self undoManager];
	ASSEvent *a = [[events getEventAtIndex:aIndex] copy];
	ASSEvent *b = [[events getEventAtIndex:bIndex] copy];
	NSLog(@"%@ - %@", a, b);

	[[undo prepareWithInvocationTarget:self] splitEventAtIndex:aIndex withEvent:a and:b];
	if (![undo isUndoing]) {
		[undo setActionName:@"Join Events"];
		[self updateChangeCount:NSChangeDone];
	} else {
		[self updateChangeCount:NSChangeUndone];
	}
	
	[events joinEventAtIndex:aIndex withEventAtIndex:bIndex];
	[events delEventAtIndex:bIndex];
	
	[eTable reloadData];
	[eTable deselectRow:bIndex];
}

- (void)splitEventAtIndex:(NSUInteger)aIndex withEvent:(ASSEvent *)aEvent and:(ASSEvent *)bEvent
{
	NSUndoManager *undo = [self undoManager];
	[[undo prepareWithInvocationTarget:self] joinEventAtIndex:aIndex withEventAtIndex:aIndex+1];
	if (![undo isUndoing]) {
		[undo setActionName:@"Split Events"];
		[self updateChangeCount:NSChangeDone];
	} else {
		[self updateChangeCount:NSChangeUndone];
	}
	
	[events delEventAtIndex:aIndex];
	[events addEvent:aEvent atIndex:aIndex];
	[events addEvent:bEvent atIndex:aIndex+1];
	
	[eTable reloadData];
	[eTable selectRow:aIndex byExtendingSelection:NO];
	[eTable selectRow:aIndex+1 byExtendingSelection:YES];
}

- (void)replaceEventAtIndex:(NSUInteger)aIndex withEvent:(ASSEvent *)aEvent
{
	ASSEvent *oldEvent = [events getEventAtIndex:aIndex];
	NSUndoManager *undo = [self undoManager];
	[[undo prepareWithInvocationTarget:self] replaceEventAtIndex:aIndex withEvent:[oldEvent copy]];
	if (![undo isUndoing]) {
		[undo setActionName:@"Commit Event"];
		[self updateChangeCount:NSChangeDone];
	} else {
		[self updateChangeCount:NSChangeUndone];
	}
	
	[events changeEventFromString:[aEvent description] atIndex:aIndex];
	
	[eTable reloadData];
	[eTable selectRow:aIndex byExtendingSelection:NO];
}

#pragma mark ASSEventTableView delegates
- (void)tableViewSelectionDidChange:(NSNotification *)aNotification
{
	if ([aNotification object] == eTable) { // if the event came from the event table
		NSInteger row = [eTable selectedRow];
		if ((row != -1) && ([[eTable selectedRowIndexes] count] == 1)) {
			// if there is only one selected line, display the event
			ASSEvent *event = [events getEventAtIndex:[eTable selectedRow]];
			
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
			for (NSString *style in [styles styleNames]) {
				[styleCB addItemWithObjectValue:style];
			}
			[styleCB selectItemWithObjectValue:[event style]];
			
			[actorCB removeAllItems];
			for (NSString *actor in [events actorNames]) {
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

#pragma mark Syntax Highlighting
- (void)highlight:(NSNotification *)aNotification
{
	NSTextStorage *storage = [aNotification object];
	
	if (storage == [textTV textStorage]) {
		NSString *string = [[aNotification object] string];
		NSRange area;
		area.location = 0;
		area.length = [string length];
		
		[storage removeAttribute:NSForegroundColorAttributeName range:area];
		
		[storage setFont:[NSFont fontWithName:@"Lucida Grande" size:13]];
	}
}

#pragma mark Perry
- (id)init
{
    self = [super init];
    if (self) {
		headers = [[ASSHeader alloc] init];
		styles = [[ASSStyleList alloc] init];
		events = [[ASSEventList alloc] init];
	}
	
	// Syntax highlighting
	//[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(highlight:) name:NSTextStorageDidProcessEditingNotification object:nil];
    return self;
}

#pragma mark NSDataSource informal protocol
- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(int)rowIndex
{
	ASSEvent *e = [events getEventAtIndex:rowIndex];
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
	return [events countEvents];
}

#pragma mark NSDocument

- (NSString *)windowNibName
{
    // Override returning the nib file name of the document
    // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
    return @"ASSScript";
}

- (void)windowControllerDidLoadNib:(NSWindowController *) aController
{
    [super windowControllerDidLoadNib:aController];
    // Add any code here that needs to be executed once the windowController has loaded the document's window.
}

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError
{
	NSString *megaString = @"";
	
	if ([typeName isEqualToString:@"Advanced SubStation Alpha"]) {
		// HEADERS
		megaString = [megaString stringByAppendingFormat:@"[Script Info]\n; Script generated by %@\n", @"GrosoSub v0.0"];
		megaString = [megaString stringByAppendingString:[headers description]];
		// STYLES
		megaString = [megaString stringByAppendingString:@"\n[V4+ Styles]\nFormat: Name, Fontname, Fontsize, PrimaryColour, SecondaryColour, OutlineColour, BackColour, Bold, Italic, Underline, StrikeOut, ScaleX, ScaleY, Spacing, Angle, BorderStyle, Outline, Shadow, Alignment, MarginL, MarginR, MarginV, Encoding\n"];
		megaString = [megaString stringByAppendingString:[styles description]];
		// EVENTS
		megaString = [megaString stringByAppendingString:@"\n[Events]\nFormat: Layer, Start, End, Style, Name, MarginL, MarginR, MarginV, Effect, Text\n"];
		megaString = [megaString stringByAppendingString:[events description]];
	} else if ([typeName isEqualToString:@"SubRip"]) {
		int i = 1;
		
		for (ASSEvent *event in events) {
			megaString = [megaString stringByAppendingFormat:@"%d\n%@", i, [event descriptionSRT]];
			i++;
		}
	
	} else if ([typeName isEqualToString:@"MicroDVD"]) {
		megaString = @"TODO";
	}
	
	return [megaString dataUsingEncoding:NSUTF8StringEncoding];
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError
{
	NSString *megaString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	NSLog(typeName);
	
	if ([typeName isEqualToString:@"Advanced SubStation Alpha"]) {
		NSString *hString, *sString, *eString;
		
		NSScanner *scanner = [NSScanner scannerWithString:megaString];
		// We should delete the data of the new script
		[headers clean];
		[styles clean];
		[events clean];
		
		[scanner scanString:@"[Script Info]" intoString:NULL];
		
		// We need to know if the lines are comments (;)
		Boolean comments = NO;
		while (!comments) {
			NSUInteger l = [scanner scanLocation];
			NSString *line;
			[scanner scanUpToString:@"\n" intoString:&line];
			if ([line characterAtIndex:0] != ';') { //not comment
				comments = YES;
				[scanner setScanLocation:l]; //go back on the scanner
			}
		}
		
		// HEADER
		[scanner scanUpToString:@"[V4+ Styles]" intoString:&hString];
		[headers parseString:hString];
		
		// Skip unuseful lines (2)
		[scanner scanUpToString:@"\n" intoString:NULL];
		[scanner scanUpToString:@"\n" intoString:NULL];
		[scanner scanUpToString:@"Style:" intoString:NULL];
		
		// STYLES
		[scanner scanUpToString:@"[Events]" intoString:&sString];
		[styles parseString:sString];
		
		// Skip unuseful lines (2)
		[scanner scanUpToString:@"\n" intoString:NULL];
		[scanner scanUpToString:@"\n" intoString:NULL];
		eString = [megaString substringFromIndex:[scanner scanLocation]];
		[events parseString:eString];
	} else if ([typeName isEqualToString:@"SubRip"]) {
		/*
		 0: 1
		 1: 00:00:20,000 --> 00:00:24,400
		 2: In connection with a dramatic increase
		 3: in crime in certain neighbourhoods,
		 4: 
		 */
		// We should delete the data of the new script
		[headers clean];
		[styles clean];
		[events clean];
		
		// We add the default style
		[styles addStyleFromString:@"Style: Default,Arial,20,&H00FFFFFF,&H0000FFFF,&H00000000,&H00000000,0,0,0,0,100.00,100.00,0.00,0.00,1,2.00,2.00,2,10,10,10,0"];
		
		NSArray *lines = [megaString componentsSeparatedByString:@"\n"];
			
		int i = 0;
		ASSTime *start, *end, *duration;
		NSArray *times;
		NSString *text = @"";
		
		for (NSString *line in lines) {
			line = [line stringByReplacingOccurrencesOfString:@"\r" withString:@""];
			line = [line stringByReplacingOccurrencesOfString:@"<i>" withString:@"{\\i1}"];
			line = [line stringByReplacingOccurrencesOfString:@"</i>" withString:@"{\\i0}"];
			
			if (i == 1) { //start and end times
				times = [line componentsSeparatedByString:@" --> "];
				start = [[ASSTime alloc] initWithString:[[times objectAtIndex:0] stringByReplacingOccurrencesOfString:@"," withString:@"."]];
				end = [[ASSTime alloc] initWithString:[[times objectAtIndex:1] stringByReplacingOccurrencesOfString:@"," withString:@"."]];
				duration = [[ASSTime alloc] init];
				[duration setTime:([end time] - [start time])];
			} else if (i == 2) {
				text = [line copy];
			} else if (i > 2 && ![line isEqualToString:@""]) { //text lines
				text = [text stringByAppendingFormat:@"\\N%@", line];
			} else if ([line isEqualToString:@""]) { //empty line
				ASSEvent *newEvent = [[ASSEvent alloc] init];
				[newEvent setText:text];
				[newEvent setStart:start];
				[newEvent setEnd:end];
				[newEvent setDuration:duration];
				
				NSLog([newEvent descriptionSRT]);
				[events addEvent:newEvent];
			}
			
			if ([line isEqualToString:@""]) {
				i = 0;
				text = @"";
			} else {
				i++;
			}
		}
	}
	
	// Now we reload the data of the table
	[eTable reloadData];
	
	return YES;
}

@end


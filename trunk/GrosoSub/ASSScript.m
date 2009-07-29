//
//  ASSScript.m
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
#import "ASS/ASSEvent.h"
#import "ASS/ASSTime.h"
#import "ASS/ASSHeader.h"
#import "ASS/ASSStyleList.h"
#import "ASS/ASSEventList.h"
#import "ASSEventTableView.h"
#import "ASSScriptController.h"
#import "ASSStylesController.h"
#import "ASSHeadersController.h"

@implementation ASSScript

@synthesize name;
@synthesize headers;
@synthesize styles;
@synthesize events;

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
	
	[[scC eTable] reloadData];
	[[scC eTable] selectRow:aIndex byExtendingSelection:NO];
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
	
	[[scC eTable] reloadData];
	[[scC eTable] selectRow:aIndex byExtendingSelection:NO];
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
	
	[[scC eTable] reloadData];
	[[scC eTable] selectRow:aIndex byExtendingSelection:NO];
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
	
	[[scC eTable] reloadData];
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
	
	[[scC eTable] reloadData];
	[[scC eTable] deselectRow:bIndex];
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
	
	[[scC eTable] reloadData];
	[[scC eTable] selectRow:aIndex byExtendingSelection:NO];
	[[scC eTable] selectRow:aIndex+1 byExtendingSelection:YES];
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
	
	[[scC eTable] reloadData];
	[[scC eTable] selectRow:aIndex byExtendingSelection:NO];
}

- (ASSEvent *)getEventAtIndex:(NSUInteger)aIndex
{
	return [events getEventAtIndex:aIndex];
}

- (NSString *)getHeader:(NSString *)key
{
	NSString *out = [headers getValueForKey:key];
	if (out == nil) {
		return @"";
	} else {
		return out;
	}
}

- (void)setValue:(NSString *)value forHeader:(NSString *)key
{
	if (![value isEqualToString:@""]) {
		NSUndoManager *undo = [self undoManager];
		if ([[headers order] containsObject:key]) {
			//the key is already, we replace the value
			NSString *oldValue = [headers getValueForKey:key];
			
			[[undo prepareWithInvocationTarget:self] setValue:oldValue forHeader:key];
			if (![undo isUndoing]) {
				[undo setActionName:@"Set Header"];
				[self updateChangeCount:NSChangeDone];
			} else {
				[self updateChangeCount:NSChangeUndone];
			}
		} else {
			// it is a new key-value pair
			[[undo prepareWithInvocationTarget:self] delKey:key];
			if (![undo isUndoing]) {
				[undo setActionName:@"Add Header"];
				[self updateChangeCount:NSChangeDone];
			} else {
				[self updateChangeCount:NSChangeUndone];
			}
		}
		
		[headers setValue:value forKey:key];
		
		NSLog(@"%d", [undo groupingLevel]);
		[[heC headersTV] reloadData];
		[heC awakeFromNib];
	}
}

- (void)delKey:(NSString *)key
{
	NSUndoManager *undo = [self undoManager];
	
	NSString *oldValue = [headers getValueForKey:key];
	[[undo prepareWithInvocationTarget:self] setValue:oldValue forHeader:key];
	if (![undo isUndoing]) {
		[undo setActionName:@"Delete Header"];
		[self updateChangeCount:NSChangeDone];
	} else {
		[self updateChangeCount:NSChangeUndone];
	}
	
	[headers delKey:key];
	
	[[heC headersTV] reloadData];
	[heC awakeFromNib];
}

- (NSUInteger)countEvents
{
	return [events countEvents];
}

- (NSUInteger)countHeaders
{
	return [headers count];
}

- (NSMutableArray *)actorNames
{
	return [events actorNames];
}

- (NSMutableArray *)styleNames
{
	return [styles styleNames];
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
	
    return self;
}

- (IBAction)showStylesManager:(void *)sender
{
	stC = [[ASSStylesController alloc] init];
	[self addWindowController:stC];
	[stC showWindow:nil];
}

- (IBAction)showHeadersManager:(void *)sender
{
	heC = [[ASSHeadersController alloc] init];
	[self addWindowController:heC];
	[heC showWindow:nil];
}

#pragma mark NSDocument
- (void)makeWindowControllers
{
	scC = [[ASSScriptController alloc] init];
	[self addWindowController:scC];
	//stC = [[ASSStylesController alloc] init];
	//[self addWindowController:stC];
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
	} else if ([typeName isEqualToString:@"Text File"]) {
		NSArray *lines = [megaString componentsSeparatedByString:@"\n"];
		NSRange actor;
		ASSEvent *newEvent = [[ASSEvent alloc] init];
		
		[headers clean];
		[styles clean];
		[events clean];
		
		[styles addStyleFromString:@"Style: Default,Arial,20,&H00FFFFFF,&H0000FFFF,&H00000000,&H00000000,0,0,0,0,100.00,100.00,0.00,0.00,1,2.00,2.00,2,10,10,10,0"];
		
		for (NSString *line in lines) {
			line = [line stringByReplacingOccurrencesOfString:@"\r" withString:@""];
			actor = [line rangeOfString:@":"];
			
			if (actor.location == NSNotFound) {
				[newEvent setText:line];
			} else {
				[newEvent setName:[line substringToIndex:actor.location]];
				if ([line characterAtIndex:(actor.location+1)] == ' ') {
					[newEvent setText:[line substringFromIndex:actor.location+2]];
				} else {
					[newEvent setText:[line substringFromIndex:actor.location+1]];
				}
			}
		
			[events addEvent:newEvent];
		}
	}
	
	// Now we reload the data of the table
	[[scC eTable] reloadData];
	
	return YES;
}

@end


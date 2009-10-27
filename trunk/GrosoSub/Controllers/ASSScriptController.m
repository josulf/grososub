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
#import "ASSEventList.h"
#import "ASSStyleList.h"
#import "ASSTime.h"
#import "ASSEvent.h"
#import "ASSScript.h"
#import "ASSRange.h"
#import "NSString+Reverse.h"

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
	
	[[self document] replaceEventAtIndex:[eTable selectedRow] withEvent:newEvent];
}

- (IBAction)textActions:(void *)sender
{
	NSArray *ranges = [textTV selectedRanges];
	NSString *open, *openB, *close, *closeB;
	Boolean ok = NO;
	
	switch ([textSC selectedSegment]) {
		case 0:
			open = @"\\b1";
			openB = @"{\\b1}";
			close = @"\\b0";
			closeB = @"{\\b0}";
			ok = YES;
			break;
		case 1:
			open = @"\\i1";
			openB = @"{\\i1}";
			close = @"\\i0";
			closeB = @"{\\i0}";
			ok = YES;
			break;
		case 2:
			open = @"\\u1";
			openB = @"{\\u1}";
			close = @"\\u0";
			closeB = @"{\\u0}";
			ok = YES;
			break;
		case 3:
			open = @"\\s1";
			openB = @"{\\s1}";
			close = @"\\s0";
			closeB = @"{\\s0}";
			ok = YES;
			break;
		default:
			NSLog(@"LOL");
			break;
	}
	
	if (ok) {	
		NSMutableString *newString = [[textTV string] mutableCopy];
		NSInteger a, b;
		
		for (NSValue *value in [ranges reverseObjectEnumerator]) {
			NSRange range = [value rangeValue];
			
			if (!(([ranges count] == 1) && (range.length == 0))) {
				// only continue if there is something selected on the text view
				b = range.location+range.length;
				a = range.location-1;
				if ((b<[newString length]) && ([newString characterAtIndex:b] == '{')) {
					NSRange commandR;
					commandR.location = b;
					NSScanner *after = [NSScanner scannerWithString:[newString substringFromIndex:b]];
					
					if ([after scanUpToString:@"}" intoString:NULL]) {
						commandR.length = [after scanLocation] - commandR.location + b+1;
						NSString *command = [newString substringWithRange:commandR];
						NSRange found = [command rangeOfString:close];
						if (found.location != NSNotFound) {
							// we have \b0 inside the brackets
							if ([command length] == 5) {
								// we only have \b0
								newString = [[newString stringByReplacingOccurrencesOfString:closeB withString:@"" options:NSLiteralSearch range:commandR] mutableCopy];
							} else {
								newString = [[newString stringByReplacingOccurrencesOfString:close withString:@"" options:NSLiteralSearch range:commandR] mutableCopy];
							}
						} else {
							// we don't have \b0
							[newString insertString:close atIndex:b+1];
						}
					}
				} else {
					// we are at the end or we don't have a command after
					[newString insertString:closeB atIndex:b];
				}
				
				if ((a >= 0) && ([newString characterAtIndex:a] == '}')) {
					NSScanner *r = [NSScanner scannerWithString:[[newString copy] reverseString]];
					[r setScanLocation:[newString length] - a - 1];
					NSRange revCommandR;
					revCommandR.location = [newString length] - a - 1;
					if ([r scanUpToString:@"{" intoString:NULL]) {
						revCommandR.length = [r scanLocation] - revCommandR.location + 1;
						NSRange commandR = NSMakeRange([newString length] - revCommandR.location - revCommandR.length, revCommandR.length);
						NSString *command = [newString substringWithRange:commandR];
						NSRange found = [command rangeOfString:open];
						if (found.location != NSNotFound) {
							// we have \b1 inside the brackets
							if ([command length] == 5) {
								// we only have \b1
								newString = [[newString stringByReplacingOccurrencesOfString:openB withString:@"" options:NSLiteralSearch range:commandR] mutableCopy];
							} else {
								newString = [[newString stringByReplacingOccurrencesOfString:open withString:@"" options:NSLiteralSearch range:commandR] mutableCopy];
							}
						} else {
							// we don't have \b1
							[newString insertString:open atIndex:a];
						}
					}
					
				} else {
					// we are at the begin or we don't have a command before
					[newString insertString:openB atIndex:a+1];
				}
			}
		}
		
	[textTV setString:newString];
	}
}

#pragma mark Events Menu
- (IBAction)addEventBefore:(void *)sender
{
	if ([eTable selectedRow] == -1) {
		[[self document] addDefaultEventAtIndex:0];
	} else {
		[[self document] addDefaultEventAtIndex:[eTable selectedRow]];
	}
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
	 * ------------------------------
	 * 10: Join
	 */
	
	NSInteger t = [menuItem tag];
	NSInteger c = [[eTable selectedRowIndexes] count];
	NSInteger e = [[self document] countEvents];
		
	switch (t) {
		case 0:
		case 1:
			if ((c == 1) || (e == 0)) return YES;
			break;
		case 2:
		case 3:
			if (c == 1) return YES;
			break;
		case 10:
			if (c == 2) {
				NSIndexSet *selected = [eTable selectedRowIndexes];
				if ([selected firstIndex]+1 == [selected lastIndex]) {
					return YES;
				}
			}
			break;
		default:
			return NO;
			break;
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
		NSMutableString *outText = [[e text] mutableCopy];
		NSScanner *outScanner = [NSScanner scannerWithString:outText];
		NSMutableArray *ranges = [[NSMutableArray alloc] init];
		
		while (![outScanner isAtEnd]) {
			NSRange range;
			[outScanner scanUpToString:@"{" intoString:NULL];
			if (![outScanner isAtEnd]) {
				range.location = [outScanner scanLocation];
				[outScanner scanUpToString:@"}" intoString:NULL];
				if (![outScanner isAtEnd]) {
					range.length = [outScanner scanLocation] + 1 - range.location;
					NSValue *r = [NSValue valueWithRange:range];
					[ranges addObject:r];
				}
			}
		}
		for (NSValue *r in [ranges reverseObjectEnumerator]) {
			[outText replaceCharactersInRange:[r rangeValue] withString:@"⌘"];
		}
		
		return outText;
	}
	
	return @"WTF";	
}

- (int)numberOfRowsInTableView:(NSTableView *)aTableView
{
	return [[self document] countEvents];
}

#pragma mark Notifications
- (void)tableUpdated:(NSNotification *)aNotification
{
	NSUInteger i;
	ASSRange *p = [[aNotification userInfo] objectForKey:@"range"];
	NSRange r = [p range];	

	[eTable reloadData];

	if (r.length != 0) {
		[eTable selectRowIndexes:[NSIndexSet indexSetWithIndex:r.location] byExtendingSelection:NO];

		for (i = 2; i <= r.length; i++) {
			[eTable selectRowIndexes:[NSIndexSet indexSetWithIndex:r.location+i-1] byExtendingSelection:YES];
		}
	}
}

#pragma mark Syntax Highlighting
- (void)highlight:(NSNotification *)aNotification
{
	NSTextStorage *st = [aNotification object];
	NSString *string = [st string];
	NSRange area, area2, area3, area4;
	area.location = 0;
	area.length = [string length];
	NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"\\}"];
	NSCharacterSet *set2 = [NSCharacterSet characterSetWithCharactersInString:@"1234567890,()"];
	NSCharacterSet *set3 = [NSCharacterSet characterSetWithCharactersInString:@",)"];
	
	[st removeAttribute:NSForegroundColorAttributeName range:area];
	
	//FIXME: if we set the font for all the text we can't see japanese or arabic characters.
	//[st setFont:[NSFont fontWithName:@"Lucida Grande" size:13]];
	
	NSScanner *sc = [NSScanner scannerWithString:string];
	while (![sc isAtEnd]) {
		area.location = 0;
		area.length = 0;
		[sc scanUpToString:@"{" intoString:NULL];
		if (![sc isAtEnd]) {
			area.location = [sc scanLocation];
			[sc scanUpToString:@"}" intoString:NULL];
			if (![sc isAtEnd]) {
				// we are inside a {} section
				area.length = [sc scanLocation] - area.location + 1;
				NSScanner *perry = [NSScanner scannerWithString:[[sc string] substringWithRange:area]];
				NSRange perryR = area;
				[perry scanUpToString:@"\\" intoString:NULL];
				if (![perry isAtEnd]) {
					// there is 1 or more ASS commands
					[st addAttribute:NSForegroundColorAttributeName value:[NSColor blueColor] range:area];
					while (![perry isAtEnd]) {
						[perry scanString:@"\\" intoString:NULL];
						area2.location = [perry scanLocation];
						if ([perry scanUpToCharactersFromSet:set intoString:NULL] && ![perry isAtEnd]) {
							// we have an ASS command
							area2.length = [perry scanLocation] - area2.location;
							NSRange comR = [[sc string] rangeOfString:[[perry string] substringWithRange:area2] options:NSLiteralSearch range:perryR];
							NSRange slaR = NSMakeRange(comR.location-1, 1);
							[st addAttribute:NSForegroundColorAttributeName value:[NSColor darkGrayColor] range:comR];
							[st addAttribute:NSFontAttributeName value:[NSFont fontWithName:@"Lucida Grande Bold" size:13] range:comR];
							if ((NSInteger) (slaR.location) >= 0) {
								[st addAttribute:NSForegroundColorAttributeName value:[NSColor purpleColor] range:slaR];
							}
							NSScanner *patxi = [NSScanner scannerWithString:[[perry string] substringWithRange:area2]];
							NSRange patxiR = [[sc string] rangeOfString:[patxi string] options:NSLiteralSearch range:perryR];
							[patxi scanUpToString:@"(" intoString:NULL];
							if (![patxi isAtEnd]) {
								// the command has parameters inside brackets
								area3.location = [patxi scanLocation];
								[patxi scanUpToString:@")" intoString:NULL];
								if (![patxi isAtEnd]) {
									area3.length = [patxi scanLocation] - area3.location +1;
									NSRange parR = [[sc string] rangeOfString:[[patxi string] substringWithRange:area3] options:NSLiteralSearch range:patxiR];
									[st addAttribute:NSForegroundColorAttributeName value:[NSColor purpleColor] range:parR];
									NSScanner *joxerra = [NSScanner scannerWithString:[[sc string] substringWithRange:parR]];
									NSRange joxerraR = [[sc string] rangeOfString:[joxerra string] options:NSLiteralSearch range:patxiR];
									while (![joxerra isAtEnd]) {
										[joxerra scanUpToCharactersFromSet:[NSCharacterSet decimalDigitCharacterSet] intoString:NULL];
										area4.location = [joxerra scanLocation];
										[joxerra scanUpToCharactersFromSet:set3 intoString:NULL];
										if (![joxerra isAtEnd]) {
											area4.length = [joxerra scanLocation] - area4.location;
											NSRange paramR = [[sc string] rangeOfString:[[joxerra string] substringWithRange:area4] options:NSLiteralSearch range:joxerraR];
											[st addAttribute:NSForegroundColorAttributeName value:[NSColor orangeColor] range:paramR];
										}
									}
								}
							} else {
								// the command hasn't got parameters inside brackets
								[patxi setScanLocation:0];
								[patxi scanUpToCharactersFromSet:set2 intoString:NULL];
								if ([[patxi string] length] > 1) {
									area3.location = [patxi scanLocation];
									area3.length = [[patxi string] length] - area3.location;
									NSRange parR = [[sc string] rangeOfString:[[patxi string] substringWithRange:area3] options:NSLiteralSearch range:patxiR];
									[st addAttribute:NSForegroundColorAttributeName value:[NSColor orangeColor] range:parR];
								}
							}
						}
						[perry setScanLocation:[perry scanLocation]+1];
					}
				} else {
					// it is a comment
					[st addAttribute:NSForegroundColorAttributeName value:[NSColor grayColor] range:area];
				}
			}
		}
	}
}

#pragma mark NSWindowController
- (void)awakeFromNib
{
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(highlight:) name:NSTextStorageDidProcessEditingNotification object:[textTV textStorage]];
}

- (id)init
{
	self = [super initWithWindowNibName:@"ASSScript"];	
	return self;
}


- (void)setDocument:(NSDocument *)document
{
	[super setDocument:document];
	// This method is called when NSDocument calls makeWindowController and after the window is closed
	// to set the value of "document" to nil.
	// When we call makeWindowControllers we add the observer, and when we close the window (document == nil)
	// we remove the observer
	if (document != nil) {
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tableUpdated:) name:@"ASSEventsUpdated" object:document];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(commitEvent:) name:@"ASSEventsEnter" object:textTV];
	} else {
		[[NSNotificationCenter defaultCenter] removeObserver:self];
	}
}


@end

//
//  ASSHeadersController.m
//  GrosoSub
//
//  Created by Josu López Fernández on 29/07/09.
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

#import "ASSHeadersController.h"
#import "ASSScript.h"
#import "ASS/ASSHeader.h"


@implementation ASSHeadersController

@synthesize headersTV;

- (void)awakeFromNib
{
	ASSScript *script = [self document];
	[titleTF setStringValue:[script getHeader:@"Title"]];
	[scriptTF setStringValue:[script getHeader:@"Original Script"]];
	[typeTF setStringValue:[script getHeader:@"ScriptType"]];
	[translationTF setStringValue:[script getHeader:@"Original Translation"]];
	[editingTF setStringValue:[script getHeader:@"Original Editing"]];
	[timingTF setStringValue:[script getHeader:@"Original Timing"]];
	[checkingTF setStringValue:[script getHeader:@"Original Script Checking"]];
	[playResXTF setStringValue:[script getHeader:@"PlayResX"]];
	[playResYTF setStringValue:[script getHeader:@"PlayResY"]];
	[playDepthTF setStringValue:[script getHeader:@"PlayDepth"]];

	NSString *col = [script getHeader:@"Collisions"];
	if ([col isEqualToString:@"Normal"]) {
		[collisionsCB selectItemAtIndex:0];
	} else if ([col isEqualToString:@"Reverse"]) {
		[collisionsCB selectItemAtIndex:1];
	} else {
		[collisionsCB deselectItemAtIndex:[collisionsCB indexOfSelectedItem]];
	}
	
	if ([script getHeader:@"WrapStyle"] != @"") {
		[wrapCB selectItemAtIndex:[[script getHeader:@"WrapStyle"] intValue]];
	} else {
		[wrapCB deselectItemAtIndex:[wrapCB indexOfSelectedItem]];
	}
}

#pragma mark Actions
- (IBAction)applyChanges:(void *)sender
{
	ASSScript *script = [self document];
	
	NSString *title = [titleTF stringValue];
	NSString *scriptN = [scriptTF stringValue];
	NSString *type = [typeTF stringValue];
	NSString *translation = [translationTF stringValue];
	NSString *editing = [editingTF stringValue];
	NSString *timing = [timingTF stringValue];
	NSString *checking = [checkingTF stringValue];
	NSString *playResX = [playResXTF stringValue];
	NSString *playResY = [playResYTF stringValue];
	NSString *playDepth = [playDepthTF stringValue];
	NSUInteger collisionsS = [collisionsCB indexOfSelectedItem];
	NSString *collisions = [collisionsCB stringValue];
	NSUInteger wrap = [wrapCB indexOfSelectedItem];
	
	[script setValue:title forHeader:@"Title"];
	[script setValue:scriptN forHeader:@"Original Script"];
	[script setValue:type forHeader:@"ScriptType"];
	[script setValue:translation forHeader:@"Original Translation"];
	[script setValue:editing forHeader:@"Original Editing"];
	[script setValue:timing forHeader:@"Original Timing"];
	[script setValue:checking forHeader:@"Original Script Checking"];
	[script setValue:playResX forHeader:@"PlayResX"];
	[script setValue:playResY forHeader:@"PlayResY"];
	[script setValue:playDepth forHeader:@"PlayDepth"];
	if (collisionsS != -1) {
		[script setValue:collisions forHeader:@"Collisions"];
	}
	if (wrap != -1) {
		NSString *value = [NSString stringWithFormat:@"%d", wrap];
		[script setValue:value forHeader:@"WrapStyle"];
	}
}

- (IBAction)addHeader:(void *)sender
{
	[[self document] setValue:@"New Value" forHeader:@"New Key"];
}

- (IBAction)delHeader:(void *)sender
{
	NSUInteger selected = [headersTV selectedRow];
	if (selected != -1) {
		[[self document] delKey:[[[[self document] headers] order] objectAtIndex:selected]];
	}
}

#pragma mark NSTableDataSource informal protocol
- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(int)rowIndex
{
	ASSHeader *headers = [[self document] headers];
	
	if ([[aTableColumn identifier] isEqualToString:@"Key"]) {
		return [[headers order] objectAtIndex:rowIndex];
	} else if ([[aTableColumn identifier] isEqualToString:@"Value"]) {
		return [headers getValueForKey:[[headers order] objectAtIndex:rowIndex]];
	} else {
		return @"WTF";
	}
}

- (int)numberOfRowsInTableView:(NSTableView *)aTableView
{
	return [[self document] countHeaders];
}

- (void)tableView:(NSTableView *)aTableView setObjectValue:(id)anObject forTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex
{
	ASSScript *script = [self document];
	
	if ([[aTableColumn identifier] isEqualToString:@"Key"]) {
		// first we get the value for the key that has been modified
		NSString *value = [script getHeader:[[[script headers] order] objectAtIndex:rowIndex]];
		NSLog(value);
		
		// second we delete the old key-value pair
		[script delKey:[[[script headers] order] objectAtIndex:rowIndex]];
		
		// now we add the new pair
		[script setValue:value forHeader:[anObject description]];
	} else if ([[aTableColumn identifier] isEqualToString:@"Value"]) {
		[script setValue:anObject forHeader:[[[script headers] order] objectAtIndex:rowIndex]];
	}
	
	[self awakeFromNib];
	[headersTV reloadData];
}

#pragma mark NSWindowController
- (id)init
{
	self = [super initWithWindowNibName:@"ASSHeaders"];
	
	return self;
}

- (NSString *)windowTitleForDocumentDisplayName:(NSString *)displayName
{
	return [displayName stringByAppendingString:@" - Headers"];
}

- (void)windowWillClose:(NSNotification *)notification
{
	NSLog(@"Hello");
	[[self document] setHeC:nil];
}
@end

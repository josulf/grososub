//
//  ASSHeadersController.m
//  GrosoSub
//
//  Created by Josu López Fernández on 29/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ASSHeadersController.h"
#import "ASSScript.h"
#import "ASS/ASSHeader.h"


@implementation ASSHeadersController
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
	
	[script setValue:[titleTF stringValue] forHeader:@"Title"];
	[script setValue:[scriptTF stringValue] forHeader:@"Original Script"];
	[script setValue:[typeTF stringValue] forHeader:@"ScriptType"];
	[script setValue:[translationTF stringValue] forHeader:@"Original Translation"];
	[script setValue:[editingTF stringValue] forHeader:@"Original Editing"];
	[script setValue:[timingTF stringValue] forHeader:@"Original Timing"];
	[script setValue:[checkingTF stringValue] forHeader:@"Original Script Checking"];
	[script setValue:[playResXTF stringValue] forHeader:@"PlayResX"];
	[script setValue:[playResYTF stringValue] forHeader:@"PlayResY"];
	[script setValue:[playDepthTF stringValue] forHeader:@"PlayDepth"];
	if ([collisionsCB indexOfSelectedItem] != -1) {
		[script setValue:[collisionsCB stringValue] forHeader:@"Collisions"];
	}
	if ([wrapCB indexOfSelectedItem] != -1) {
		NSString *value = [NSString stringWithFormat:@"%d", [wrapCB indexOfSelectedItem]];
		[script setValue:value forHeader:@"WrapStyle"];
	}
	
	[headersTV reloadData];
}

- (IBAction)addHeader:(void *)sender
{
	[[[self document] headers] setValue:@"New Value" forKey:@"New Key"];
	[headersTV reloadData];
	[self awakeFromNib];
}
- (IBAction)delHeader:(void *)sender
{
	NSUInteger selected = [headersTV selectedRow];
	if (selected != -1) {
		[[[self document] headers] delKey:[[[[self document] headers] order] objectAtIndex:selected]];
		[headersTV reloadData];
		[self awakeFromNib];
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
	ASSHeader *headers = [[self document] headers];
	
	if ([[aTableColumn identifier] isEqualToString:@"Key"]) {
		// first we get the value for the key that has been modified
		NSString *value = [headers getValueForKey:[[headers order] objectAtIndex:rowIndex]];
		NSLog(value);
		
		// second we delete the old key-value pair
		[headers delKey:[[headers order] objectAtIndex:rowIndex]];
		
		// now we add the new pair
		[headers setValue:value forKey:[anObject description]];
	} else if ([[aTableColumn identifier] isEqualToString:@"Value"]) {
		[headers setValue:anObject forKey:[[headers order] objectAtIndex:rowIndex]];
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
@end

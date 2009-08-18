//
//  ASSStylesController.m
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

#import "ASSStylesController.h"
#import "ASSStyleList.h"
#import "ASSScript.h"

@implementation ASSStylesController

#pragma mark NSTableView delegates
- (void)tableViewSelectionDidChange:(NSNotification *)aNotification
{
	if ([aNotification object] == scriptTV) {
		//Script table view
		NSInteger row = [scriptTV selectedRow];
		if ((row != -1) && ([[scriptTV selectedRowIndexes] count] == 1)) {
			// Only if one row is selected
			ASSStyle *style = [[self document] getStyleAtIndex:row];
			NSLog([style description]);

		}
	} else if ([aNotification object] == storageTV) {
		// Storage table view
		// TODO: Implement the storage of styles
	}
}

#pragma mark NSTableDataSource informal protocol
- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView
{
	if (aTableView == scriptTV) {
		// Script table view
		ASSScript *perry = [self document];
		
		return [perry countStyles];
	} else if (aTableView == storageTV) {
		// Storage table view
		// TODO: Implement the storage of styles
		return 0;
	} else {
		return 0;
	}
}

- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex
{
	if (aTableView == scriptTV) {
		// Script table view
		ASSScript *perry = [self document];
		NSArray *styleNames = [perry styleNames];
		return [styleNames objectAtIndex:rowIndex];
	} else if (aTableView == storageTV) {
		// Storage table view
		// TODO: Implement the storage of styles
		return 0;
	} else {
		return 0;
	}
}

#pragma mark Actions
- (IBAction)apply:(id)sender {
    
}

- (IBAction)deleteStorage:(id)sender {
    
}

- (IBAction)newStorage:(id)sender {
    
}

- (IBAction)scriptActions:(id)sender {
    
}

- (IBAction)selectFont:(id)sender {
    
}

- (IBAction)storageActions:(id)sender {
    
}
#pragma mark Notifications
- (void)stylesUpdated:(NSNotification *)aNotification
{
	//[scriptTV reloadData];
	//[self awakeFromNib];
}

#pragma mark NSWindowController
- (id)init
{
	self = [super initWithWindowNibName:@"ASSStyles"];
	
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
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stylesUpdated:) name:@"ASSStylesUpdated" object:document];
	} else {
		[[NSNotificationCenter defaultCenter] removeObserver:self];
	}
}

- (NSString *)windowTitleForDocumentDisplayName:(NSString *)displayName
{
	return [displayName stringByAppendingString:@" - Styles Manager"];
}
@end

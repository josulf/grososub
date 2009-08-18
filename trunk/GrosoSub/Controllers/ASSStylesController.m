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
#import "ASSStyle.h"
#import "ASSColour.h"

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
			
			// Enable the controlls
			[nameTF setEnabled:YES];
			[fontTF setEnabled:YES];
			[fontSizeTF setEnabled:YES];
			[boldB setEnabled:YES];
			[italicB setEnabled:YES];
			[underlineB setEnabled:YES];
			[strikeoutB setEnabled:YES];
			[primaryCCW setEnabled:YES];
			[secondaryCCW setEnabled:YES];
			[outlineCCW setEnabled:YES];
			[backCCW setEnabled:YES];
			[primaryCTF setEnabled:YES];
			[secondaryCTF setEnabled:YES];
			[outlineCTF setEnabled:YES];
			[backCTF setEnabled:YES];
			[primaryCS setEnabled:YES];
			[secondaryCS setEnabled:YES];
			[outlineCS setEnabled:YES];
			[backCS setEnabled:YES];
			[alignmentM setEnabled:YES];
			[leftTF setEnabled:YES];
			[rightTF setEnabled:YES];
			[vertTF setEnabled:YES];
			[leftS setEnabled:YES];
			[rightS setEnabled:YES];
			[vertS setEnabled:YES];
			[outlineTF setEnabled:YES];
			[shadowTF setEnabled:YES];
			[opaqueB setEnabled:YES];
			[rotationTF setEnabled:YES];
			[spacingTF setEnabled:YES];
			[xTF setEnabled:YES];
			[yTF setEnabled:YES];
			[rotationS setEnabled:YES];
			[spacingS setEnabled:YES];
			[xS setEnabled:YES];
			[yS setEnabled:YES];
			[encodingTF setEnabled:YES];
			[applyB setEnabled:YES];
			[selectB setEnabled:YES];
			
			// load the data
			[nameTF setObjectValue:[style name]];
			[fontTF setObjectValue:[style fontName]];
			[fontSizeTF setObjectValue:[NSNumber numberWithInt:[style fontSize]]];
			[boldB setState:[style bold]];
			[italicB setState:[style italic]];
			[underlineB setState:[style underline]];
			[strikeoutB setState:[style strikeOut]];
			[primaryCCW setColor:[style primaryNSColor]];
			[secondaryCCW setColor:[style secondaryNSColor]];
			[outlineCCW setColor:[style outlineNSColor]];
			[backCCW setColor:[style backNSColor]];
			
			// First we set the object value for the text fields
			// The sliders are linked with the text fields and vice versa to get it's int value
			// We are setting the value of the text field programatically, then we need to advise
			// the slider to get the value
			[primaryCTF setObjectValue:[NSNumber numberWithUnsignedInt:[[style primaryColour] alpha]]];
			[primaryCS takeIntValueFrom:primaryCTF];
			[secondaryCTF setObjectValue:[NSNumber numberWithUnsignedInt:[[style secondaryColour] alpha]]];
			[secondaryCS takeIntValueFrom:secondaryCTF];
			[outlineCTF setObjectValue:[NSNumber numberWithUnsignedInt:[[style outlineColour] alpha]]];
			[outlineCS takeIntValueFrom:outlineCTF];
			[backCTF setObjectValue:[NSNumber numberWithUnsignedInt:[[style backColour] alpha]]];
			[backCS takeIntValueFrom:backCTF];
			
			[alignmentM selectCellWithTag:[style alignment]];
			
			[leftTF setObjectValue:[NSNumber numberWithInt:[style marginL]]];
			[leftS takeIntValueFrom:leftTF];
			[rightTF setObjectValue:[NSNumber numberWithInt:[style marginR]]];
			[rightS takeIntValueFrom:rightTF];
			[vertTF setObjectValue:[NSNumber numberWithInt:[style marginV]]];
			[vertS takeIntValueFrom:vertTF];
			
			[outlineTF setObjectValue:[NSNumber numberWithFloat:[style outline]]];
			[shadowTF setObjectValue:[NSNumber numberWithFloat:[style shadow]]];
			[opaqueB setState:[style borderStyle]];
			
			[rotationTF setObjectValue:[NSNumber numberWithFloat:[style angle]]];
			[rotationS takeFloatValueFrom:rotationTF];
			[spacingTF setObjectValue:[NSNumber numberWithFloat:[style spacing]]];
			[spacingS takeFloatValueFrom:spacingTF];
			[xTF setObjectValue:[NSNumber numberWithFloat:[style scaleX]]];
			[xS takeFloatValueFrom:xTF];
			[yTF setObjectValue:[NSNumber numberWithFloat:[style scaleY]]];
			[yS takeFloatValueFrom:yTF];
			[encodingTF setObjectValue:[NSNumber numberWithInt:[style encoding]]];
		} else {
			// disable the controlls
			[nameTF setEnabled:NO];
			[fontTF setEnabled:NO];
			[fontSizeTF setEnabled:NO];
			[boldB setEnabled:NO];
			[italicB setEnabled:NO];
			[underlineB setEnabled:NO];
			[strikeoutB setEnabled:NO];
			[primaryCCW setEnabled:NO];
			[secondaryCCW setEnabled:NO];
			[outlineCCW setEnabled:NO];
			[backCCW setEnabled:NO];
			[primaryCTF setEnabled:NO];
			[secondaryCTF setEnabled:NO];
			[outlineCTF setEnabled:NO];
			[backCTF setEnabled:NO];
			[primaryCS setEnabled:NO];
			[secondaryCS setEnabled:NO];
			[outlineCS setEnabled:NO];
			[backCS setEnabled:NO];
			[alignmentM setEnabled:NO];
			[leftTF setEnabled:NO];
			[rightTF setEnabled:NO];
			[vertTF setEnabled:NO];
			[leftS setEnabled:NO];
			[rightS setEnabled:NO];
			[vertS setEnabled:NO];
			[outlineTF setEnabled:NO];
			[shadowTF setEnabled:NO];
			[opaqueB setEnabled:NO];
			[rotationTF setEnabled:NO];
			[spacingTF setEnabled:NO];
			[xTF setEnabled:NO];
			[yTF setEnabled:NO];
			[rotationS setEnabled:NO];
			[spacingS setEnabled:NO];
			[xS setEnabled:NO];
			[yS setEnabled:NO];
			[encodingTF setEnabled:NO];
			[applyB setEnabled:NO];
			[selectB setEnabled:NO];
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

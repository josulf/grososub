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

@synthesize storage;

#pragma mark NSTableView delegates
- (void) enableAndLoadScript: (ASSStyle *) style
{			
	// Enable the controlls
	[nameTF setEnabled:YES];
	[fontCB setEnabled:YES];
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
	
	// load the data
	[nameTF setObjectValue:[style name]];
	[fontCB setObjectValue:[style fontName]];
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

}

- (void) disableControls {
			// disable the controlls
			[nameTF setEnabled:NO];
			[fontCB setEnabled:NO];
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

}

- (void)tableViewSelectionDidChange:(NSNotification *)aNotification
{
	if ([aNotification object] == scriptTV) {
		//Script table view
		NSInteger row = [scriptTV selectedRow];
		if ((row != -1) && ([[scriptTV selectedRowIndexes] count] == 1)) {
			ASSStyle *style = [[self document] getStyleAtIndex:row];
			[modeSC setSelected:YES forSegment:1];
			[self enableAndLoadScript:style];
		} else {
			[self disableControls];
		}
		// Always unselect what is selected in the other tableview
		[storageTV deselectAll:nil];
		[scriptTV selectRowIndexes:[NSIndexSet indexSetWithIndex:row] byExtendingSelection:NO];
	} else if ([aNotification object] == storageTV) {
		// Storage table view
		NSInteger row = [storageTV selectedRow];
		if ((row != -1) && ([[storageTV selectedRowIndexes] count] == 1)) {
			ASSStyle *style = [storage getStyleAtIndex:row];
			[modeSC setSelected:YES forSegment:0];
			[self enableAndLoadScript:style];
		} else {
			[self disableControls];
		}
		[scriptTV deselectAll:nil];
		[storageTV selectRowIndexes:[NSIndexSet indexSetWithIndex:row] byExtendingSelection:NO];
		//////////////////// MEGAHACK
		//[saveB setEnabled:YES]; 
	}
}

#pragma mark NSComboBox delegates
- (void)comboBoxSelectionDidChange:(NSNotification *)aNotification
{
	if ([aNotification object] == storageCB) {
		[loadB setEnabled:YES];
		[saveB setEnabled:NO];
		[delB setEnabled:YES];
		[newB setEnabled:NO];
		[storageTV setEnabled:NO];
		[storageSC setEnabled:NO];
	}
}
- (void)controlTextDidBeginEditing:(NSNotification *)aNotification
{
	if ([aNotification object] == storageCB) {
		[loadB setEnabled:NO];
		[saveB setEnabled:NO];
		[delB setEnabled:NO];
		[newB setEnabled:NO];
		[storageTV setEnabled:NO];
		[storageSC setEnabled:NO];
	}
}

- (void)controlTextDidEndEditing:(NSNotification *)aNotification
{
	if ([aNotification object] == storageCB) {
		if (([storageCB indexOfSelectedItem] == -1) && ![[storageCB stringValue] isEqualToString:@""]) {
			[newB setEnabled:YES];
			[loadB setEnabled:NO];
			[saveB setEnabled:NO];
			[delB setEnabled:NO];
		} else if ([storageCB indexOfSelectedItem] != -1) {
			[newB setEnabled:NO];
			[loadB setEnabled:YES];
			[delB setEnabled:YES];
		}
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
		return [storage countStyles];
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
		NSArray *styleNames = [storage styleNames];
		return [styleNames objectAtIndex:rowIndex];
	} else {
		NSLog(@"buh");
		return 0;
	}
}

#pragma mark Actions
- (IBAction)apply:(id)sender {
    ASSStyle *style = [[ASSStyle alloc] init];
	
	[style setName:[nameTF stringValue]];
	[style setFontName:[fontCB stringValue]];
	[style setFontSize:[fontSizeTF intValue]];
	
	[style setBold:[boldB state]];
	[style setItalic:[italicB state]];
	[style setUnderline:[underlineB state]];
	[style setStrikeOut:[strikeoutB state]];
	
	ASSColour *p = [[ASSColour alloc] initWithColor:[primaryCCW color]];
	[p setAlpha:[primaryCTF intValue]];
	[style setPrimaryColour:p];
	ASSColour *s = [[ASSColour alloc] initWithColor:[secondaryCCW color]];
	[s setAlpha:[secondaryCTF intValue]];
	[style setSecondaryColour:s];
	ASSColour *o = [[ASSColour alloc] initWithColor:[outlineCCW color]];
	[o setAlpha:[outlineCTF intValue]];
	[style setOutlineColour:o];
	ASSColour *b = [[ASSColour alloc] initWithColor:[backCCW color]];
	[b setAlpha:[backCTF intValue]];
	[style setBackColour:b];
	
	[style setAlignment:[alignmentM selectedTag]];
	
	[style setMarginL:[leftTF intValue]];
	[style setMarginR:[rightTF intValue]];
	[style setMarginV:[vertTF intValue]];
	
	[style setOutline:[outlineTF floatValue]];
	[style setShadow:[shadowTF floatValue]];
	[style setBorderStyle:[opaqueB state]];
	
	[style setAngle:[rotationTF floatValue]];
	[style setSpacing:[spacingTF floatValue]];
	[style setScaleX:[xTF floatValue]];
	[style setScaleY:[yTF floatValue]];
	[style setEncoding:[encodingTF intValue]];
	if ([modeSC selectedSegment] == 1) {
		[[self document] replaceStyleAtIndex:[scriptTV selectedRow] withStyle:style];
	} else if ([modeSC selectedSegment] == 0) {
		[storage changeStyleFromString:[style description] atIndex:[storageTV selectedRow]];
		[storageTV reloadData];
	}
}

- (IBAction)deleteStorage:(id)sender
{
    if (([storageCB indexOfSelectedItem] != -1) && ![[storageCB stringValue] isEqualToString:@""]) {
		NSFileManager *fileManager = [NSFileManager defaultManager];
		NSString *folder = @"~/Library/Application Support/GrosoSub/Styles/";
		folder = [folder stringByAppendingString:[storageCB stringValue]];
		folder = [folder stringByExpandingTildeInPath];
		
		Boolean a = [fileManager removeItemAtPath:folder error:NULL];
		
		[self loadStorageCB];
		
		[newB setEnabled:YES];
		[loadB setEnabled:NO];
		[delB setEnabled:NO];
		[storageTV setEnabled:NO];
		[storageSC setEnabled:NO];		
	}
}

- (IBAction)newStorage:(id)sender
{
	if (([storageCB indexOfSelectedItem] == -1) && ![[storageCB stringValue] isEqualToString:@""]) {
		NSFileManager *fileManager = [NSFileManager defaultManager];
		NSString *folder = @"~/Library/Application Support/GrosoSub/Styles/";
		folder = [folder stringByAppendingString:[storageCB stringValue]];
		folder = [folder stringByExpandingTildeInPath];
		
		[fileManager createFileAtPath:folder contents:[NSData data] attributes:nil];
		
		[storage clean];
		[storageTV reloadData];
		
		[self loadStorageCB];
		
		[newB setEnabled:NO];
		[loadB setEnabled:YES];
		[delB setEnabled:YES];
		[saveB setEnabled:YES];
		[storageTV setEnabled:YES];
		[storageSC setEnabled:YES];
	}
}

- (IBAction)loadStorage:(id)sender
{
	// Get the data of the file (utf8) and put into a string
	NSString *path = @"~/Library/Application Support/GrosoSub/Styles/";
	path = [path stringByAppendingString:[storageCB stringValue]];
	path = [path stringByExpandingTildeInPath];
	
	NSData *data = [NSData dataWithContentsOfFile:path];
	
	NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	
	// Delete the content of storage
	[storage clean];
	// Add the styles from the string
	[storage parseString:string];
	
	// Load the data into the table
	[storageTV reloadData];
	
	// Set buttons state
	[newB setEnabled:NO];
	[loadB setEnabled:YES];
	[delB setEnabled:YES];
	[saveB setEnabled:YES];
	[storageTV setEnabled:YES];
	[storageSC setEnabled:YES];
}

- (IBAction)saveStorage:(id)sender
{
	NSData *data = [[storage description] dataUsingEncoding:NSUTF8StringEncoding];
	
	NSString *path = @"~/Library/Application Support/GrosoSub/Styles/";
	path = [path stringByAppendingString:[storageCB stringValue]];
	path = [path stringByExpandingTildeInPath];
	
	[data writeToFile:path atomically:YES];
}

- (IBAction)scriptActions:(id)sender {
	NSInteger row = [scriptTV selectedRow];
	
    switch ([scriptSC selectedSegment]) {
		case 0: // Copy to storage
			if (row != -1) {
				ASSStyle *aStyle = [[self document] getStyleAtIndex:row];
				ASSStyle *newStyle = [[ASSStyle alloc] initWithString:[aStyle description]];
				
				NSString *styleName = [newStyle name];
				NSString *newName = [newStyle name];
				NSInteger copy = 1;
				
				while ([storage indexOfStyle:newName] != NSNotFound) {
					newName = [NSString stringWithFormat:@"%@ (%d)", styleName, copy++];
				}
				
				[newStyle setName:newName];
				
				[storage addStyleFromString:[newStyle description]];
				[storageTV reloadData];
				[storageTV selectRowIndexes:[NSIndexSet indexSetWithIndex:[storage indexOfStyleName:[newStyle name]]] byExtendingSelection:NO];
			}
			break;
		case 1: // New
			NSLog(@"b");
			NSInteger a = [[self document] createStyle];
			[scriptTV selectRowIndexes:[NSIndexSet indexSetWithIndex:a] byExtendingSelection:NO];
			break;
		case 2: // Dupplicate
			if (row != -1) {
				NSInteger a = [[self document] dupplicateStyleAtIndex:row];
				[scriptTV selectRowIndexes:[NSIndexSet indexSetWithIndex:a] byExtendingSelection:NO];
			}
			break;
		case 3: // Delete
			if (row != -1) {
				[[self document] deleteStyleAtIndex:row];
			}
			break;
	}
}

- (IBAction)storageActions:(id)sender {
    NSInteger row = [storageTV selectedRow];
	
    switch ([storageSC selectedSegment]) {
		case 0: // New
			NSLog(@"bb");
			NSString *newName = @"New Style";
			NSString *styleName = @"New Style";
			NSInteger copy = 1;
			
			while ([storage indexOfStyle:styleName] != NSNotFound) {
				styleName = [NSString stringWithFormat:@"%@ (%d)", newName, copy++];
			}
			
			[storage addStyleWithName:styleName];
			
			[storageTV reloadData];
			
			[storageTV selectRowIndexes:[NSIndexSet indexSetWithIndex:[storage indexOfStyleName:styleName]] byExtendingSelection:NO];
			
			break;
		case 1: // Dupplicate
			if (row != -1) {
				ASSStyle *origStyle = [storage getStyleAtIndex:row];
				ASSStyle *newStyle = [[ASSStyle alloc] initWithString:[origStyle description]];
				
				NSString *styleName = [newStyle name];
				
				while ([storage indexOfStyle:styleName] != NSNotFound) {
					styleName = [NSString stringWithFormat:@"%@ %@", @"Copy of", styleName];
				}
				
				[newStyle setName:styleName];
				[storage addStyleFromString:[newStyle description]];
				
				[storageTV reloadData];
				
				[storageTV selectRowIndexes:[NSIndexSet indexSetWithIndex:[storage indexOfStyleName:styleName]] byExtendingSelection:NO];
			}
			
			break;
		case 2: // Delete
			if (row != -1) {
				[storage delStyleAtIndex:row];
				
				[storageTV reloadData];
				
				[storageTV deselectAll:self];
				if (row <= [storage countStyles] - 1) {
					[storageTV selectRowIndexes:[NSIndexSet indexSetWithIndex:row] byExtendingSelection:NO];
				} else {
					[storageTV selectRowIndexes:[NSIndexSet indexSetWithIndex:[storage countStyles]-1] byExtendingSelection:NO];
				}
			}
			break;
		case 3: // Copy to script
			if (row != -1) {
				// Get the style from the storage
				ASSStyle *st = [storage getStyleAtIndex:row];
				NSInteger r = [[self document] addStyle:st];
				[scriptTV selectRowIndexes:[NSIndexSet indexSetWithIndex:r] byExtendingSelection:NO];
			}
			break;
	}
}

- (IBAction)closeSheet:(id)sender
{
	[NSApp endSheet:[self window]];
	[[self window] orderOut:self];
	[self close];
}

#pragma mark Notifications
- (void)stylesUpdated:(NSNotification *)aNotification
{
	[scriptTV reloadData];
	if ([scriptTV selectedRow] != -1) {
		ASSStyle *style = [[self document] getStyleAtIndex:[scriptTV selectedRow]];
		[self enableAndLoadScript:style];
	}
}

#pragma mark NSWindowController
- (id)init
{
	self = [super initWithWindowNibName:@"ASSStyles"];
	storage = [[ASSStyleList alloc] init];
	[storage clean];
	return self;
}

- (void)awakeFromNib
{
	// Load system fonts into the combo box
	NSArray *fonts = [[NSFontManager sharedFontManager] availableFontFamilies];
	[fontCB addItemsWithObjectValues:fonts];
	
	[self loadStorageCB];
}

- (void)loadStorageCB
{
	// Load the style storages
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSString *folder = @"~/Library/Application Support/GrosoSub/Styles/";
	folder = [folder stringByExpandingTildeInPath];
	
	if ([fileManager fileExistsAtPath:folder] == NO) {
		[fileManager createDirectoryAtPath:folder withIntermediateDirectories:YES attributes:nil error:NULL];
	}
	
	NSArray *files = [fileManager contentsOfDirectoryAtPath:folder error:NULL];
	
	[storageCB removeAllItems];
	for (NSString *file in files) {
		if ([file characterAtIndex:0] != '.') {
			[storageCB addItemWithObjectValue:file];
		}
	}
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

//
//  ASSStylesController.h
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

#import <Cocoa/Cocoa.h>

@interface ASSStylesController : NSWindowController {
	IBOutlet NSSegmentedControl *scriptSC, *storageSC;
	
	IBOutlet NSComboBox *storageCB, *fontCB;
	IBOutlet NSTableView *storageTV, *scriptTV;
	IBOutlet NSTextField *nameTF, *fontSizeTF;
	IBOutlet NSButton *boldB, *italicB, *underlineB, *strikeoutB;
	
	IBOutlet NSColorWell *primaryCCW, *secondaryCCW, *outlineCCW, *backCCW;
	IBOutlet NSTextField *primaryCTF, *secondaryCTF, *outlineCTF, *backCTF;
	IBOutlet NSSlider *primaryCS, *secondaryCS, *outlineCS, *backCS;
	
	IBOutlet NSMatrix *alignmentM;
	IBOutlet NSTextField *leftTF, *rightTF, *vertTF;
	IBOutlet NSStepper *leftS, *rightS, *vertS;
	IBOutlet NSTextField *outlineTF, *shadowTF;
	IBOutlet NSButton *opaqueB;
	
	IBOutlet NSTextField *rotationTF, *spacingTF, *xTF, *yTF, *encodingTF;
	IBOutlet NSStepper *rotationS, *spacingS, *xS, *yS;
	
	IBOutlet NSButton *applyB;
	
	IBOutlet NSButton *loadB, *saveB, *newB, *delB;
}
- (void)loadStorageCB;

- (IBAction)apply:(id)sender;
- (IBAction)deleteStorage:(id)sender;
- (IBAction)newStorage:(id)sender;
- (IBAction)loadStorage:(id)sender;
- (IBAction)saveStorage:(id)sender;
- (IBAction)scriptActions:(id)sender;
- (IBAction)storageActions:(id)sender;
- (IBAction)closeSheet:(id)sender;
@end

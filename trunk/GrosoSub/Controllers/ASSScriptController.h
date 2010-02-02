//
//  ASSScriptController.h
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

#import <Cocoa/Cocoa.h>
@class ASSEventTableView;
@class ASSEventTextView;
@class ASSTranslationTextView;

@interface ASSScriptController : NSWindowController {
	IBOutlet ASSEventTableView *eTable;
	IBOutlet NSButton *commentB;
	IBOutlet NSComboBox *styleCB, *actorCB;
	IBOutlet NSTextField *effectTF, *layerTF, *startTF, *endTF, *durationTF, *lTF, *rTF, *vTF;
	IBOutlet NSStepper *layerS;
	IBOutlet NSButton *commitB;
	IBOutlet NSSegmentedControl *textSC;
	IBOutlet ASSEventTextView *textTV;
	
	//Sheets
	IBOutlet NSWindow *translationW, *stylerW, *shiftW;
	
	//Shift Times
	IBOutlet NSTextField *hoursTF, *minutesTF, *secondsTF, *hundrethsTF;
	IBOutlet NSMatrix *directionM, *rowsM, *timesM;

	//Translation
	IBOutlet NSTextView *originalTV;
	IBOutlet ASSTranslationTextView *translationTV;
	IBOutlet NSTextField *currentTF;
	NSUInteger currentEvent, finalEvent;
}

@property (retain) ASSEventTableView *eTable;
@property (retain) NSWindow *translationW;
@property (retain) NSWindow *stylerW;
@property (retain) NSWindow *shiftW;

#pragma mark Actions
- (IBAction)commitEvent:(void *)sender;
- (IBAction)textActions:(void *)sender;

#pragma mark Events Menu
- (IBAction)addEventBefore:(void *)sender;
- (IBAction)addEventAfter:(void *)sender;
- (IBAction)addEvent:(void *)sender;
- (IBAction)removeEvent:(void *)sender;
- (IBAction)dupplicateEvent:(void *)sender;
- (IBAction)joinEvents:(void *)sender;

- (IBAction)closeTranslationAssistant:(id)sender;
- (IBAction)closeStylingAssistant:(id)sender;
- (IBAction)closeShiftTimes:(id)sender;

- (IBAction)shiftTimes:(id)sender;

- (void)startTranslation;
@end

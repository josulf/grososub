//
//  ASSScriptController.h
//  GrosoSub
//
//  Created by Josu López Fernández on 28/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class ASSEventTableView;
@class ASSEventTextView;

@interface ASSScriptController : NSWindowController {
	IBOutlet ASSEventTableView *eTable;
	IBOutlet NSButton *commentB;
	IBOutlet NSComboBox *styleCB, *actorCB;
	IBOutlet NSTextField *effectTF, *layerTF, *startTF, *endTF, *durationTF, *lTF, *rTF, *vTF;
	IBOutlet NSStepper *layerS;
	IBOutlet NSButton *commitB;
	IBOutlet NSSegmentedControl *textSC, *colourSC;
	IBOutlet ASSEventTextView *textTV;
}

@property (retain) ASSEventTableView *eTable;

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

@end

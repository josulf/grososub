//
//  ASSHeadersController.h
//  GrosoSub
//
//  Created by Josu López Fernández on 29/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ASSHeadersController : NSWindowController {
	IBOutlet NSTextField *titleTF, *scriptTF, *typeTF, *translationTF, *editingTF, *timingTF, *checkingTF, *playResXTF, *playResYTF, *playDepthTF;
	IBOutlet NSComboBox *collisionsCB, *wrapCB;
	
	IBOutlet NSTableView *headersTV;
}

- (void)awakeFromNib;

- (IBAction)applyChanges:(void *)sender;
- (IBAction)addHeader:(void *)sender;
- (IBAction)delHeader:(void *)sender;

@end

//
//  ASSHeadersController.h
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

@interface ASSHeadersController : NSWindowController {
	IBOutlet NSTextField *titleTF, *scriptTF, *typeTF, *translationTF, *editingTF, *timingTF, *checkingTF, *playResXTF, *playResYTF, *playDepthTF;
	IBOutlet NSComboBox *collisionsCB, *wrapCB;
	
	IBOutlet NSTableView *headersTV;
}

@property (retain) NSTableView *headersTV;

- (void)awakeFromNib;

- (IBAction)applyChanges:(void *)sender;
- (IBAction)addHeader:(void *)sender;
- (IBAction)delHeader:(void *)sender;

- (IBAction)closeSheet:(void *)sender;

@end

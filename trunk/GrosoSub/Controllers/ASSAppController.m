//
//  ASSAppController.m
//  GrosoSub
//
//  Created by Josu López Fernández on 04/02/10.
//  Copyright (C) 2010 Josu López Fernández <fregona@fregona.biz>.
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

#import "ASSAppController.h"
#import "ASSPreferenceController.h"

@implementation ASSAppController
- (BOOL)applicationShouldOpenUntitledFile:(NSApplication *)sender
{
	return [[NSUserDefaults standardUserDefaults] boolForKey:ASSEmptyDocKey];
}

- (IBAction)showPreferencePanel:(id)sender
{
	if (!preferenceController) {
		preferenceController = [[ASSPreferenceController alloc] init];
	}
	[preferenceController showWindow:self];
}

+ (void)initialize
{
	// Register factory defaults
	NSMutableDictionary *defaultValues = [NSMutableDictionary dictionary];
	
	[defaultValues setObject:[NSNumber numberWithBool:YES] forKey:ASSEmptyDocKey];
	[defaultValues setObject:[NSNumber numberWithBool:YES] forKey:ASSReplaceASSKey];
	[defaultValues setObject:[NSString stringWithString:@"⌘"] forKey:ASSReplaceStringKey];
	[defaultValues setObject:[NSNumber numberWithInt:1] forKey:ASSAutosaveDelayKey];
	[defaultValues setObject:[NSNumber numberWithBool:YES] forKey:ASSAutosaveKey];
	
	[[NSUserDefaults standardUserDefaults] registerDefaults:defaultValues];
	
	NSInteger minutes = [[NSUserDefaults standardUserDefaults] integerForKey:ASSAutosaveDelayKey];
	
	[[NSDocumentController sharedDocumentController] setAutosavingDelay:minutes*60.0];
}

@end

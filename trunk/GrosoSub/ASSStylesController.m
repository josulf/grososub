//
//  ASSStylesController.m
//  GrosoSub
//
//  Created by Josu López Fernández on 29/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ASSStylesController.h"


@implementation ASSStylesController
#pragma mark NSWindowController
- (id)init
{
	self = [super initWithWindowNibName:@"ASSStyles"];
	
	return self;
}

- (NSString *)windowTitleForDocumentDisplayName:(NSString *)displayName
{
	return [displayName stringByAppendingString:@" - Styles Manager"];
}
@end

//
//  ASSEventTextView.h
//  GrosoSub
//
//  Created by Josu López Fernández on 21/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface ASSEventTextView : NSTextView {

}
- (void)setEnabled:(Boolean)flag;
- (NSString *)string;
@end

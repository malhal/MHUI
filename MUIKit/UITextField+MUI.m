//
//  UITextField+MUI.m
//  MUIKit
//
//  Created by Malcolm Hall on 16/01/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//

#import "UITextField+MUI.h"

@implementation UITextField (MUI)

- (UITextInputTraits *)mui_textInputTraits{
    return [self valueForKey:@"textInputTraits"];
}

- (void)mui_setInsertionPointColor:(UIColor *)color{
    [self.mui_textInputTraits setValue:color forKey:@"insertionPointColor"];
}

- (UIColor *)mui_insertionPointColor{
    return [self.mui_textInputTraits valueForKey:@"insertionPointColor"];
}

@end

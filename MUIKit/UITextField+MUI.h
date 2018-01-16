//
//  UITextField+MUI.h
//  MUIKit
//
//  Created by Malcolm Hall on 16/01/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MUIKit/MUIDefines.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (MUI)

@property (nonatomic, strong, setter=mui_setInsertionPointColor:) UIColor *mui_insertionPointColor;

@property (nonatomic, strong, readonly) NSObject<UITextInputTraits> *mui_textInputTraits;

@end

NS_ASSUME_NONNULL_END

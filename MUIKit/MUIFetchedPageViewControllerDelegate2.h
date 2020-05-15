//
//  MUIFetchedPageViewControllerDelegate.h
//  MUIKit
//
//  Created by Malcolm Hall on 18/04/2020.
//  Copyright © 2020 Malcolm Hall. All rights reserved.
//

#import <MCoreData/MCoreData.h>
#import <MHFoundation/MHFoundation.h>
#import <UIKit/UIKit.h>
#import <MUIKit/MUIDefines.h>

NS_ASSUME_NONNULL_BEGIN

@interface MUIFetchedPageViewControllerDelegate2 : NSObject <UIPageViewControllerDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) id selectedPageObject;

@end

NS_ASSUME_NONNULL_END

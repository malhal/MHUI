//
//  SelectionManager.h
//  CloudEvents
//
//  Created by Malcolm Hall on 10/06/2019.
//  Copyright © 2019 Malcolm Hall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <MUIKit/MUIDefines.h>
#import <MUIKit/MUITableView.h>
#import <MUIKit/MUISelectionManager.h>

NS_ASSUME_NONNULL_BEGIN

@class MUIFetchedDataSource;
//@protocol MUIFetchedSelectionManagerDelegate;

@interface MUIFetchedSelectionManager : MUISelectionManager <NSFetchedResultsControllerDelegate>

//@property (weak, nonatomic) id<MUIFetchedSelectionManagerDelegate> delegate;



@end



NS_ASSUME_NONNULL_END

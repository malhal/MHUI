//
//  MUIFetchedDetailNavigationController.h
//  MUIKit
//
//  Created by Malcolm Hall on 12/02/2020.
//  Copyright © 2020 Malcolm Hall. All rights reserved.
//

#import <MUIKit/MUIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MUIFetchedDetailNavigationController<ResultType:id<NSFetchRequestResult>> : MUIDetailNavigationController <UIDataSourceModelAssociation, NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController<ResultType> *fetchedResultsController;

@end

NS_ASSUME_NONNULL_END

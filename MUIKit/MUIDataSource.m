//
//  MUIDataSource.m
//  MUIKit
//
//  Created by Malcolm Hall on 17/06/2019.
//  Copyright © 2019 Malcolm Hall. All rights reserved.
//

#import "MUIDataSource_Internal.h"
#import "MUITableViewController.h"

@interface MUIDataSource()

@property (strong, nonatomic) NSMutableDictionary *objectClassesByReuseIdentifier;

@end

@implementation MUIDataSource

- (instancetype)init
{
    NSAssert(self.class != MUIDataSource.class, @"You must use a concrete subclass of MUIDataSource");
    self = [super init];
    if (self) {
        _objectClassesByReuseIdentifier = [NSMutableDictionary dictionaryWithObject:NSObject.class forKey:@"Cell"];
    }
    return self;
}

- (void)registerReuseIdentifier:(NSString *)reuseIdentifier forObjectOfClass:(Class)class{
    self.objectClassesByReuseIdentifier[reuseIdentifier] = class;
}

- (void)configureCell:(UITableViewCell *)cell withObject:(id)object{
    if([self.delegate respondsToSelector:@selector(objectDataSource:configureCell:withObject:)]){
        [self.delegate objectDataSource:self configureCell:cell withObject:object];
    }
}

- (id)objectAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

- (NSIndexPath *)indexPathForObject:(id)object{
    return nil;
}

- (NSArray *)objects{
    return nil;
}

- (void)setTableViewController:(MUITableViewController *)tableViewController{
    if(tableViewController == _tableViewController){
        return;
    }
    _tableViewController = tableViewController;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    id object = [self objectAtIndexPath:indexPath];
    NSString *reuseIdentifier = nil;
    for(NSString *s in self.objectClassesByReuseIdentifier.allKeys){
        Class class = self.objectClassesByReuseIdentifier[s];
        if([object isKindOfClass:class]){
            reuseIdentifier = s;
            break;
        }
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    [self configureCell:cell withObject:object];
    return cell;
}

@end

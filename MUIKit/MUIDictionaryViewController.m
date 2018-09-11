//
//  OtherInfoViewController.m
//  MUIKit
//
//  Created by Malcolm Hall on 13/02/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import "MUIDictionaryViewController.h"

@interface MUIDictionaryViewController()

@property NSArray* keys;

@end

@implementation MUIDictionaryViewController

- (void)setDictionary:(NSDictionary *)dictionary{
    if(_dictionary != dictionary) {
        _dictionary = dictionary;
        
        // Update the view.
        [self configureView];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.dictionary) {
        self.keys = self.dictionary.allKeys;
        [self.tableView reloadData];
    }
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.keys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* kIdentifier = @"Cell";
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kIdentifier];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kIdentifier];
    }
    NSString* key = self.keys[indexPath.row];
    cell.textLabel.text = key;
    NSObject* i = self.dictionary[key];
    
    NSString* original = [i.description stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSString *squashed = [original stringByReplacingOccurrencesOfString:@"[ ]+"
                                                             withString:@" "
                                                                options:NSRegularExpressionSearch
                                                                  range:NSMakeRange(0, original.length)];
    
    NSString *final = [squashed stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    cell.detailTextLabel.text = final;
    
    if([i isKindOfClass:[NSDictionary class]]){
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    }
    else{
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *key = self.keys[indexPath.row];
    NSDictionary* d = self.dictionary[key];
    if(![d isKindOfClass:NSDictionary.class]){
        return;
    }
    MUIDictionaryViewController* dvc = [MUIDictionaryViewController.alloc initWithStyle:UITableViewStylePlain];
    dvc.dictionary = d;
    dvc.title = key;
    [self.navigationController pushViewController:dvc animated:YES];
}


//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        [self.objects removeObjectAtIndex:indexPath.row];
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
//    }
//}


@end

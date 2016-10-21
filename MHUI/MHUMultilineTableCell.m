//
//  MHUMultilineTableCell.m
//  MultilineCellTest
//
//  Created by Malcolm Hall on 21/10/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import "MHUMultilineTableCell.h"

@implementation MHUMultilineTableCell

- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize
        withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority
              verticalFittingPriority:(UILayoutPriority)verticalFittingPriority
{
    [self layoutIfNeeded];
    CGSize size = [super systemLayoutSizeFittingSize:targetSize
                       withHorizontalFittingPriority:horizontalFittingPriority
                             verticalFittingPriority:verticalFittingPriority];
    CGFloat detailHeight = CGRectGetHeight(self.detailTextLabel.frame);
    if (detailHeight) { // if no detailTextLabel (eg style = Default) then no adjustment necessary
        // Determine UITableViewCellStyle by looking at textLabel vs detailTextLabel layout
        if (CGRectGetMinX(self.detailTextLabel.frame) > CGRectGetMinX(self.textLabel.frame)) { // style = Value1 or Value2
            CGFloat textHeight = CGRectGetHeight(self.textLabel.frame);
            // If detailTextLabel taller than textLabel then add difference to cell height
            if (detailHeight > textHeight) size.height += detailHeight - textHeight;
        } else { // style = Subtitle, so always add subtitle height
            size.height += detailHeight;
        }
    }
    return size;
}

@end

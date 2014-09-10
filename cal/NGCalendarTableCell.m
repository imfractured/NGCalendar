//
//  IVCalendarTableCell.m
//  cal
//
//  Created by Nick Gorman on 2014-06-23.
//  Copyright (c) 2014 Nick Gorman. All rights reserved.
//

#import "NGCalendarTableCell.h"

@implementation NGCalendarTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

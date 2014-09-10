//
//  IVCalendarViewCell.m
//  cal
//
//  Created by Nick Gorman on 2014-06-20.
//  Copyright (c) 2014 Nick Gorman. All rights reserved.
//

#import "NGCalendarGridViewCell.h"

@implementation NGCalendarGridViewCell

@synthesize _dateLabel;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor grayColor];
        
        _dateLabel = [UILabel new];
        _dateLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _dateLabel.font = [UIFont boldSystemFontOfSize:24];
        _dateLabel.textAlignment = NSTextAlignmentCenter;
        _dateLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:_dateLabel];
        
        // set the constraints for the label
        [self pinView:_dateLabel toContentViewAttribute:NSLayoutAttributeLeft withPadding:0];
        [self pinView:_dateLabel toContentViewAttribute:NSLayoutAttributeTop withPadding:0];
        [self pinView:_dateLabel toContentViewAttribute:NSLayoutAttributeRight withPadding:0];
        [self pinView:_dateLabel toContentViewAttribute:NSLayoutAttributeBottom withPadding:0];
    }
    return self;
}

-(void)pinView:(UIView *)view toContentViewAttribute:(NSLayoutAttribute)attribute withPadding:(CGFloat)padding {
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView attribute:attribute relatedBy:NSLayoutRelationEqual toItem:view attribute:attribute multiplier:1 constant:padding]];
}


@end

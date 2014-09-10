//
//  IVCalendarHeaderCell.m
//  cal
//
//  Created by Nick Gorman on 2014-06-20.
//  Copyright (c) 2014 Nick Gorman. All rights reserved.
//

#import "NGCalendarHeaderCell.h"

@implementation NGCalendarHeaderCell

@synthesize _titleLabel;
@synthesize _mon;
@synthesize _tue;
@synthesize _wed;
@synthesize _thu;
@synthesize _fri;
@synthesize _sat;
@synthesize _sun;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {

        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont boldSystemFontOfSize:38];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor grayColor];
        
        [self.contentView addSubview:_titleLabel];
        _titleLabel.frame = CGRectMake(0,10,self.frame.size.width,70);
        
        _mon = [UILabel new];
        _tue = [UILabel new];
        _wed = [UILabel new];
        _thu = [UILabel new];
        _fri = [UILabel new];
        _sat = [UILabel new];
        _sun = [UILabel new];
        
        NSArray *daysOfWeek = @[_sun, _mon, _tue, _wed, _thu, _fri, _sat];
        NSArray *daysOfWeekStrings = @[@"Sun",@"Mon",@"Tue",@"Wed",@"Thu",@"Fri",@"Sat"];
        for ( int i = 0; i < [daysOfWeek count]; i++ ){
            UILabel *lbl = [daysOfWeek objectAtIndex:i];
            lbl.textAlignment = NSTextAlignmentCenter;
            lbl.textColor = [UIColor grayColor];
            lbl.frame = CGRectMake(i*(self.frame.size.width/7),68,self.frame.size.width/7,20);
            [lbl setText:[daysOfWeekStrings objectAtIndex:i]];
            [self.contentView addSubview:lbl];

        }
    }
    return self;
}

-(NSArray*)getDayLabels {
    NSArray *daysOfWeek = @[_sun, _mon, _tue, _wed, _thu, _fri, _sat];
    return daysOfWeek;
}

-(void)pinView:(UIView *)view toContentViewAttribute:(NSLayoutAttribute)attribute withPadding:(CGFloat)padding {
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView attribute:attribute relatedBy:NSLayoutRelationEqual toItem:view attribute:attribute multiplier:1 constant:padding]];
}


@end

//
//  IVCalendarViewCell.h
//  cal
//
//  Created by Nick Gorman on 2014-06-20.
//  Copyright (c) 2014 Nick Gorman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NGCalendarHeaderCell : UICollectionViewCell

@property (retain) UILabel *_titleLabel;
@property (retain) UILabel *_mon;
@property (retain) UILabel *_tue;
@property (retain) UILabel *_wed;
@property (retain) UILabel *_thu;
@property (retain) UILabel *_fri;
@property (retain) UILabel *_sat;
@property (retain) UILabel *_sun;

-(NSArray*)getDayLabels;

@end

//
//  IVCalendarController.h
//  cal
//
//  Created by Nick Gorman on 2014-06-20.
//  Copyright (c) 2014 Nick Gorman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NGCalendarModel.h"
#import "NGCalendarGridViewCell.h"
#import "NGCalendarHeaderCell.h"
#import "RDHCollectionViewGridLayout.h"

@interface NGCalendarGrid : UIView <UICollectionViewDataSource, UICollectionViewDelegate> {
    RDHCollectionViewGridLayout *_collectionViewLayout;
    NGCalendarModel *_collectionModel;
}

// COLLECTION VARS
@property (nonatomic, retain) UICollectionView *_collectionView;
@property (nonatomic) int spacer;
@property (nonatomic, retain) NSArray *months;

// CALENDAR VARS
@property (nonatomic, retain) NSMutableArray *data;
@property (nonatomic, retain) NSDateComponents *component;
@property (nonatomic) NSInteger anchorMonth;
@property (nonatomic) NSInteger anchorYear;

@property (nonatomic) BOOL scrollEnabled;


- (id)initWithFrame:(CGRect)frame andModel:(NGCalendarModel*)model;
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath;
-(NGCalendarGridViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
-(void)scrollToSection:(int)section;
-(void)createCollection;

@end

//
//  IVCalendarController.m
//  cal
//
//  Created by Nick Gorman on 2014-06-20.
//  Copyright (c) 2014 Nick Gorman. All rights reserved.
//

/*
 
 EXAMPLE:
 
 IVCalendarModel *calModel = [[IVCalendarModel alloc] init];
 
 IVCalendarTable *calTable = [[IVCalendarTable alloc] initWithFrame:CGRectMake(10,10,400,400) andModel:calModel];
 [self.view addSubview:calTable];
 
 IVCalendarGrid *calGrid = [[IVCalendarGrid alloc] initWithFrame:CGRectMake(500,10,400,400) andModel:calModel];
 [self.view addSubview:calGrid];
 
*/
#import "NGCalendarGrid.h"
#import "RDHCollectionViewGridLayout.h"
#import "NSDate+Utils.h"

@implementation NGCalendarGrid

@synthesize _collectionView;
@synthesize spacer;
@synthesize months;
@synthesize data;
@synthesize component;
@synthesize anchorMonth;
@synthesize anchorYear;

- (id)initWithFrame:(CGRect)frame andModel:(NGCalendarModel*)model {
    self = [super initWithFrame:frame];
    if (self) {
        anchorMonth = 0;
        _collectionModel = model;
        spacer = 5; // space between cells
        data = [[NSMutableArray alloc] init];
        component = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
        [self createCollection];
    }
    return self;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// COLLECTION //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

-(void)createCollection {
    
    
    [data addObject:[_collectionModel getMonth:component AsGrid:YES]];
    anchorMonth = component.month; // set the anchor so we know each month by id
    anchorYear = component.year;   // set the anchor so we can id each year


    _collectionViewLayout = [[RDHCollectionViewGridLayout alloc] init];
    _collectionViewLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    _collectionViewLayout.itemSpacing = spacer;             // spacing between cells ( horizontal )
    _collectionViewLayout.lineSpacing = spacer;             // spacing between cells ( vertical )
    _collectionViewLayout.lineItemCount = 7;                // how many cells per row
    _collectionViewLayout.sectionsStartOnNewLine = YES;     // force sections to start on new line
    _collectionViewLayout.floatingSectionHeaders = NO;      // sticky headers
    _collectionViewLayout.sectionDimension = 90;            // height of header
    
    CGRect newFrame = self.frame;
    
    newFrame.origin.x = 0;
    newFrame.origin.y = 0;
    newFrame.size.width = newFrame.size.width;
    newFrame.size.height = newFrame.size.height;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:newFrame collectionViewLayout: _collectionViewLayout];
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    [_collectionView registerClass:[NGCalendarGridViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [_collectionView registerClass:[NGCalendarHeaderCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    
    [self addSubview:_collectionView];
    
    [self setClipsToBounds:YES];
    [_collectionView setClipsToBounds:YES];
    
}

-(void)setScrollEnabled:(BOOL)scrollEnabled {
    _collectionView.scrollEnabled = scrollEnabled;
}

-(void)scrollToSection:(int)section {
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:[[data objectAtIndex:section] count]-1 inSection:section] atScrollPosition:UICollectionViewScrollPositionBottom animated:YES];
}

// number of calendar cells
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[data objectAtIndex:section] count];
}

// number of months?
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [data count];
}

// header cell setup
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    NGCalendarHeaderCell *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
    NSDate *obj = [[self.data objectAtIndex:indexPath.section] objectAtIndex:10];
    NSString *dateString = [[NSString alloc] initWithFormat:@"%@ - %i",obj.monthString,obj.year];
    [header._titleLabel setText:dateString];
    return header;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"tapped");
}

// body cell setup
-(NGCalendarGridViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NGCalendarGridViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    NSDate *obj = [[data objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    BOOL isEnabled = [obj.isEnabled boolValue];

    if ( isEnabled == 1 ){
        [cell._dateLabel setText:[NSString stringWithFormat: @"%d", (int)obj.day]];
        cell.backgroundColor = [UIColor grayColor];
    } else {
        [cell._dateLabel setText:@""];
        cell.layer.borderWidth = 1;
        cell.layer.borderColor = [UIColor grayColor].CGColor;
        cell.backgroundColor = [UIColor clearColor];

    }
    return cell;
}

-(void)loadMoreData {
    if ( component.month == 12 ){
        [component setYear: component.year + 1];
        [component setMonth: 1];
    } else {
        [component setMonth: component.month + 1];
    }
    [data addObject:[_collectionModel getMonth:component AsGrid:YES]];
    dispatch_async(dispatch_get_main_queue(), ^ {
        [_collectionView reloadData];
    });
}

-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger lastSectionIndex = [collectionView numberOfSections] - 1;
    NSInteger lastRowIndex = [collectionView numberOfItemsInSection:lastSectionIndex] - 1;
    if ((indexPath.section == lastSectionIndex) && (indexPath.row == lastRowIndex)) {
        [self loadMoreData];
    }
}


@end
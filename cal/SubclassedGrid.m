//
//  SubclassedGrid.m
//  cal
//
//  Created by Nick Gorman on 2014-08-20.
//  Copyright (c) 2014 Nick Gorman. All rights reserved.
//

#import "SubclassedGrid.h"
#import "NSDate+Utils.h"

@implementation SubclassedGrid

// customized header
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    NGCalendarHeaderCell *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
    NSDate *obj = [[self.data objectAtIndex:indexPath.section] objectAtIndex:10];
    NSString *dateString = [[NSString alloc] initWithFormat:@"%@ - %i",obj.monthString,obj.year];
    [header._titleLabel setText:dateString];
    return header;
}

// body cell setup
-(NGCalendarGridViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NGCalendarGridViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    NSDate *obj = [[self.data objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
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

// override create collection with custom date
-(void)createCollection {
    NSDateFormatter *oldFormatter = [[NSDateFormatter alloc] init];
    [oldFormatter setDateFormat: @"dd/MM/yyyy"];
    NSString *oldString = @"27/1/2014";
    NSDate *theDate= [oldFormatter dateFromString:oldString];
    self.component = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:theDate];
    [super createCollection];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSDate *obj = [[self.data objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    NSLog(@"subclassed tap: %@",[obj description]);
}


@end

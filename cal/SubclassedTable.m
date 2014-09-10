//
//  SubclassedTable.m
//  cal
//
//  Created by Nick Gorman on 2014-08-20.
//  Copyright (c) 2014 Nick Gorman. All rights reserved.
//

#import "SubclassedTable.h"
#import "NSDate+Utils.h"

@implementation SubclassedTable

-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    view.tintColor = [UIColor redColor];
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header.textLabel setTextColor:[UIColor whiteColor]];
    [header.textLabel setFont:[UIFont systemFontOfSize:32]];

}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if ( self.showHeader ){
        NSDate *obj = [[self.data objectAtIndex:section] objectAtIndex:0];
        NSString *dateString = [[NSString alloc] initWithFormat:@"%@ %i",obj.monthString,obj.year ];
        return dateString;
    } else {
        return @"";
    }
}

-(NGCalendarTableCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NGCalendarTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentifier"];
    NSDate *obj = [[self.data objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    NSString *strFromInt = [NSString stringWithFormat:@"%d",obj.day];
    
    if ( self.showHeader ){
        [cell.textLabel setText:strFromInt];
    } else {
        [cell.textLabel setText:[[NSString alloc] initWithFormat:@"%@ %i, %i",obj.monthString,obj.day,obj.year]];
    }
    
    if ( obj.isToday ){
        cell.backgroundColor = [UIColor blueColor];
    } else if ( obj.dayOfWeek ){
        cell.backgroundColor = [UIColor clearColor];
    } else {
        cell.backgroundColor = [UIColor redColor];
    }

    return cell;
}

-(void)createTable {
    NSDateFormatter *oldFormatter = [[NSDateFormatter alloc] init];
    [oldFormatter setDateFormat: @"dd/MM/yyyy"];
    NSString *oldString = @"27/12/2013";
    NSDate *theDate= [oldFormatter dateFromString:oldString];
    self.component = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:theDate];
    [super createTable];
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDate *obj = [[self.data objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    NSLog(@"subclassed tap: %i",obj.day);
}


@end

//
//  IVCalendarModel.m
//  cal
//
//  Created by Nick Gorman on 2014-06-20.
//  Copyright (c) 2014 Nick Gorman. All rights reserved.
//

#import "NGCalendarModel.h"
#import "NSDate+Utils.h"

@implementation NGCalendarModel

-(NSArray*)getMonth:(NSDateComponents*)_currDateTime AsGrid:(BOOL)grid {

    // create array for month objects in order
    NSMutableArray *_days = [[NSMutableArray alloc] init];

    // get the month component and reset it back to the first
    NSDateComponents *_firstDay = _currDateTime;
    [_firstDay setDay: 1];
    
    // get day position for first day of month, this is how we know where to start entering dates
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *date = [[NSCalendar currentCalendar] dateFromComponents:_firstDay];
    NSDateComponents *weekdayComponents =[gregorian components:NSWeekdayCalendarUnit fromDate:date];
    NSInteger _firstDayColumn = [weekdayComponents weekday];
    _firstDayColumn--;
    
    // get max days for current month w.r.t leap year if any
    NSRange days = [[NSCalendar currentCalendar] rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:date];
    NSInteger _maxDays = days.length;
    
    int counter = 0;
    
    
    // if asGrid is true, the array will populate based on uicollectionview grid ( having dead cells for prev / next month )
    if ( grid == YES ){
    
        // remove extra row if we dont need it
        int totalCells = 42;
        if ( _maxDays + _firstDayColumn <= 35 ){
            totalCells = totalCells - 7;
        }
        
        // build clean array
        for ( int i = 0; i < totalCells; i++ ){
            NSDate *obj = [[NSDate alloc] init];
            obj.isEnabled = [[NSNumber alloc] initWithBool:NO];
            [_days addObject:obj];
        }

        // add dates to array to match collection
        for ( NSInteger i = _firstDayColumn; i < _maxDays+_firstDayColumn; i++ ){
            
            // get day of week
            NSDate *obj = [NSDate dateWithYear:_firstDay.year month:_firstDay.month day:counter+1];
            obj.isEnabled = [[NSNumber alloc] initWithBool:YES];
            [_days replaceObjectAtIndex:i withObject:obj];
            [_firstDay setDay:counter+1];
            counter++;
        }
        
        
    // asGrid = NO, this means we just populate the array for each day of the month only
    } else {
        
        for ( int i = 0; i < _maxDays; i++ ){
            // get day of week
            NSDate *obj = [NSDate dateWithYear:_firstDay.year month:_firstDay.month day:counter+1];
            [_days addObject:obj];
            counter++;
        }
        
    }
    return _days;
}

@end

//
//  ViewController.m
//  cal
//
//  Created by Nick Gorman on 2014-06-20.
//  Copyright (c) 2014 Nick Gorman. All rights reserved.
//

#import "ViewController.h"
#import "NGCalendarModel.h"
#import "NGCalendarGrid.h"
#import "NGCalendarTable.h"
#import "SubclassedTable.h"
#import "SubclassedGrid.h"
#import "NSDate+Utils.h"

@interface ViewController ()

@end

@implementation ViewController {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NGCalendarModel *calModel = [[NGCalendarModel alloc] init];
    
    SubclassedTable *calTable = [[SubclassedTable alloc] initWithFrame:CGRectMake(10,10,400,400) andModel:calModel];
    calTable.showHeader = YES;
    [self.view addSubview:calTable];
    
    SubclassedGrid *calGrid = [[SubclassedGrid alloc] initWithFrame:CGRectMake(500,10,400,400) andModel:calModel];
    //calGrid.scrollEnabled = NO;
    [self.view addSubview:calGrid];
    
    //NSDate *date = [NSDate dateWithYear:2013 month:10 day:4];
    //NSLog(@"date %@",date.description);
}

@end

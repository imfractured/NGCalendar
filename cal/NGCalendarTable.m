//
//  IVCalendarTable.m
//  cal
//
//  Created by Nick Gorman on 2014-06-23.
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

#import "NGCalendarTable.h"
#import "NGCalendarTableCell.h"
#import "NSDate+Utils.h"

@implementation NGCalendarTable

@synthesize data;
@synthesize _tableView;
@synthesize component;
@synthesize _collectionModel;
@synthesize showHeader;

- (id)initWithFrame:(CGRect)frame andModel:(NGCalendarModel*)model {
    self = [super initWithFrame:frame];
    if (self) {
        _collectionModel = model;
        data = [[NSMutableArray alloc] init];
        component = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
        [self createTable];
    }
    return self;
}

-(void)createTable {
    
    [data addObject:[_collectionModel getMonth:component AsGrid:NO]];
    
    CGRect tableRect = CGRectMake(0,0,self.frame.size.width, self.frame.size.height);
    
    _tableView = [[UITableView alloc] initWithFrame:tableRect];
    _tableView.delegate = self;
    _tableView.dataSource = self;

    [_tableView registerClass:[NGCalendarTableCell class] forCellReuseIdentifier:@"cellIdentifier"];
    [self addSubview:_tableView];
    
    [self setClipsToBounds:YES];
    [_tableView setClipsToBounds:YES];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[data objectAtIndex:section] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if ( showHeader ){
        NSDate *obj = [[data objectAtIndex:section] objectAtIndex:0];
        return obj.monthString;
    } else {
        return @"";
    }
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    view.tintColor = [UIColor blackColor];
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header.textLabel setTextColor:[UIColor whiteColor]];
    [header.textLabel setFont:[UIFont systemFontOfSize:32]];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [data count];
}

-(NGCalendarTableCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NGCalendarTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentifier"];
    NSDate *obj = [[data objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    [cell.textLabel setText:[obj description]];
    return cell;
}

-(void)loadMoreData {
    if ( component.month == 12 ){
        [component setMonth: 1];
        [component setYear: component.year + 1];
    } else {
        [component setMonth: component.month + 1];
    }
    [data addObject:[_collectionModel getMonth:component AsGrid:NO]];
    dispatch_async(dispatch_get_main_queue(), ^ {
        [_tableView reloadData];
    });
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger lastSectionIndex = [tableView numberOfSections] - 1;
    NSInteger lastRowIndex = [tableView numberOfRowsInSection:lastSectionIndex] - 1;
    if ((indexPath.section == lastSectionIndex) && (indexPath.row == lastRowIndex)) {
        [self loadMoreData];
    }
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"TAPPED");
}

@end

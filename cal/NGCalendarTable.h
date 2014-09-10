//
//  IVCalendarTable.h
//  cal
//
//  Created by Nick Gorman on 2014-06-23.
//  Copyright (c) 2014 Nick Gorman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NGCalendarModel.h"
#import "NGCalendarTableCell.h"

@interface NGCalendarTable : UIView <UITableViewDataSource, UITableViewDelegate> 

@property (nonatomic, retain) NSMutableArray *data;
@property (nonatomic, retain) UITableView *_tableView;
@property (nonatomic, retain) NSDateComponents *component;
@property (nonatomic, retain) NGCalendarModel *_collectionModel;        // Calendar Model
@property (nonatomic) BOOL showHeader;                          // Show tableview header with month title

- (id)initWithFrame:(CGRect)frame andModel:(NGCalendarModel*)model;
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath;
-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section;
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;
-(NGCalendarTableCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
-(void)createTable;

@end

NGCalendar

Example Usage:

    NGCalendarModel *calModel = [[NGCalendarModel alloc] init];
    
    SubclassedTable *calTable = [[SubclassedTable alloc] initWithFrame:CGRectMake(10,10,400,400) andModel:calModel];
    calTable.showHeader = YES;
    [self.view addSubview:calTable];
    
    SubclassedGrid *calGrid = [[SubclassedGrid alloc] initWithFrame:CGRectMake(500,10,400,400) andModel:calModel];
    //calGrid.scrollEnabled = NO;
    [self.view addSubview:calGrid];

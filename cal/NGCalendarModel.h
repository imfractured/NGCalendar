//
//  IVCalendarModel.h
//  cal
//
//  Created by Nick Gorman on 2014-06-20.
//  Copyright (c) 2014 Nick Gorman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NGCalendarModel : NSObject

-(NSArray*)getMonth:(NSDateComponents*)_currDateTime AsGrid:(BOOL)grid ;

@end

//
//  KFRiLiViewController.h
//  KFManagerSystem
//
//  Created by admin on 14-11-18.
//  Copyright (c) 2014年 gychao. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSDate * calendarViewSelect;

/// 日历
@interface KFRiLiViewController : KFBaseViewController<VRGCalendarViewDelegate , UITableViewDelegate, UITableViewDataSource>


@property (weak, nonatomic) IBOutlet KFCalendarContainerView *calendarVIewContainter;





#pragma mark - 日历list 需要
@property (weak, nonatomic) IBOutlet UITableView *riliListTable;
@property(nonatomic,strong) NSMutableArray * OneDayArr;





@end

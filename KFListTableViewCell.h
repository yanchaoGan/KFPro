//
//  KFListTableViewCell.h
//  KFManagerSystem
//
//  Created by admin on 14-11-20.
//  Copyright (c) 2014年 gychao. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSMutableArray * _ReuseableArr;
static NSMutableArray * _constranitsArr;


@interface KFListTableViewCell : UITableViewCell




@property (weak, nonatomic) IBOutlet UIView *riqiBG;


@property (weak, nonatomic) IBOutlet UILabel *jihaoLabel;

@property (weak, nonatomic) IBOutlet UILabel *jiyueLabel;

@property (weak, nonatomic) IBOutlet UILabel *zhoujiLabel;




@property (weak, nonatomic) IBOutlet UIView *reuseViewBG;



-(void)disPlayViewByDIC:(NSDictionary *)dic  andByIdentifer:(NSString *)idenifer;
@end

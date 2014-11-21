//
//  KFCommonTableViewCell.h
//  KFManagerSystem
//
//  Created by admin on 14-11-19.
//  Copyright (c) 2014年 gychao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KFCommonTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *appIcon;

@property (weak, nonatomic) IBOutlet UILabel *appdescrble;

@property (weak, nonatomic) IBOutlet UILabel *appStartTime;

@property (weak, nonatomic) IBOutlet UIImageView *appTypeIos;
@property (weak, nonatomic) IBOutlet UIImageView *appTypeAndroid;





#pragma mark -  appType
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *appTypeIosXAligConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *appTypeAndroidXAlignConstraint;



-(void)reDisplayUseData:(id)dataObj byReuseIdentifier:(NSString *)reuseIdentifier;



@end

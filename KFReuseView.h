//
//  KFReuseView.h
//  KFManagerSystem
//
//  Created by admin on 14-11-20.
//  Copyright (c) 2014年 gychao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KFReuseView : UIView


@property (weak, nonatomic) IBOutlet UIImageView *appIcon;

@property (weak, nonatomic) IBOutlet UILabel *appDesc;

@property (weak, nonatomic) IBOutlet UILabel *appStart;


@property (weak, nonatomic) IBOutlet UIImageView *appTypeIos;


@property (weak, nonatomic) IBOutlet UIImageView *appTypeAndroid;


@property (weak, nonatomic) IBOutlet UIImageView *sepertor;

#pragma mark  - constraint

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *appIosContraints;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *appAndroidContraints;



#pragma mark - 记录原始数值

@property(nonatomic,assign)CGFloat IOSX;
@property(nonatomic,assign)CGFloat AndroidX;


-(void)reDisplayUseData:(id)dataObj byReuseIdentifier:(NSString *)reuseIdentifier isLastCell:(BOOL)last;

@end

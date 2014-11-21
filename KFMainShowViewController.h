//
//  KFMainShowViewController.h
//  KFManagerSystem
//
//  Created by admin on 14-11-18.
//  Copyright (c) 2014年 gychao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KFMainShowViewController : KFBaseViewController



#pragma mark - IBoutlet
@property (weak, nonatomic) IBOutlet UIButton *settingBtn;

@property (weak, nonatomic) IBOutlet UIButton *calenderBtn;

@property (weak, nonatomic) IBOutlet UIButton *listBtn;
@property (weak, nonatomic) IBOutlet UIButton *messageBtn;



/**
 *  日历 列表 vc 贴在 这个 view上
 */
@property (weak, nonatomic) IBOutlet UIView *owerVCView;

@end

//
//  KFLoginViewController.h
//  KFManagerSystem
//
//  Created by admin on 14-11-17.
//  Copyright (c) 2014年 gychao. All rights reserved.
//



@interface KFLoginViewController : KFBaseViewController



@property (weak, nonatomic) IBOutlet UIView *LogoImageView;


/**
 *  这个view 是 整个大的 view
 */
@property (weak, nonatomic) IBOutlet UIView *BigAutoFixBG;


/**
 *  输入 局部
 */
@property (weak, nonatomic) IBOutlet UIView *InputBgView;

@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;



/**
 *  大背景 距离 toplayoutguide 的
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *BigFixBGTopconstraint;


/**
 *  点击登录
 *
 *  @param sender 登录按钮
 */
- (IBAction)LoginBtnClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *LoginBtn;

@end

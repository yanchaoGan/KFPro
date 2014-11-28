//
//  KFChangePWViewController.m
//  KFManagerSystem
//
//  Created by admin on 14-11-20.
//  Copyright (c) 2014年 gychao. All rights reserved.
//

#import "KFChangePWViewController.h"

@interface KFChangePWViewController ()

@end

@implementation KFChangePWViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    NSArray * viewArrs = self.reallyBGView.subviews;
   
    for (UIView * tem in viewArrs) {
        [tem.layer setCornerRadius:5];
    }
    
     
     
     
}


#pragma mark - btnclick

- (IBAction)cancelBtnClick:(UIButton *)sender {
    
    [self.navigationController  popViewControllerAnimated:YES];
}


- (IBAction)sureButtonClick:(UIButton *)sender {
    
    KFUser * user = KFDelegate.loginUser;

    if ([self.origntextfield.text  isEqualToString:user.password]) {
        
    }else{
    
        [KFSBHelper simpleAlertTitle:nil message:@"原密码错误" cancel:@"取消"];
    
        return;
    }
    
    if ([KFSBHelper isNotEmptyStringOfObj:self.newtextfield.text] && [KFSBHelper isNotEmptyStringOfObj:self.verfytextfield.text] && [self.newtextfield.text isEqualToString:self.verfytextfield.text]) {
        
    }else{
        
        [KFSBHelper simpleAlertTitle:nil message:@"请确认新密码" cancel:@"取消"];
        return;
    }
    
    
    NSMutableDictionary * MP = [KFSBHelper getParamaByUrlType:urltypechangepassword andOtherParamas:@{@"userid":user.userid,@"password":self.newtextfield.text}];
    
    [KFNetworkHelper postWithUrl:KServerUrl params:MP success:^(id responseObject) {
        
        KFDelegate.loginUser = [KFUser fillUseDic:responseObject];
        [KFSBHelper saveAccount:KFDelegate.loginUser];
        [KFSBHelper simpleAlertTitle:nil message:@"修改密码成功" cancel:@"确定"];
        
        
    } fail:^(NSError *error) {
        
        [KFSBHelper simpleAlertTitle:nil message:@"修改密码失败" cancel:@"确定"];
        
    } andHUBString:@"修改密码..."];
    
    
}






#pragma mark - UITextfield delegate






- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  KFLoginViewController.m
//  KFManagerSystem
//
//  Created by admin on 14-11-17.
//  Copyright (c) 2014年 gychao. All rights reserved.
//

#import "KFLoginViewController.h"


@interface KFLoginViewController ()

@end

@implementation KFLoginViewController

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
    
   UIImage * newImage = [[UIImage imageNamed:@"but1_a.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(20,20,20,20) resizingMode:UIImageResizingModeStretch];
    
    
    [self.LoginBtn setBackgroundImage:newImage forState:UIControlStateNormal];
    KFDelegate.loginUser = [KFSBHelper account];
    if (KFDelegate.loginUser) {
        self.accountTextField.text =  KFDelegate.loginUser.username;
        self.passwordTextField.text = KFDelegate.loginUser.password;
    }else{
    
        if (DEBUG) {
            self.accountTextField.text = @"sianxiang";
            self.passwordTextField.text = @"111111";
        }
    }
    
    
    
}

- (IBAction)LoginBtnClick:(UIButton *)sender {
    
    [self touchesBegan:nil withEvent:nil];
    
    if (!([KFSBHelper isNotEmptyStringOfObj:self.accountTextField.text] && [KFSBHelper isNotEmptyStringOfObj:self.passwordTextField.text])) {
        
        DXAlertView * alertview = [[DXAlertView alloc] initWithTitle:nil contentText:@"账号密码非空!" leftButtonTitle:nil rightButtonTitle:nil];
    
        [alertview show];
    }else{
        
        [self performSelector:@selector(checkAccount:) withObject:nil afterDelay:.0f];
    }
}


-(void)checkAccount:(id)future{
    
    
//    NSMutableDictionary * MP = [KFSBHelper getParamaByUrlType:urltypelogin andOtherParamas:@{@"username":self.accountTextField.text,@"password":self.passwordTextField.text}];
//    
//    [KFNetworkHelper postWithUrl:KServerUrl params:MP success:^(id responseObject) {
//        
//        
//        KFDelegate.loginUser = [KFUser fillUseDic:responseObject];
//        [KFSBHelper saveAccount:KFDelegate.loginUser];
//        
//         [KFSBHelper  changeWindowRootVCToAfterLogin:YES orToLoginVC:NO];
//        
//    } fail:^(NSError *error) {
//        NSLog(@"%@",error.userInfo);
//    } andHUBString:@"Loading..."];
    
    // for test
    KFDelegate.loginUser = [KFUser fillUseDic:@{@"username":@"zhangtao",@"nickname":@"你好",@"userid":@"001",@"password":@"111111"}];
    [KFSBHelper  changeWindowRootVCToAfterLogin:YES orToLoginVC:NO];
    
}

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

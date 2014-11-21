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
    
    
    
}

- (IBAction)LoginBtnClick:(UIButton *)sender {
    
    [self touchesBegan:nil withEvent:nil];
    
    if (self.accountTextField.text.length == 0 || self.passwordTextField.text.length == 0) {
        
        DXAlertView * alertview = [[DXAlertView alloc] initWithTitle:nil contentText:@"账号密码非空!" leftButtonTitle:nil rightButtonTitle:nil];
    
        [alertview show];
    }else{
        
        [self performSelector:@selector(checkAccount:) withObject:nil afterDelay:.0f];
    }
}


-(void)checkAccount:(id)future{
    
//    [KFNetworkHelper postWithUrl:<#(NSString *)#> params:<#(NSDictionary *)#> success:<#^(id responseObject)success#> fail:<#^(NSError *error)fail#>]
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

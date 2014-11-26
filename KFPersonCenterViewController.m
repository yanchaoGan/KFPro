//
//  KFPersonCenterViewController.m
//  KFManagerSystem
//
//  Created by admin on 14-11-20.
//  Copyright (c) 2014年 gychao. All rights reserved.
//

#import "KFPersonCenterViewController.h"

@interface KFPersonCenterViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation KFPersonCenterViewController

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

    [self.userPhotoBG.layer  setCornerRadius:CGRectGetWidth(self.userPhotoBG.bounds)/2.0];
    [self.userPhoto.layer  setCornerRadius:CGRectGetWidth(self.userPhoto.bounds)/2.0];
    
}





- (IBAction)backBtnClick:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}




- (IBAction)logout:(UIButton *)sender {
    
    [KFSBHelper changeWindowRootVCToAfterLogin:NO orToLoginVC:YES];
}



- (IBAction)photoClick:(UITapGestureRecognizer *)sender {

    
    UIActionSheet* actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"请选择文件来源"
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"照相机",@"摄像机",@"本地相簿",@"本地视频",nil];
    [actionSheet showInView:self.view];

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

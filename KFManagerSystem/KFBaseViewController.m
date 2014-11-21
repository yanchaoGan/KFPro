//
//  KFBaseViewController.m
//  KFSystem
//
//  Created by admin on 14-11-17.
//  Copyright (c) 2014年 gychao. All rights reserved.
//

#import "KFBaseViewController.h"

#import "KFLoginViewController.h"


@interface KFBaseViewController ()

@end

@implementation KFBaseViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //NSLog(@"%@ viewdidload",NSStringFromClass([self class]));
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = YES;
    }
}


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    if ([self isMemberOfClass:[KFLoginViewController class]]) {

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)viewWillLayoutSubviews{

    [super viewWillLayoutSubviews];
    //NSLog(@"%@ viewwillLayoutSubviews",NSStringFromClass([self class]));
}


#pragma mark - 键盘弹起来处理
-(void)keyBoardWillShow:(NSNotification *)notice{
    
    self.keyBoardIsShow = YES;
    [self dealKeyBoardShow:notice];
    
}

-(void)keyBoardWillHidden:(NSNotification *)notice{
    
    self.keyBoardIsShow = NO;
}

-(void)dealKeyBoardShow:(NSNotification *)notice{
    
    @synchronized(self){
        
        CGRect  keyBoardFrame;
        if (notice) {
            keyBoardFrame   = [[notice.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
            self.keyBoardFrame = keyBoardFrame;
            
            if (keyBoardFrame.origin.x < 0 || keyBoardFrame.origin.y <0) {
                return;
            }
            
        }else{
            
            keyBoardFrame = self.keyBoardFrame;
        }
        
        // 获取横屏幕 键盘高度
        CGFloat  keyHeight = ((keyBoardFrame.size.width > keyBoardFrame.size.height)?keyBoardFrame.size.height:keyBoardFrame.size.width);
        
        
        UITextField * textField =  nil;
        
        if ([self isMemberOfClass:[KFLoginViewController class]]) {
            
           textField =  ((((KFLoginViewController *)self).accountTextField.isFirstResponder == YES)?((KFLoginViewController *)self).accountTextField:((KFLoginViewController *)self).passwordTextField);
        }
      
        
        CGRect frame = [textField.superview convertRect:textField.frame toView:((KFLoginViewController *)self).BigAutoFixBG];
        int offset = frame.origin.y + frame.size.height  - (((KFLoginViewController *)self).BigAutoFixBG.frame.size.height + fabs((((KFLoginViewController *)self).BigAutoFixBG.frame.origin.y > 0? 0 :self.view.frame.origin.y)) - keyHeight);
        
        ;
        
        NSTimeInterval duration = [[notice.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        
        NSTimeInterval animationDuration = (notice)?duration:0.3;
        
        [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
        [UIView setAnimationDuration:animationDuration];
        
        //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
        if(offset > 0){
            
            self.keyBoardTotalEdgeY = self.keyBoardEdgeY + offset +10;
            self.keyBoardEdgeY = offset +10;
            //NSLog(@"做了偏移，总偏移亮是 : %f",self.keyBoardTotalEdgeY);
            
            ((KFLoginViewController *)self).BigFixBGTopconstraint.constant -= self.keyBoardEdgeY;
            
            [((KFLoginViewController *)self).view updateConstraintsIfNeeded];
            
//            self.view.frame = CGRectMake(0.0f,self.view.frame.origin.y - self.keyBoardEdgeY, self.view.frame.size.width, self.view.frame.size.height);
        }
        
        
        [UIView commitAnimations];
        
    }
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([self isMemberOfClass:[KFLoginViewController class]]) {
     
        [((KFLoginViewController *)self).accountTextField resignFirstResponder];
        [((KFLoginViewController *)self).passwordTextField resignFirstResponder];
    }

}



#pragma mark - textfild代理
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
    //    if (self.account == textField) {
    //        self.useraccount = text;
    //
    //    }else if (self.pwd == textField)
    //    {
    //        self.userpwd = text;
    //
    //    }
#define kEnglishNum @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
    //只允许输入英文和数字
    NSCharacterSet *cs;
    cs = [[NSCharacterSet characterSetWithCharactersInString:kEnglishNum] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL basic = [string isEqualToString:filtered];
    if(!basic) {
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示"
                              
                                                        message:@"请输入数字或字母"
                              
                                                       delegate:nil
                              
                              
                                              cancelButtonTitle:@"确定"
                              
                                              otherButtonTitles:nil];
        
        [alert show];
        NSMutableString * str = [NSMutableString stringWithString:textField.text];
        [str  deleteCharactersInRange:NSMakeRange(range.location, textField.text.length - range.location)];
        
        textField.text = str;
        
        
        return NO;
        
    }
    
    return YES;
    
}


#pragma mark - 分支 键盘处理
//开始编辑输入框的时候，软键盘出现，执行此事件
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    if (self.keyBoardIsShow) {
        [self dealKeyBoardShow:nil];
    }else{
        
    }
    
}



-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    if ([self isMemberOfClass:[KFLoginViewController class]]) {
        
        if (((KFLoginViewController *)self).accountTextField == textField) {
            [((KFLoginViewController *)self).passwordTextField becomeFirstResponder];
            return YES;
        }else if (((KFLoginViewController *)self).passwordTextField == textField)
        {
            //    调用登录函数
            [((KFLoginViewController *)self)  LoginBtnClick:nil];
            return YES;
            
        }
        
    }
    
    return NO;
    
}


//输入框编辑完成以后，将视图恢复到原始状态
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    //    (iOSAfterSystem(7)?(self.navigationController.navigationBar.bounds.size.height):0)
    
    ((KFLoginViewController *)self).BigFixBGTopconstraint.constant = 0;
    [((KFLoginViewController *)self).view updateConstraintsIfNeeded];
    
//    self.view.frame =CGRectMake(0,self.view.frame.origin.y + self.keyBoardTotalEdgeY,self.view.frame.size.width, self.view.frame.size.height);
    
    self.keyBoardEdgeY = 0;
    self.keyBoardTotalEdgeY = 0;
}



#pragma mark - lifecircle

- (void)dealloc
{
    //NSLog(@"%@ dealloc",NSStringFromClass([self class]));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  ILSMLAlertView.h
//  MoreLikers
//
//  Created by xiekw on 13-9-9.
//  Copyright (c) 2013年 谢凯伟. All rights reserved.
//


//
// 简单用于替换 uialertview  //gyc

//
enum alertStyle{
    alert =1
};

#import <UIKit/UIKit.h>

@protocol DXAlertViewDelegate;


@interface DXAlertView : UIView{

    UIViewController * currentVC;
  __unsafe_unretained  id<DXAlertViewDelegate>delegate;//for alert
    
}

- (id)initWithTitle:(NSString *)title
        contentText:(NSString *)content
    leftButtonTitle:(NSString *)leftTitle
   rightButtonTitle:(NSString *)rigthTitle;

// this func, the alertview can disappear auto
- (void)show;

// can like alert view , leftTitle index 0 ,rightTitle index 1,ingnore the title weather nil
-(void)showStyle:(enum alertStyle)style;
@property(nonatomic,assign)id<DXAlertViewDelegate>delegate;

@property (nonatomic, copy) dispatch_block_t leftBlock;
@property (nonatomic, copy) dispatch_block_t rightBlock;
@property (nonatomic, copy) dispatch_block_t dismissBlock;

@end

@interface UIImage (colorful)

+ (UIImage *)imageWithColor:(UIColor *)color;

@end

@protocol DXAlertViewDelegate <NSObject>
@optional
// Called when a button is clicked. The view will be automatically dismissed after this call returns
//
- (void)alertView:(DXAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

@end
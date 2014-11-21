//
//  KFBaseViewController.h
//  KFSystem
//
//  Created by admin on 14-11-17.
//  Copyright (c) 2014年 gychao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KFBaseViewController : UIViewController<UITextFieldDelegate>



@property(nonatomic,assign)CGFloat keyBoardEdgeY; // 键盘单次偏移
@property(nonatomic,assign)BOOL keyBoardIsShow; // 键盘是否在屏幕上显示
@property(nonatomic,assign)CGRect keyBoardFrame; // 键盘高度
@property(nonatomic,assign)CGFloat keyBoardTotalEdgeY; // 键盘总共偏移



@end

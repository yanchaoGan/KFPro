//
//  KFChangePWViewController.h
//  KFManagerSystem
//
//  Created by admin on 14-11-20.
//  Copyright (c) 2014年 gychao. All rights reserved.
//

#import "KFBaseViewController.h"

@interface KFChangePWViewController : KFBaseViewController

@property (weak, nonatomic) IBOutlet UIView *reallyBGView;



@property (weak, nonatomic) IBOutlet UITextField *origntextfield;


@property (weak, nonatomic) IBOutlet UITextField *newtextfield;

@property (weak, nonatomic) IBOutlet UITextField *verfytextfield;




@property (weak, nonatomic) IBOutlet NSLayoutConstraint *reallyBGConstraint;





@end

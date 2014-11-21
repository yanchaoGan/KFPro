//
//  KFMainShowViewController.m
//  KFManagerSystem
//
//  Created by admin on 14-11-18.
//  Copyright (c) 2014年 gychao. All rights reserved.
//

#import "KFMainShowViewController.h"
#import "KFRiLiViewController.h"
#import "KFListViewController.h"

@interface KFMainShowViewController (){

    KFRiLiViewController * _RILI;
    
    KFListViewController * _LISTVC;
}

@end

@implementation KFMainShowViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - 生命周期执行顺序

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    //NSLog(@"this is  %@",_RILI.calendarVIewContainter);
    

}



-(void)viewWillLayoutSubviews{

    [super viewWillLayoutSubviews];
    //NSLog(@"this is  %@",_RILI.calendarVIewContainter);
   
}

-(void)viewDidLayoutSubviews{

    [super viewDidLayoutSubviews];
     //NSLog(@"this is  %@",_RILI.calendarVIewContainter);
}



-(void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    
    NSArray * sub =  self.owerVCView.subviews;
    if (sub && sub.count >0) {
        
    }else{
    
    
        _RILI = [[UIStoryboard storyboardWithName:@"MainShow" bundle:nil] instantiateViewControllerWithIdentifier:@"rili"];
        [self.owerVCView addSubview:_RILI.view];
        
        [_RILI.view invalidateIntrinsicContentSize];
        [_RILI.view setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        NSLayoutConstraint * left = [NSLayoutConstraint constraintWithItem:_RILI.view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.owerVCView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0];
        
        NSLayoutConstraint * top = [NSLayoutConstraint constraintWithItem:_RILI.view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.owerVCView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
        
        NSLayoutConstraint * tral = [NSLayoutConstraint constraintWithItem:_RILI.view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.owerVCView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0];
        NSLayoutConstraint * bottom = [NSLayoutConstraint constraintWithItem:_RILI.view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.owerVCView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
        
        [self.owerVCView addConstraints:@[left,top,tral,bottom]];
        
        
        
        
        //list
        _LISTVC = [[UIStoryboard storyboardWithName:@"MainShow" bundle:nil] instantiateViewControllerWithIdentifier:@"list"];
        
        [self.owerVCView addSubview:_LISTVC.view];
        
        [_LISTVC.view invalidateIntrinsicContentSize];
        [_LISTVC.view setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        
        NSLayoutConstraint * left1 = [NSLayoutConstraint constraintWithItem:_LISTVC.view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.owerVCView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0];
        
        NSLayoutConstraint * top1 = [NSLayoutConstraint constraintWithItem:_LISTVC.view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.owerVCView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
        
        NSLayoutConstraint * tral1 = [NSLayoutConstraint constraintWithItem:_LISTVC.view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.owerVCView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0];
        NSLayoutConstraint * bottom1 = [NSLayoutConstraint constraintWithItem:_LISTVC.view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.owerVCView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
        
        
        [self.owerVCView addConstraints:@[left1,top1,tral1,bottom1]];
        
        
        [self btnClick:self.calenderBtn];
        
        

    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





#pragma mark - 按钮点击事件
- (IBAction)btnClick:(UIButton *)sender {
    
    if (sender.selected) {
        return;
    }
    if (sender == self.calenderBtn) {
        
        sender.selected = !sender.selected;
        self.listBtn.selected = NO;
        
        _RILI.view.hidden   = NO;
        _LISTVC.view.hidden = YES;
        
    }else if (sender == self.listBtn){
    
        sender.selected = !sender.selected;
        self.calenderBtn.selected = NO;
        
        _RILI.view.hidden = YES;
        _LISTVC.view.hidden = NO;
    }
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

//
//  KFCalendarContainerView.m
//  KFManagerSystem
//
//  Created by admin on 14-11-18.
//  Copyright (c) 2014年 gychao. All rights reserved.
//

#import "KFCalendarContainerView.h"

@interface KFCalendarContainerView () <VRGCalendarViewDelegate>

@end

@implementation KFCalendarContainerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)layoutSubviews{

    [super layoutSubviews];
    NSArray * subarr = self.subviews;
    VRGCalendarView * tem = nil;
    
    if (subarr && subarr.count > 0) {
        
        tem = subarr[0];
        
        // 这里来修改canlendarview
        [tem resetWithMaxWAndHByBounds:self.bounds];
        
    }else{
        
        tem = [[VRGCalendarView alloc] initWithMaxWAndHByBounds:(CGRect){0,0,self.bounds.size.width,self.bounds.size.height}];
        tem.delegate = self.calendarDelegate;
        tem.translatesAutoresizingMaskIntoConstraints = YES;
        
        [self  addSubview:tem];
    }
}






@end

//
//  KFListTableViewCell.m
//  KFManagerSystem
//
//  Created by admin on 14-11-20.
//  Copyright (c) 2014年 gychao. All rights reserved.
//

#import "KFListTableViewCell.h"

@implementation KFListTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


+ (void)initialize
{
    if (self == [KFListTableViewCell class]) {
        [super initialize];

        if (_ReuseableArr == nil) {
            _ReuseableArr = [NSMutableArray array];
        }
    }
}


-(void)disPlayViewByDIC:(NSDictionary *)dic  andByIdentifer:(NSString *)idenifer{

        
    if ([idenifer isEqualToString:@"paiqilist"]) {
        
        if ([KFSBHelper isNotEmptyDicObj:dic]) {
         
            NSString * date1 = [dic objectForKey:@"date"];
            
            
            NSDate * date = [KFSBHelper dateFromString:date1];
            NSString * oneDay = [date dayOfWeekTypeByChinese];
            self.zhoujiLabel.text = oneDay;
            
            NSArray * arrs = [date1 componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"- "]];
            self.jihaoLabel.text = [arrs lastObject];
            self.jiyueLabel.text = [NSString stringWithFormat:@"/%@",arrs[1]];
            
            
            NSArray * info =  [dic objectForKey:@"info"];
            
            
            for (int i = 0; i < self.reuseViewBG.subviews.count; i++) {
                
                [_ReuseableArr addObject:self.reuseViewBG.subviews[i]];
            }
            [self.reuseViewBG.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            [self.reuseViewBG removeConstraints:self.reuseViewBG.constraints];
            
            
            KFReuseView * reuseView = nil;
         
            for (int j = 0; j< info.count; j++) {
                
               
                
                reuseView = [_ReuseableArr lastObject];
                [_ReuseableArr removeLastObject];
                
                if (reuseView == nil) {
                    reuseView = [[[NSBundle mainBundle] loadNibNamed:@"ReuesView" owner:nil options:nil] lastObject];
                }

                // 讲reusleview 放在背景上
                [self.reuseViewBG addSubview:reuseView];
     
                
                [reuseView setTranslatesAutoresizingMaskIntoConstraints:NO];
                

                NSLayoutConstraint * left = [NSLayoutConstraint constraintWithItem:reuseView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.reuseViewBG attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
                
                  NSLayoutConstraint * top = [NSLayoutConstraint constraintWithItem:reuseView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.reuseViewBG attribute:NSLayoutAttributeTop multiplier:1 constant:j*44];
                
                  NSLayoutConstraint * trail = [NSLayoutConstraint constraintWithItem:reuseView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.reuseViewBG attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];

                
                [self.reuseViewBG addConstraints:@[left,top,trail]];
                  
                
                [reuseView reDisplayUseData:info[j] byReuseIdentifier:@"paiqilist" isLastCell:((j== info.count -1)?YES:NO)];
                
            } 
        }
    }
}

@end

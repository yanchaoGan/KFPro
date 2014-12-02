//
//  KFReuseView.m
//  KFManagerSystem
//
//  Created by admin on 14-11-20.
//  Copyright (c) 2014年 gychao. All rights reserved.
//

#import "KFReuseView.h"

@implementation KFReuseView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    
    self.IOSX = self.appIosContraints.constant;
    self.AndroidX = self.appAndroidContraints.constant;
    
}



-(void)reDisplayUseData:(id)dataObj byReuseIdentifier:(NSString *)reuseIdentifier isLastCell:(BOOL)last{
    
    
    
    if ([reuseIdentifier isEqualToString:@"rililist"]) {
        
 
        
        
    }else if ([reuseIdentifier isEqualToString:@"paiqilist"]){
        

        
        if ([KFSBHelper isNotEmptyDicObj:dataObj]) {
            
            if (last) {
                self.sepertor.hidden = YES;
            }else{
            
                self.sepertor.hidden = NO;
            }
            
            NSDictionary * tem = (NSDictionary *)dataObj;
            
            NSString * result = [tem objectForKey:@"appicon"];
            [self.appIcon setImageWithURL:[NSURL URLWithString:result]];
            
            result = [tem objectForKey:@"appdescribe"];
            self.appDesc.text = result;
            
            result = [tem objectForKey:@"appstarttime"];
            self.appStart.text = [NSString stringWithFormat:@"【%@】",result];
            
          
            
            // gyc add 2014-12-2 根据不同计划判定颜色  // 需要服务器添加的字段
            UIColor * textcolor = [UIColor colorWithHexString:@"0x00385d"];
            result = [tem objectForKey:@"surestart"];
            if ([result isEqualToString:@"1"]) {
                
            }
            result = [tem objectForKey:@"notstart"];
            if ([result isEqualToString:@"1"]) {
                textcolor = [UIColor colorWithHexString:@"0x8197a9"];
            }
            result = [tem objectForKey:@"planstart"];
            if ([result isEqualToString:@"1"]) {
                textcolor = [UIColor colorWithHexString:@"0xa5113b"];
            }
            
            self.appDesc.textColor  = textcolor;
            self.appStart.textColor = textcolor;
            // end add

            
            
            result = [tem objectForKey:@"apptype"];
            switch ([result intValue]) {
                case 1:
                {
                    self.appTypeIos.hidden     = NO;
                    self.appTypeAndroid.hidden = YES;
                    
                    self.appIosContraints.constant = self.IOSX;
                    
                }
                    break;
                case 2:{
                    self.appTypeIos.hidden = YES;
                    self.appTypeAndroid.hidden = NO;
                    self.appAndroidContraints.constant = self.IOSX;
                    
                    
                    
                }break;
                case 3:{
                    
                    self.appTypeIos.hidden = NO;
                    self.appTypeAndroid.hidden = NO;
                    self.appAndroidContraints.constant = self.AndroidX;
                    self.appIosContraints.constant = self.IOSX;
                    
                    
                }break;
                    
                default:
                    break;
            }
            
            
            // 添加 高度的 约束
            BOOL isHave = NO;
            for (NSLayoutConstraint * tem in self.constraints) {
                if (tem.priority == 750) {
                    isHave = YES;
                    break;
                }
            }
            
            if (!isHave) {
                
                NSLayoutConstraint * height = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:44];
                height.priority = 750;
                
                [self addConstraint:height];
            }

            
        }else{
            
            
        }
        
    }
}




@end

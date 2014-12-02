//
//  KFCommonTableViewCell.m
//  KFManagerSystem
//
//  Created by admin on 14-11-19.
//  Copyright (c) 2014年 gychao. All rights reserved.
//

#import "KFCommonTableViewCell.h"


@interface KFCommonTableViewCell ()

@property(nonatomic,assign)CGFloat IOSX;
@property(nonatomic,assign)CGFloat AndroidX;

@end

@implementation KFCommonTableViewCell

// this method doesnot call by 
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
    
    self.IOSX = self.appTypeIosXAligConstraint.constant;
    self.AndroidX = self.appTypeAndroidXAlignConstraint.constant;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)prepareForReuse{
    
    [super prepareForReuse];
}



-(void)reDisplayUseData:(id)dataObj byReuseIdentifier:(NSString *)reuseIdentifier{

 
 
    if ([reuseIdentifier isEqualToString:@"rililist"]) {
     
        if ([KFSBHelper isNotEmptyDicObj:dataObj]) {
        
            NSDictionary * tem = (NSDictionary *)dataObj;
            
            NSString * result = [tem objectForKey:@"appicon"];
            [self.appIcon setImageWithURL:[NSURL URLWithString:result]];
            
            result = [tem objectForKey:@"appdescribe"];
            self.appdescrble.text = result;
            
            result = [tem objectForKey:@"appstarttime"];
            self.appStartTime.text = [NSString stringWithFormat:@"【%@】",result];
            
            
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
            
            self.appdescrble.textColor  = textcolor;
            self.appStartTime.textColor = textcolor;
            
            // end add
            
            result = [tem objectForKey:@"apptype"];
            switch ([result intValue]) {
                case 1:
                {
                    self.appTypeIos.hidden     = NO;
                    self.appTypeAndroid.hidden = YES;
                    
                    self.appTypeIosXAligConstraint.constant = self.IOSX;
                   
                }
                    break;
                case 2:{
                    self.appTypeIos.hidden = YES;
                    self.appTypeAndroid.hidden = NO;
                    self.appTypeAndroidXAlignConstraint.constant = self.IOSX;
                   
                    
                    
                }break;
                case 3:{
                    
                    self.appTypeIos.hidden = NO;
                    self.appTypeAndroid.hidden = NO;
                    self.appTypeAndroidXAlignConstraint.constant = self.AndroidX;
                    self.appTypeIosXAligConstraint.constant = self.IOSX;
                    
                
                }break;
                    
                
                default:
                    break;
            }
            
            
           
            
        }else{
        
            
        }
        
        
    }else if ([reuseIdentifier isEqualToString:@"paiqilist"]){
    
    }
}



- (void)dealloc
{
    NSLog(@"%s",__func__);
}

@end

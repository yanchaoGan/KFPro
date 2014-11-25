//
//  KFRiLiViewController.m
//  KFManagerSystem
//
//  Created by admin on 14-11-18.
//  Copyright (c) 2014年 gychao. All rights reserved.
//

#import "KFRiLiViewController.h"



@interface KFRiLiViewController ()

@end

@implementation KFRiLiViewController

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
    
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"0xb7d9eb"]];
    
    self.calendarVIewContainter.calendarDelegate = self;
    
    if ([self.riliListTable  respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.riliListTable setSeparatorInset:UIEdgeInsetsZero];
    }
    
    

    self.riliListTable.tableHeaderView = [[[NSBundle mainBundle] loadNibNamed:@"Header" owner:nil options:nil] lastObject];
    
    
    
    
    
    self.OneDayArr = [NSMutableArray arrayWithArray: @[@{@"appicon":@"http://image.baidu.com/i?ct=503316480&z=0&tn=baiduimagedetail&ipn=d&word=%E7%BE%8E%E5%A5%B3%E5%9B%BE%E7%89%87%E5%BA%93&pn=0&spn=0&di=168579042720&rn=1&ie=utf-8&oe=utf-8&cl=2&lm=-1&cs=2023996564%2C2004746460&os=1196979400%2C637688747&adpicid=0&ln=1000&fr=ala2%2Cala2&sme=0&cg=&objurl=http%3A%2F%2Fa2.att.hudong.com%2F63%2F84%2F28300542054762137180843808654.jpg&fromurl=ippr_z2C%24qAzdH3FAzdH3Fp7rtwg_z%26e3Bkwthj_z%26e3Bv54AzdH3F9m9m9dAzdH3F8_z%26e3Bip4s%3Fr61%3Dz7p7_pi74kf",@"appdescribe":@"小小魔兽一曲",@"appstarttime":@"10:00",@"apptype":@"1"},@{@"appicon":@"http://image.baidu.com/i?ct=503316480&z=0&tn=baiduimagedetail&ipn=d&word=%E7%BE%8E%E5%A5%B3%E5%9B%BE%E7%89%87%E5%BA%93&pn=0&spn=0&di=168579042720&rn=1&ie=utf-8&oe=utf-8&cl=2&lm=-1&cs=2023996564%2C2004746460&os=1196979400%2C637688747&adpicid=0&ln=1000&fr=ala2%2Cala2&sme=0&cg=&objurl=http%3A%2F%2Fa2.att.hudong.com%2F63%2F84%2F28300542054762137180843808654.jpg&fromurl=ippr_z2C%24qAzdH3FAzdH3Fp7rtwg_z%26e3Bkwthj_z%26e3Bv54AzdH3F9m9m9dAzdH3F8_z%26e3Bip4s%3Fr61%3Dz7p7_pi74kf",@"appdescribe":@"小小魔兽一曲",@"appstarttime":@"10:00",@"apptype":@"2"},@{@"appicon":@"http://image.baidu.com/i?ct=503316480&z=0&tn=baiduimagedetail&ipn=d&word=%E7%BE%8E%E5%A5%B3%E5%9B%BE%E7%89%87%E5%BA%93&pn=0&spn=0&di=168579042720&rn=1&ie=utf-8&oe=utf-8&cl=2&lm=-1&cs=2023996564%2C2004746460&os=1196979400%2C637688747&adpicid=0&ln=1000&fr=ala2%2Cala2&sme=0&cg=&objurl=http%3A%2F%2Fa2.att.hudong.com%2F63%2F84%2F28300542054762137180843808654.jpg&fromurl=ippr_z2C%24qAzdH3FAzdH3Fp7rtwg_z%26e3Bkwthj_z%26e3Bv54AzdH3F9m9m9dAzdH3F8_z%26e3Bip4s%3Fr61%3Dz7p7_pi74kf",@"appdescribe":@"小小魔兽一曲",@"appstarttime":@"10:00",@"apptype":@"3"},@{@"appicon":@"http://image.baidu.com/i?ct=503316480&z=0&tn=baiduimagedetail&ipn=d&word=%E7%BE%8E%E5%A5%B3%E5%9B%BE%E7%89%87%E5%BA%93&pn=0&spn=0&di=168579042720&rn=1&ie=utf-8&oe=utf-8&cl=2&lm=-1&cs=2023996564%2C2004746460&os=1196979400%2C637688747&adpicid=0&ln=1000&fr=ala2%2Cala2&sme=0&cg=&objurl=http%3A%2F%2Fa2.att.hudong.com%2F63%2F84%2F28300542054762137180843808654.jpg&fromurl=ippr_z2C%24qAzdH3FAzdH3Fp7rtwg_z%26e3Bkwthj_z%26e3Bv54AzdH3F9m9m9dAzdH3F8_z%26e3Bip4s%3Fr61%3Dz7p7_pi74kf",@"appdescribe":@"小小魔兽一曲",@"appstarttime":@"10:00",@"apptype":@"2"},@{@"appicon":@"http://image.baidu.com/i?ct=503316480&z=0&tn=baiduimagedetail&ipn=d&word=%E7%BE%8E%E5%A5%B3%E5%9B%BE%E7%89%87%E5%BA%93&pn=0&spn=0&di=168579042720&rn=1&ie=utf-8&oe=utf-8&cl=2&lm=-1&cs=2023996564%2C2004746460&os=1196979400%2C637688747&adpicid=0&ln=1000&fr=ala2%2Cala2&sme=0&cg=&objurl=http%3A%2F%2Fa2.att.hudong.com%2F63%2F84%2F28300542054762137180843808654.jpg&fromurl=ippr_z2C%24qAzdH3FAzdH3Fp7rtwg_z%26e3Bkwthj_z%26e3Bv54AzdH3F9m9m9dAzdH3F8_z%26e3Bip4s%3Fr61%3Dz7p7_pi74kf",@"appdescribe":@"小小魔兽一曲",@"appstarttime":@"10:00",@"apptype":@"1"}]];

}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - calendar

-(void)calendarView:(VRGCalendarView *)calendarView switchedToMonth:(int)month targetHeight:(float)targetHeight animated:(BOOL)animated{
    NSLog(@"heigh is  %f",targetHeight);
    
    // 在这里获取当月的 状态信息
    
    NSMutableDictionary * MP = [KFSBHelper getParamaByUrlType:urltypemonthsummary andOtherParamas:nil];
    
    [KFNetworkHelper postWithUrl:KServerUrl params:MP success:^(id responseObject) {
        
        [calendarView  reDisplayViewUse:responseObject];
        
    } fail:^(NSError *err){
    
        [calendarView reDisplayViewUse:nil];
        
    } andHUBString:@"loading..."];
    
}
-(void)calendarView:(VRGCalendarView *)calendarView dateSelected:(NSDate *)date{
    
    NSLog(@"%@",date);
    
    // 先将tableview 上的 日期 刷新下
    UILabel * header = (UILabel *)[self.riliListTable.tableHeaderView viewWithTag:100];
    header.text = [KFSBHelper headerStringFromDate:date];
    
    
    
    NSMutableDictionary * MP = [KFSBHelper getParamaByUrlType:urltypeonedaydetail andOtherParamas:@{@"date":date}];
    
    [KFNetworkHelper postWithUrl:KServerUrl params:MP success:^(id responseObject) {
        
        
        self.OneDayArr = responseObject;
        [self.riliListTable reloadData];
        
        
    } fail:^(NSError *error) {
        
        self.OneDayArr = nil;
        [self.riliListTable reloadData];
        
    } andHUBString:@"Loading..."];
    
    
}

#pragma mark - tableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.OneDayArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    KFCommonTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"rililist"];
    if (!cell) {
        NSArray * cells = [[NSBundle mainBundle] loadNibNamed:@"PaiQiCell" owner:nil options:nil];
        
        for (KFCommonTableViewCell * tcell in cells) {
            
            if ([tcell.reuseIdentifier  isEqualToString:@"rililist"]) {
                
                cell = tcell;
                break;
            }
        }
        
    }
    
    [cell reDisplayUseData:self.OneDayArr[indexPath.row] byReuseIdentifier:@"rililist"];
    
    return cell;
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

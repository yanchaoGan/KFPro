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
//    UILabel * header = (UILabel *)[self.riliListTable.tableHeaderView viewWithTag:100];
//    header.text = [KFSBHelper headerStringFromDate:[NSDate date]];
    

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
    
    NSDate * current = calendarView.currentMonth;
    if (DEBUG) {
        NSLog(@"日期当前选择为 %@",current);
    }
    
    NSMutableDictionary * MP = [KFSBHelper getParamaByUrlType:urltypemonthsummary andOtherParamas:@{@"date":current}];
    
    [KFNetworkHelper postWithUrl:KServerUrl params:MP success:^(id responseObject) {
        
        [calendarView  reDisplayViewUse:responseObject];
        
    } fail:^(NSError *err){
    
        [calendarView reDisplayViewUse:nil];
        
    } andHUBString:@"loading..."];
    
    
    static dispatch_once_t once;
    dispatch_once(&once,^{
    
        [self calendarView:calendarView dateSelected:[NSDate date]];
    });
    
    
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

//
//  KFListViewController.m
//  KFManagerSystem
//
//  Created by admin on 14-11-18.
//  Copyright (c) 2014年 gychao. All rights reserved.
//

#import "KFListViewController.h"

@interface KFListViewController ()

@property(nonatomic,strong)NSDate * nomalLoadDate;

// gyc add 2014-12-2 保存原始数据
@property(nonatomic,strong)NSString * maxDateDay;
@property(nonatomic,strong)NSString * minDateDay;


@end

@implementation KFListViewController

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
    

    
    
    
    // 2.集成刷新控件
    [self setupRefresh];
}

-(void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
  
    
    static  dispatch_once_t once;
    dispatch_once(&once,^{
    
        self.nomalLoadDate = [NSDate date];
        NSString * date = [KFSBHelper stringFromDate:[NSDate date]];
        
        NSString * lastrefrshtime   = @"1970-01-01 10:00:00";
        NSString * lastloadmoretime = @"1970-01-01 10:00:00";
        
        NSString *  clientshowmaxday = @"1970-01-01";
        NSString * clientshowminday = @"1970-01-01";
        
        NSMutableDictionary * MP = [KFSBHelper getParamaByUrlType:urltypeplanlist andOtherParamas:@{@"date":date,@"lastrefrshtime":lastrefrshtime,@"lastloadmoretime":lastloadmoretime,@"clientshowmaxday":clientshowmaxday,@"clientshowminday":clientshowminday,@"refreshdirection":@"normal"}];
        
        
        [KFNetworkHelper postWithUrl:KServerUrl params:MP success:^(id responseObject) {
            
            
            if ([KFSBHelper isNotEmptyArrObj:responseObject]) {
                
                if (![KFSBHelper isNotEmptyArrObj:self.ListSouceArr]) {
                   _ListSouceArr = [NSMutableArray array];
                }
                
                [self   addObjectsFromArray:responseObject];
                [self sortListTableSoureArr];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.listTable  headerEndRefreshing];
                    
                    [self tableviewReloadData];
                });
                
                
            }else{
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.listTable  headerEndRefreshing];
                    
                });
                
            }

        } fail:^(NSError *error) {
            
            
        } andHUBString:@"Loading..."];
 
        
        
    });
    
}


#pragma mark - 集成刷新控件

/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    //    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    // dateKey用于存储刷新时间，可以保证不同界面拥有不同的刷新时间
    [self.listTable addHeaderWithTarget:self action:@selector(headerRereshing) dateKey:nil];
//#warning 自动刷新(一进入程序就下拉刷新)
//    [self.tableView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.listTable addFooterWithTarget:self action:@selector(footerRereshing)];
    
    

}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    
    
    NSString  * cankaoDate = self.maxDateDay;
    if (![KFSBHelper isNotEmptyStringOfObj:cankaoDate]) {
        cankaoDate = [KFSBHelper  stringFromDate:[NSDate date]];
    }
    
    
    NSString * lastRT = [KFSBHelper fullstringFromDate: [[NSUserDefaults standardUserDefaults] objectForKey:MJRefreshHeaderTimeKey]];
    if (![KFSBHelper isNotEmptyStringOfObj:lastRT]) {
        lastRT = [KFSBHelper fullstringFromDate:self.nomalLoadDate];
    }
    
    
    NSString * lastLM = @"1970-01-01 10:00:00";
    
    NSString * CMD = self.maxDateDay; //gyc change 2014-12-2 [[self.ListSouceArr firstObject] objectForKey:@"date"];
    if (![KFSBHelper isNotEmptyStringOfObj:CMD]) {
        CMD = @"1970-01-01";
    }
    
    NSString * CminD = self.minDateDay;//gyc change 2014-12-2 [[self.ListSouceArr lastObject] objectForKey:@"date"];
    if (![KFSBHelper isNotEmptyStringOfObj:CminD]) {
        CminD = @"1970-01-01";
    }
    
    // gyc add 2014-12-2 当刷新日期超过现在 一个月就提示 返回
    if ([KFSBHelper  isAfterNowThanOneMonth:self.maxDateDay]) {
        [KFSBHelper simpleAlertTitle:nil message:@"刷新最多可查看一个月的数据" cancel:@"ok"];
        [self.listTable  headerEndRefreshing];
        return;
    }
    //
 
    
    NSString * date = cankaoDate;
    NSString * lastrefrshtime   = lastRT;
    NSString * lastloadmoretime = lastLM;
    NSString *  clientshowmaxday = CMD;
    NSString * clientshowminday =  CminD;
    
    NSMutableDictionary * MP = [KFSBHelper getParamaByUrlType:urltypeplanlist andOtherParamas:@{@"date":date,@"lastrefrshtime":lastrefrshtime,@"lastloadmoretime":lastloadmoretime,@"clientshowmaxday":clientshowmaxday,@"clientshowminday":clientshowminday,@"refreshdirection":@"refresh"}];
    
    
    [KFNetworkHelper postWithUrl:KServerUrl params:MP success:^(id responseObject) {
        
        
        if ([KFSBHelper isNotEmptyArrObj:responseObject]) {
            
            if (![KFSBHelper isNotEmptyArrObj:self.ListSouceArr]) {
                _ListSouceArr = [NSMutableArray array];
            }
            
            [self   addObjectsFromArray:responseObject];
            [self sortListTableSoureArr];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.listTable  headerEndRefreshing];
               
                [self tableviewReloadData];
            });
            
            
        }else{
        
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.listTable  headerEndRefreshing];
                
            });
            
        }
        
    } fail:^(NSError *error) {
        
        [self.listTable headerEndRefreshing];
        
    } andHUBString:@"Loading..."];
    
}
#pragma mark - 进入加载更多的状态
- (void)footerRereshing
{

    NSString  * cankaoDate =  self.minDateDay;
    if (![KFSBHelper isNotEmptyStringOfObj:cankaoDate]) {
        cankaoDate = [KFSBHelper  stringFromDate:[NSDate date]];
    }
    
    
    NSString * lastRT = @"1970-01-01 10:00:00";
    
    NSString * lastLM = [KFSBHelper fullstringFromDate: [[NSUserDefaults standardUserDefaults] objectForKey:MJLoadMoreFooterTimeKey]];
    if (![KFSBHelper isNotEmptyStringOfObj:lastLM]) {
        lastLM = [KFSBHelper fullstringFromDate:self.nomalLoadDate];
    }

    
    NSString * CMD = self.maxDateDay; //gyc change 2014-12-2 [[self.ListSouceArr firstObject] objectForKey:@"date"];
    if (![KFSBHelper isNotEmptyStringOfObj:CMD]) {
        CMD = @"1970-01-01";
    }
    
    NSString * CminD = self.minDateDay; //gyc change 2014-12-2  [[self.ListSouceArr lastObject] objectForKey:@"date"];
    if (![KFSBHelper isNotEmptyStringOfObj:CminD]) {
        CminD = @"1970-01-01";
    }
    
    
    // gyc add 2014-12-2 当刷新日期超过现在 一个月就提示 返回
    if ([KFSBHelper  isAfterNowThanOneMonth:self.minDateDay]) {
        [KFSBHelper simpleAlertTitle:nil message:@"加载最多可查看一个月的数据" cancel:@"ok"];
        [self.listTable  footerEndRefreshing];
        return;
    }
    //
       
    NSString * date = cankaoDate;
    NSString * lastrefrshtime   = lastRT;
    NSString * lastloadmoretime = lastLM;
    NSString *  clientshowmaxday = CMD;
    NSString * clientshowminday =  CminD;
    
    NSMutableDictionary * MP = [KFSBHelper getParamaByUrlType:urltypeplanlist andOtherParamas:@{@"date":date,@"lastrefrshtime":lastrefrshtime,@"lastloadmoretime":lastloadmoretime,@"clientshowmaxday":clientshowmaxday,@"clientshowminday":clientshowminday,@"refreshdirection":@"downmore"}];
    
    
    
    [KFNetworkHelper postWithUrl:KServerUrl params:MP success:^(id responseObject) {
        
        if ([KFSBHelper isNotEmptyArrObj:responseObject]) {
            
            if (![KFSBHelper isNotEmptyArrObj:self.ListSouceArr]) {
               _ListSouceArr = [NSMutableArray array];
            }
            
            [self   addObjectsFromArray:responseObject];
            [self sortListTableSoureArr];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.listTable  footerEndRefreshing];
                
                [self tableviewReloadData];
            });
            
            
        }else{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.listTable  footerEndRefreshing];
                
            });
            
        }
        
    } fail:^(NSError *error) {
        
        [self.listTable footerEndRefreshing];
        
    } andHUBString:@"Loading..."];

}


-(void)sortListTableSoureArr{
    
    __block  NSString * o1 , *o2;
    NSArray * sortarr = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO comparator:^NSComparisonResult(id obj1, id obj2) {
        
         o1 = obj1;
         o2 = obj2;
        
      NSComparisonResult result =  [o1 compare:o2 options:NSNumericSearch];
        
        if (result == NSOrderedSame) {
            return NSOrderedSame;
        }else if (result == NSOrderedAscending){
        
            return NSOrderedAscending;
            
        }else if (result == NSOrderedDescending){
        
            return NSOrderedDescending
            ;
        }
        
        return NSOrderedSame;
        
    }]];
    
  self.ListSouceArr = [NSMutableArray arrayWithArray:[self.ListSouceArr  sortedArrayUsingDescriptors:sortarr]];
    
}

#pragma mark - 控制cell 行数 限制, 始终删除 最后的 多的行数
#define  KMAXCELLNUM 500

-(void)setListSouceArr:(NSMutableArray *)ListSouceArr{

    if (ListSouceArr.count > KMAXCELLNUM) {
        [ListSouceArr removeObjectsInRange:NSMakeRange(KMAXCELLNUM, ListSouceArr.count - KMAXCELLNUM)];
    }
    
    
    // gyc add 2014-12-2 在这里记录下 最大最小时间
    if (!self.maxDateDay) {
        self.maxDateDay = @"1970-11-11";
    }
    NSString * maxDay = [[ListSouceArr firstObject] objectForKey:@"date"];
    int early = [maxDay isEarlyThanOtherDateString:self.maxDateDay];
    if (early == 0) {
    }else if (early == 1){
    }else{
        self.maxDateDay = maxDay;
    }
    
    
    if (!self.minDateDay) {
        self.minDateDay = @"1970-01-01";
    }
    static dispatch_once_t once;
    dispatch_once(&once,^{
        self.minDateDay = [[ListSouceArr lastObject] objectForKey:@"date"];
    });
    
    NSString * minday = [[ListSouceArr lastObject] objectForKey:@"date"];
    int early1 = [minday isEarlyThanOtherDateString:self.minDateDay];
    if (early1 == 0) {
    }else if (early1 == 1){
        self.minDateDay = minday;
    }else{
    }

   
    //end add
    
    // 2014-12-2 gyc add 将字典中的 所有删除状态的 appdelete 为 "1" 的 全部去除掉,
    NSDictionary * result;
    NSMutableArray * info;
    NSMutableDictionary * appInfo;
    
    for (int i = 0; i < ListSouceArr.count;) {
        result = ListSouceArr[i];
        info = result[@"info"];
       
        if ([KFSBHelper isNotEmptyArrObj:info]) {
            
            BOOL allDelete = YES;
            
            for (int j = 0 ; j< info.count; ) {
                appInfo = info[j];
                if ([appInfo[@"appdelete"] isEqualToString:@"0"]) {
                    allDelete = NO;
                    j++;
                }else{
                    
                    [info removeObject:appInfo];
                }
            }
            
            
            
            if (allDelete) {
                [ListSouceArr removeObject:result];
                
            }else{
                
                i++;
            }

        }
        else{
        
            
            [ListSouceArr removeObject:result];
        }
        
    }
    // end add
    _ListSouceArr = ListSouceArr;
}


#pragma mark - 为了刷新而添加
-(void)tableviewReloadData{

    [self.listTable  reloadData];
    
    
    static dispatch_once_t once;
    dispatch_once(&once,^{
    
        int row = [self.listTable numberOfRowsInSection:0];
        if (row) {
            NSIndexPath * index  = [NSIndexPath indexPathForRow:ceil(row/2) inSection:0];
            [self.listTable  scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        }
    });
    
    
}
-(void)addObjectsFromArray:(NSMutableArray *)arr{

    // 将 listtableview 中的数据 和 arr 中重复的 删除掉
    NSDictionary * resultSource;
    NSString * dateS;
    NSString * dateD;
    for (int i = 0; i < self.ListSouceArr.count; ) {
        resultSource = self.ListSouceArr[i];
        dateS = resultSource[@"date"];
        
        BOOL haveSame = NO;
        for (NSDictionary * resulstD in arr) {
            dateD = resulstD[@"date"];
            if ([dateS isEqualToString:dateD]) {
                haveSame = YES;
                break;
            }
        }
        if (haveSame) {
            [self.ListSouceArr removeObject:resultSource];
        }else{
        
            i++;
        }
  
    }
    
    [self.ListSouceArr  addObjectsFromArray:arr];
}

#pragma mark - TableView

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{


    return self.ListSouceArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    KFListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"paiqilist"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"KFListTableViewCell" owner:nil options:nil] lastObject];
    }
    
    [cell  disPlayViewByDIC:self.ListSouceArr[indexPath.row] andByIdentifer:@"paiqilist"];
    
    return cell;
}


#define  ROWMINH 88
#define  ONEROWH 44
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSDictionary * indexDic = self.ListSouceArr[indexPath.row];
    
    NSArray * info = indexDic[@"info"];
    
    int num = info.count;
    
    if (num <= 2) {
        
        return ROWMINH + 6;
    }else{
    
        return ONEROWH * num + 6;
    }
   
    return 0;
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

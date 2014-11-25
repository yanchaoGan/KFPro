//
//  KFListViewController.m
//  KFManagerSystem
//
//  Created by admin on 14-11-18.
//  Copyright (c) 2014年 gychao. All rights reserved.
//

#import "KFListViewController.h"

@interface KFListViewController ()

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
    

    self.ListSouceArr =[NSMutableArray arrayWithArray: @[@{@"date":@"2014-11-20",@"info":@[@{@"appicon": @"www.baidu.com",@"appdescribe":@"appdescribe",@"appstarttime":@"10:55",@"apptype":@"1"}]},
  
        
    
       @{@"date":@"2014-11-20",@"info":@[@{@"appicon": @"www.baidu.com",@"appdescribe":@"appdescribe",@"appstarttime":@"10:55",@"apptype":@"2"}]},
                                                         
      
  
  @{@"date":@"2014-11-20",@"info":@[@{@"appicon": @"www.baidu.com",@"appdescribe":@"appdescribe",@"appstarttime":@"10:55",@"apptype":@"3"},@{@"appicon": @"www.baidu.com",@"appdescribe":@"appdescribe",@"appstarttime":@"10:55",@"apptype":@"3"},@{@"appicon": @"www.baidu.com",@"appdescribe":@"appdescribe",@"appstarttime":@"10:55",@"apptype":@"3"},@{@"appicon": @"www.baidu.com",@"appdescribe":@"appdescribe",@"appstarttime":@"10:55",@"apptype":@"3"},@{@"appicon": @"www.baidu.com",@"appdescribe":@"appdescribe",@"appstarttime":@"10:55",@"apptype":@"3"}]}
                                                         ]
         
                        
                        ];
    
    
    // 2.集成刷新控件
    [self setupRefresh];
}

/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    //    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    // dateKey用于存储刷新时间，可以保证不同界面拥有不同的刷新时间
    [self.listTable addHeaderWithTarget:self action:@selector(headerRereshing) dateKey:@"table"];
//#warning 自动刷新(一进入程序就下拉刷新)
//    [self.tableView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.listTable addFooterWithTarget:self action:@selector(footerRereshing)];
    
    

}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    
//    // 1.添加假数据
//    for (int i = 0; i<5; i++) {
//        [self.fakeData insertObject:MJRandomData atIndex:0];
//    }
//    
//    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        // 刷新表格
//        [self.tableView reloadData];
//        
//        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
//        [self.tableView headerEndRefreshing];
//    });
}
#pragma mark - 进入加载更多的状态
- (void)footerRereshing
{
//    // 1.添加假数据
//    for (int i = 0; i<5; i++) {
//        [self.fakeData addObject:MJRandomData];
//    }
//    
//    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        // 刷新表格
//        [self.tableView reloadData];
//        
//        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
//        [self.tableView footerEndRefreshing];
//    });
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

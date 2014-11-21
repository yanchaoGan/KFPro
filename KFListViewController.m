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

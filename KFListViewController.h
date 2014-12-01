//
//  KFListViewController.h
//  KFManagerSystem
//
//  Created by admin on 14-11-18.
//  Copyright (c) 2014年 gychao. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  排期列表
 */

@interface KFListViewController : KFBaseViewController <UITableViewDataSource,UITableViewDelegate>


@property(nonatomic,strong)NSMutableArray * ListSouceArr;

@property (weak, nonatomic) IBOutlet UITableView *listTable;


@end

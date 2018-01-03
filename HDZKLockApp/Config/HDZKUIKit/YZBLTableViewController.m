//
//  TLTableViewController.m
//  TLChat
//
//  Created by lq on 16/1/23.
//  Copyright © 2016年 lq. All rights reserved.
//

#import "YZBLTableViewController.h"


@interface YZBLTableViewController()
@property (nonatomic, readonly) UITableViewStyle style;

@end

@implementation YZBLTableViewController


#pragma mark - Getter
- (NSString *)analyzeTitle
{
    if (_analyzeTitle == nil) {
        return self.navigationItem.title;
    }
    return _analyzeTitle;
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super init];
    if (self) {
        _style = style;
    }
    
    return self;
}

#pragma mark - life cycle

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    //去掉cell分割线
    // [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
}


- (void) viewDidLoad{
    [super viewDidLoad];
    /*
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout =  UIRectEdgeNone;
    }
    */
    self.view.backgroundColor = [UIColor whiteColor];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:self.style];
    /*
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [_tableView setBackgroundColor:HZOverallBackGroundColor];
    */
    [_tableView setTableFooterView:[UIView new]];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];//分割线顶边
        [self.tableView setSeparatorColor:HZDividerTextColor];//分割线颜色
    }
    

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(backItemEvent:)];
    [self.navigationItem.leftBarButtonItem setImage:[[UIImage imageNamed:@"currency_top_icon_back_gray"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    self.navigationController.navigationBar.tintColor = HZSecondaryTextColor;
    
}

#pragma mark - method

- (void)backItemEvent:(UIBarButtonItem *)sender{
    
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return CELLDEFAULTHEIGHT;//默认高度
}


- (void)dealloc{
#ifdef DEBUG_MEMERY
    NSLog(@"dealloc %@", self.navigationItem.title);
#endif
}


@end

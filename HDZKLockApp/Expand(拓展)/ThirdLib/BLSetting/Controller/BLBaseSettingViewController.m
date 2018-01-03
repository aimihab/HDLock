//
//  BLBaseSettingViewController.m
//  BLSetting
//
//  Created by lq on 15/9/19.
//  Copyright (c) 2015 lq. All rights reserved.
//

#import "BLBaseSettingViewController.h"
#import "BLSettingCell.h"

@interface BLBaseSettingViewController ()

@end

@implementation BLBaseSettingViewController

- (void)loadView
{
    _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
 
    self.view = _tableView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _allGroups = [NSMutableArray array];
    
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return _allGroups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    BLSettingGroup *group = _allGroups[section];
    return group.items.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 55.0f;
}



#pragma mark 每当有一个cell进入视野范围内就会调用，返回当前这行显示的cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.创建一个BLSettingCell
    BLSettingCell *cell = [BLSettingCell settingCellWithTableView:tableView];
    
    // 2.取出这行对应的模型（BLSettingItem）
    BLSettingGroup *group = _allGroups[indexPath.section];
    cell.item = group.items[indexPath.row];
    __block BLSettingCell *weakCell = cell;
    cell.switchChangeBlock = ^ (BOOL on){
        if (weakCell.item.switchBlock) {
            weakCell.item.switchBlock(on);
        }
    };
    
    cell.buttonSelectedBlock = ^(BOOL selected){
    
        if (weakCell.item.buttonBlock) {
            weakCell.item.buttonBlock(selected);
        }
    
    };
    
    cell.buttonPullDownBlock = ^(BOOL selected){
        
        if (weakCell.item.buttonBlock) {
            weakCell.item.buttonBlock(selected);
        }
    
    };

    return cell;
}

#pragma mark 点击了cell后的操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 0.取出这行对应的模型
    BLSettingGroup *group = _allGroups[indexPath.section];
    BLSettingItem *item = group.items[indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // 1.取出这行对应模型中的block代码
    if (item.operation) {
        // 执行block
        item.operation();
    }
}

#pragma mark 返回每一组的header标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    BLSettingGroup *group = _allGroups[section];
    
    return group.header;
}
#pragma mark 返回每一组的footer标题
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    BLSettingGroup *group = _allGroups[section];
    
    return group.footer;
}

@end

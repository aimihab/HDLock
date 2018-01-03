//
//  HDZKEmptyTableViewController.m
//  HDZKLockApp
//
//  Created by lq on 2017/12/19.
//  Copyright © 2017年 yzkj-lq. All rights reserved.
//

#import "HDZKEmptyTableViewController.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

@interface HDZKEmptyTableViewController ()<DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@end

@implementation HDZKEmptyTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    self.view.backgroundColor = HZOverallBackGroundColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Delegate
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    [attributes setObject:[UIFont boldSystemFontOfSize:17.0] forKey:NSFontAttributeName];
    [attributes setObject:YZBL_COLOR_C3 forKey:NSForegroundColorAttributeName];
    
    NSString *text = NSLocalizedString(@"暂无数据",nil);
    switch (_type) {
        case HDZKEmptyTypeOpenRecords:
        {
            text = NSLocalizedString(@"没有开锁记录",nil);
        }
            break;
        case HDZKEmptyTypeNoticeList:
        {
            text = NSLocalizedString(@"没有新的消息",nil);
        }
            break;
        case HDZKEmptyTypeBridalParty:
        {
            text = NSLocalizedString(@"未添加任何亲友",nil);
        }
            break;
        case HDZKEmptyTypeKeychain:
        {
            text = NSLocalizedString(@"还没有授权钥匙",nil);
        }
            break;
            
        default:
            break;
    }
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    if (IS_IPHONE_P) {
        return -100;
    }else
    {
        return -60;
    }
    
}

- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView
{
    return 0;
}
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    UIImage *image = [UIImage imageNamed:@"currency_blankpage_icon2"];
    switch (_type) {
        case HDZKEmptyTypeOpenRecords:
        {
            image = [UIImage imageNamed:@"currency_blankpage_icon4"];
        }
            break;
        case HDZKEmptyTypeNoticeList:
        {
            image = [UIImage imageNamed:@"currency_blankpage_icon3"];
        }
            break;
        case HDZKEmptyTypeBridalParty:
        {
            image = [UIImage imageNamed:@"currency_blankpage_icon6"];
        }
            break;
        case HDZKEmptyTypeKeychain:
        {
            image = [UIImage imageNamed:@"currency_blankpage_icon1"];
        }
            break;
        default:
            break;
    }
    return image;
}

@end

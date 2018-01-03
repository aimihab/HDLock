//
//  HDZKAuthorUserDetailViewController.m
//  HDZKLockApp
//
//  Created by lq on 2017/12/23.
//  Copyright © 2017年 yzkj-lq. All rights reserved.
//

#import "HDZKAuthorUserDetailViewController.h"

#import "JKCountDownButton.h"

@interface HDZKAuthorUserDetailViewController ()

@property (nonatomic , strong) JKCountDownButton *authorButton;

@end

@implementation HDZKAuthorUserDetailViewController

#pragma mark - getter

- (JKCountDownButton *)authorButton{
    
    if (_authorButton == nil) {
        
        _authorButton = [JKCountDownButton buttonWithType:UIButtonTypeCustom];
        _authorButton.backgroundColor = [UIColor whiteColor];
        _authorButton.frame = CGRectMake(20, self.view.height-70, kScreenW-40, 40);
        _authorButton.clipsToBounds = YES;
        _authorButton.layer.cornerRadius = _authorButton.height/2;
        _authorButton.layer.borderWidth = 1.0f;
        _authorButton.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
        [_authorButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_authorButton setTitle:NSLocalizedString(@"授权用户", nil) forState:UIControlStateNormal];
        [_authorButton addTarget:self action:@selector(authorEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_authorButton];
        [self.view bringSubviewToFront:_authorButton];
    }
    
    return _authorButton;
}



#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"授权用户信息", nil);
    self.tableView.backgroundColor = HZOverallBackGroundColor;
    self.tableView.rowHeight = 80.0f;
    
    self.tableView.sectionHeaderHeight = 15.0f;
    self.tableView.tableFooterView = [UIView new];
    
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return [UIView new];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (indexPath.section == 0) {//用户头像
        cell.textLabel.text = NSLocalizedString(@"用户头像", nil);
        UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenW-65, 15, 50, 50)];
        [cell.contentView addSubview:iconView];
        iconView.image = [UIImage imageNamed:@"icon_morentouxian"];
    }else{//用户名称
        
        cell.textLabel.text = @"用户名称";
        cell.detailTextLabel.text = @"哈哈哈";
    }
    
    return cell;
}


#pragma mark - action

- (void)authorEvent:(JKCountDownButton *)sender{
    
    DLog(@"授权....");
    sender.enabled = NO;
    [sender startCountDownWithSecond:60];
    [sender countDownChanging:^NSString *(JKCountDownButton *countDownButton, NSUInteger second) {
        
        NSString *title = [NSString stringWithFormat:@"等待对方回应授权%zd秒",second];
        return title;
    }];
    
    [sender countDownFinished:^NSString *(JKCountDownButton *countDownButton, NSUInteger second) {
        countDownButton.enabled = YES;
        return NSLocalizedString(@"授权", nil);
    }];
    
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/




@end

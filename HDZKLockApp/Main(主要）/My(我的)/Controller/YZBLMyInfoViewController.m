//
//  YZBLMyInfoViewController.m
//  BLChat
//
//  Created by baoyx on 2017/6/10.
//
//

#import "YZBLMyInfoViewController.h"
#import "YZBLMyQrCodeViewController.h"
#import "YZBLNickNameViewController.h"

#import "YZBLPHeadCell.h"
#import "YZBLImagePicker.h"
#import "SDImageCache.h"
#import "HDZKUserService.h"
#import "UIImage+YZBL.h"

#import "YZBLGenderView.h"

@interface YZBLMyInfoViewController ()<UIActionSheetDelegate>
@property (nonatomic,copy) YZBLGenderView *genderView;
@property (strong, nonatomic) YZBLImagePicker *picker;
@end

@implementation YZBLMyInfoViewController
{
    NSArray *title1_;
    NSArray *title2_;
}

#pragma mark - getter
-(YZBLGenderView *)genderView
{
    if (_genderView == nil) {
        YZWeakSelf(weakSelf,self);
        _genderView = [[YZBLGenderView alloc] init];
        [_genderView setGenderCancelEvent:^{
            YZStrongSelf(strongSelf, weakSelf);
            strongSelf.genderView = nil;
        }];
        [_genderView setGenderEvent:^(YZGenderType genderType){
            YZStrongSelf(strongSelf, weakSelf);
            strongSelf.genderView = nil;
            
            // strongSelf.userModel.u_sex = genderType;
            
            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:1 inSection:1];
            //刷新对应cell
            [strongSelf.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        }];
        [[UIApplication sharedApplication].keyWindow addSubview:_genderView];
    }
    return _genderView;
}


-(YZBLImagePicker *)picker
{
    if (!_picker) {
        _picker = [YZBLImagePicker new];
        _picker.size = CGSizeMake(400, 400);
        _picker.enableEditing = YES;
        _picker.superVc = self;
        YZWeakSelf(weakSelf,self);
        [_picker setResult:^(BOOL canceled, UIImage *img) {
            if (!canceled) {
                YZStrongSelf(strongSelf, weakSelf);
                NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
                YZBLPHeadCell *cell = [strongSelf.tableView cellForRowAtIndexPath:indexPath];
                [cell refrshImage:[UIImage imageNamed:@"icon_morentouxian"]];
                
                [MBProgressHUD showActivityMessageInView:@"正在上传头像"];
                NSData *data = [UIImage compressImage:img];
                
                [strongSelf.userModel updateHeadData:data suffix:@"png" success:^(NSString *fileUrl) {
                    [MBProgressHUD hideHUD];
                    [[SDImageCache sharedImageCache] removeImageForKey:strongSelf.userModel.u_head_url withCompletion:nil];
                   // strongSelf.userModel.u_head_url = [NSString stringWithFormat:@"%@?%@",fileUrl,@([[NSDate date] timeIntervalSince1970])];
                    strongSelf.userModel.u_head_url = fileUrl;
                    [strongSelf.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                } failure:^(YZUserError *error) {
                    [MBProgressHUD hideHUD];
                    [MBProgressHUD showErrorMessage:NSLocalizedString(@"上传头像失败!", nil)];
                    [cell refrshModel:strongSelf.userModel];
                }];
            }
        }];
    }
    return _picker;
}


#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];

    self.title = NSLocalizedString(@"我的资料", nil);
    title1_ = @[@"我的头像"];
    title2_ = @[@"我的昵称",@"我的二维码",@"绑定号码"];
    self.tableView.sectionHeaderHeight = 30.0f;
}


- (void)willMoveToParentViewController:(UIViewController*)parent{
    [super didMoveToParentViewController:parent];
    if(!parent){
        [HDZKUserService editUserWithModel:_userModel success:nil failure:nil];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return title1_.count;
    }else
    {
        return title2_.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 70;
    }else{
        return 60;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 30.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        NSString *title = title1_[indexPath.row];
        YZBLPHeadCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"YZBLPHeadCell" owner:self options:nil] firstObject];
        cell.textLabel.text = title;
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        cell.textLabel.textColor = HZImportantTextColor;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cell refrshModel:_userModel];
        return cell;
    }else
    {
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        }
         NSString *title = title2_[indexPath.row];
        cell.textLabel.text = title;
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        cell.textLabel.textColor = HZImportantTextColor;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (indexPath.section == 1) {
            switch (indexPath.row) {
                case 0://昵称
                {
                    cell.detailTextLabel.text = _userModel.u_nick_name;
                }
                    break;
                case 1://二维码
                {
                   
                }
                    break;
                case 2://绑定号码
                {
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    cell.detailTextLabel.text = _userModel.bind_phone;
                }
                    break;
                    
                default:
                    break;
            }
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    // 设置section背景颜色
    view.tintColor = [UIColor groupTableViewBackgroundColor];
    
    /*设置section字体颜色
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header.textLabel setTextColor:[UIColor lightGrayColor]];
    */
}


/*
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UITableViewCell *cell =  [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"head"];
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        cell.textLabel.textColor = HZSecondaryTextColor;
        cell.backgroundColor = HZOverallBackGroundColor;
        cell.textLabel.text = NSLocalizedString(@"基本信息",nil);
        return cell;
    }else
    {
        return nil;
    }
}
*/



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:NSLocalizedString(@"取消",nil) destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"拍照",nil), NSLocalizedString(@"手机相册",nil), nil];
        [sheet showInView:self.view];
    }else{
        switch (indexPath.row) {
            case 0:
            {
                YZBLNickNameViewController *vc = [[YZBLNickNameViewController alloc] initWithType:ModifyTypeMine];
                vc.nickName = _userModel.u_nick_name;
                YZWeakSelf(weakSelf,self);
                [vc setGainNickName:^(NSString *nickName){
                    YZStrongSelf(strongSelf, weakSelf);
                    strongSelf.userModel.u_nick_name = nickName;
                    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:1];
                    //刷新对应cell
                    [strongSelf.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                }];
                [self.navigationController pushViewController:vc animated:NO];
                
            }
                break;
            case 1:
            {
                YZBLMyQrCodeViewController *myQRCodeVC = [[YZBLMyQrCodeViewController alloc] init];
                [self.navigationController pushViewController:myQRCodeVC animated:YES];
            }
                break;
            case 2:
            {
 
                
            }
                break;
                
            default:
                break;
        }
    }
}


#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex NS_DEPRECATED_IOS(2_0, 8_3) __TVOS_PROHIBITED {
    if(buttonIndex == 1){
        [self.picker chooseFromLibrary];
    }else if(buttonIndex == 0){
        [self.picker chooseFromCamera];
    }
}





@end

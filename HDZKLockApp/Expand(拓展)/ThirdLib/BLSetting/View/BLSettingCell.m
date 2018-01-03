//
//  BLSettingself.m
//  BLSetting
//
//  Created by lq on 15/9/19.
//  Copyright (c) 2015 lq. All rights reserved.
//

#import "BLSettingCell.h"
#import "BLSettingItem.h"


@interface BLSettingCell()
{
    UISwitch *_switch;
    UIButton *_selectedBtn;
    
    UIButton *_pullDownBtn;
}
@end

@implementation BLSettingCell


#pragma mark - getter


#pragma mark - 初始化
+ (id)settingCellWithTableView:(UITableView *)tableView
{
    
    // 0.用static修饰的局部变量，只会初始化一次
    static NSString *ID = @"Cell";
    // 1.拿到一个标识先去缓存池中查找对应的Cell
    BLSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 2.如果缓存池中没有，才需要传入一个标识创建新的Cell
    if (cell == nil) {
        cell = [[BLSettingCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}


#pragma mark - setUI && loadData

- (void)setItem:(BLSettingItem *)item
{
    _item = item;
    
    // 设置数据
    self.imageView.image = [UIImage imageNamed:item.icon];
    self.textLabel.text = item.title;
    self.detailTextLabel.text = item.detailText;
    
    if (item.type == BLSettingItemTypeArrow) {
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        // 用默认的选中样式
        self.selectionStyle = UITableViewCellSelectionStyleBlue;
        
    } else if (item.type == BLSettingItemTypeSwitch) {
        
        //cell禁止选中样式
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        if (_switch == nil) {
            _switch = [[UISwitch alloc] init];
            [_switch addTarget:self action:@selector(switchStatusChanged:) forControlEvents:UIControlEventValueChanged];
        }
        
        // 右边显示开关
        self.accessoryView = _switch;
        if ([item.icon isEqualToString:@"禁用开关"]) {
            _switch.enabled = NO;
        }
        if (item.isSwitchOn) {
            [_switch setOn:YES];
        }else{
            [_switch setOn:NO];
        }
        
    } else if(item.type == BLSettingItemTypeSelect){
    
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (_selectedBtn == nil) {
            _selectedBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 45, 45)];
            [self.contentView addSubview:_selectedBtn];
//            [_selectedBtn setImage:[UIImage imageNamed:@"btn_duoxuan_n"] forState:UIControlStateNormal];
//            [_selectedBtn setImage:[UIImage imageNamed:@"btn_duoxuan_s"] forState:UIControlStateSelected];
            [_selectedBtn addTarget:self action:@selector(selectedEvent:) forControlEvents:UIControlEventTouchUpInside];
        }
        if (item.isCellSelected ) {
            _selectedBtn.selected = YES;
             self.imageView.image = [UIImage imageNamed:@"btn_duoxuan_s"];
        }else{
            _selectedBtn.selected = NO;
            self.imageView.image = [UIImage imageNamed:@"btn_duoxuan_n"];
        }
        
    
    }else if(item.type == BLSettingItemTypePullDown){
    
        DLog(@"cell  高度 is 　%f",self.height);
        
        if (_pullDownBtn == nil) {
            
            _pullDownBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            _pullDownBtn.frame = CGRectMake(kScreenW-60, 0, 60, 60);
            [_pullDownBtn setImage:[UIImage imageNamed:@"icon_arrow_down"] forState:UIControlStateNormal];
            [_pullDownBtn setImage:[UIImage imageNamed:@"icon_arrow_up"] forState:UIControlStateSelected];
            
            [_pullDownBtn addTarget:self action:@selector(pullDownEvent:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:_pullDownBtn];
          //  self.accessoryView = _pullDownBtn;
            
            item.operation = ^{
                if (_pullDownBtn.selected) {
                    _pullDownBtn.selected = NO;
                    
                }else{
                    _pullDownBtn.selected = YES;
                }
                
                if (self.buttonPullDownBlock) {
                    self.buttonPullDownBlock(_pullDownBtn.selected);
                }
                
            };
        }
        
        
    }else{
        
        // 什么也没有，清空右边显示的view
        self.accessoryView = nil;
        // 用默认的选中样式
        self.selectionStyle = UITableViewCellSelectionStyleBlue;
        
    }
}

#pragma mark - action


/**
  开关事件

 @param sender 开关
 */
- (void)switchStatusChanged:(UISwitch *)sender
{
    if (self.switchChangeBlock) {
        
        
        self.switchChangeBlock(sender.on);
    }
}


/**
 选中按钮事件

 @param sender 按钮
 */
- (void)selectedEvent:(UIButton *)sender{

    sender.selected = !sender.selected;
    if (sender.selected) {
        
        self.imageView.image = [UIImage imageNamed:@"btn_duoxuan_s"];
    }else{
    
        self.imageView.image = [UIImage imageNamed:@"btn_duoxuan_n"];
    }
    
    //事件回调
    if (self.buttonSelectedBlock) {
        
        self.buttonSelectedBlock(sender.selected);
    }

    _item.isCellSelected = sender.selected;
}


/** 
 下拉按钮事件

 @param sender 按钮
 */
- (void)pullDownEvent:(UIButton *)sender{

    sender.selected = !sender.selected;
    
    if (self.buttonPullDownBlock) {
        self.buttonPullDownBlock(sender.selected);
    }
    

}



@end

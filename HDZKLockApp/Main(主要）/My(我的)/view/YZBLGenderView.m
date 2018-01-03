//
//  YZBLGenderView.m
//  BLChat
//
//  Created by baoyx on 2017/6/10.
//
//

#import "YZBLGenderView.h"

@interface YZBLGenderView()
@property (nonatomic,copy) UIButton *manBtn;
@property (nonatomic,copy) UIButton *womanBtn;
@property (nonatomic,copy) UIButton *cancelBtn;
@property (nonatomic,copy) UIView *backView;
@end

@implementation YZBLGenderView
-(instancetype)init
{
    if (self = [super initWithFrame:CGRectMake(0,0,kScreenW,kScreenH)]) {
        [self p_initUI];
    }
    return self;
}

-(void)p_initUI
{
    self.backgroundColor = KRGBACOLOR(0, 0, 0, 0.5);
    _cancelBtn = self.cancelBtn;
    _backView = self.backView;
    _manBtn = self.manBtn;
    _womanBtn = self.womanBtn;
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissEvent:)];
    [self addGestureRecognizer:tap];
}


- (void)dismissEvent:(UITapGestureRecognizer *)sender{
    
    [self removeFromSuperview];
    if (_genderCancelEvent) {
        _genderCancelEvent();
    }

}


-(UIButton *)cancelBtn
{
    if (_cancelBtn == nil) {
        _cancelBtn = [UIButton  buttonWithType:UIButtonTypeCustom];
        _cancelBtn.x = (kScreenW - 300)/2.0;
        _cancelBtn.y = kScreenH - 30 - 50;
        _cancelBtn.width = 300;
        _cancelBtn.height = 50;
        _cancelBtn.layer.cornerRadius = 10.0;
        _cancelBtn.layer.masksToBounds = YES;
        [_cancelBtn setTitle:NSLocalizedString(@"取消",nil) forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:KRGBACOLOR(0x99, 0x99, 0x99,1.0) forState:UIControlStateNormal];
        _cancelBtn.backgroundColor = [UIColor whiteColor];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_cancelBtn addTarget:self action:@selector(cancelEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_cancelBtn];
    }
    return _cancelBtn;
}

-(UIView *)backView
{
    if (_backView == nil) {
        CGFloat x = (kScreenW - 300)/2.0;
        CGFloat y = _cancelBtn.y - 101 - 10;
        _backView = [[UIView alloc] initWithFrame:CGRectMake(x,y,300, 100)];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.cornerRadius = 10.0;
        _backView.layer.masksToBounds = YES;
        [self addSubview:_backView];
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(30,51.25,240,0.5)];
        view.backgroundColor = KRGBACOLOR(0, 0, 0, 0.2);
        [_backView addSubview:view];
    }
    return _backView;
}
-(UIButton *)manBtn
{
    if (_manBtn == nil) {
        _manBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _manBtn.frame = CGRectMake(0,0,300,50);
        [_manBtn setTitle:NSLocalizedString(@"男",nil) forState:UIControlStateNormal];
        [_manBtn setTitleColor:KRGBACOLOR(0x37, 0x9C, 0xD9,1.0) forState:UIControlStateNormal];
        _manBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_manBtn addTarget:self action:@selector(manEvent:) forControlEvents:UIControlEventTouchUpInside];
        [_backView addSubview:_manBtn];
    }
    return _manBtn;
}

-(UIButton *)womanBtn
{
    if (_womanBtn == nil) {
        _womanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _womanBtn.frame = CGRectMake(0,52,300,50);
        [_womanBtn setTitle:NSLocalizedString(@"女",nil) forState:UIControlStateNormal];
        [_womanBtn setTitleColor:KRGBACOLOR(0xF9, 0x7B, 0x7F,1.0) forState:UIControlStateNormal];
        _womanBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_womanBtn addTarget:self action:@selector(womanEvent:) forControlEvents:UIControlEventTouchUpInside];
        [_backView addSubview:_womanBtn];
    }
    return _womanBtn;
}


-(void)manEvent:(UIButton *)btn
{
    [self removeFromSuperview];
    if (_genderEvent) {
        _genderEvent(YZGenderTypeMan);
    }
    
}

-(void)womanEvent:(UIButton *)btn
{
    [self removeFromSuperview];
    if (_genderEvent) {
        _genderEvent(YZGenderTypeWoman);
    }
}

-(void)cancelEvent:(UIButton *)btn
{
    [self removeFromSuperview];
    if (_genderCancelEvent) {
        _genderCancelEvent();
    }
}

@end

//
//  JasonActionSheetView.m
//  JasonActionSheet
//
//  Created by JasonHao on 2017/7/14.
//  Copyright © 2017年 JasonHao. All rights reserved.
//

#import "JasonActionSheetView.h"

@implementation JasonActionSheetView

-(instancetype)initWithHeadView:(UIView *)headView cellArray:(NSArray *)cellArray cancelTitle:(NSString *)cancelTitle selectedBlock:(void (^)(NSInteger))selectedBlock cancelBlock:(void (^)())cancelBlock
{
    self = [super init];
    if (self) {
        _headView = headView;
        _cellArray = cellArray;
        _cancelTitle = cancelTitle;
        _selectedBlock = selectedBlock;
        _cancelBlock = cancelBlock;
        
        //创建UI视图
        [self createUI];
    }
    return self;
}
#pragma mark ------ 创建UI视图
- (void)createUI {
    self.frame = [UIScreen mainScreen].bounds;
    //背景
    [self addSubview:self.maskView];
    //表格
    [self addSubview:self.tableView];
}
//背景
- (UIView*)maskView {
    if (!_maskView) {
        _maskView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _maskView.backgroundColor = [UIColor blackColor];
        _maskView.alpha = 0.5;
        _maskView.userInteractionEnabled = YES;
    }
    return _maskView;
}
//表格
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.layer.cornerRadius = 10;
        _tableView.clipsToBounds = YES;
        _tableView.rowHeight = 44.0;
        _tableView.bounces = NO;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.tableHeaderView = self.headView;
        _tableView.separatorInset = UIEdgeInsetsMake(0, -50, 0, 0);
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"OneCell"];
    }
    return _tableView;
}
#pragma mark <UITableViewDelegate,UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (section == 0)?_cellArray.count:1;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OneCell"];
    if (indexPath.section == 0) {
        cell.textLabel.text = _cellArray[indexPath.row];
        if (indexPath.row == _cellArray.count - 1) {
            
            //添加贝塞尔曲线，UIBezierPath与CAShapeLayer设计边角样式
            /*
             byRoundingCorners即为设置所需处理边角参数,有如下枚举克进行选择：
             typedef NS_OPTIONS(NSUInteger, UIRectCorner) {
             UIRectCornerTopLeft     = 1 << 0,//左上圆角
             UIRectCornerTopRight    = 1 << 1,//右上圆角
             UIRectCornerBottomLeft  = 1 << 2,//左下圆角
             UIRectCornerBottomRight = 1 << 3,//右下圆角
             UIRectCornerAllCorners  = ~0UL   //四角圆角
             };
             */
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, Screen_Width - (Space_Line * 2), tableView.rowHeight) byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(10, 10)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
            maskLayer.frame = cell.contentView.bounds;
            maskLayer.path = maskPath.CGPath;
            cell.layer.mask = maskLayer;
        }
    } else {
        cell.textLabel.text = _cancelTitle;
        cell.layer.cornerRadius = 10;
    }
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (self.selectedBlock) {
            self.selectedBlock(indexPath.row);
        }
    } else {
        if (self.cancelBlock) {
            self.cancelBlock();
        }
    }
    [self dismiss];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return Space_Line;
}
- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, Space_Line)];
    footerView.backgroundColor = [UIColor clearColor];
    return footerView;
}
#pragma mark ------ 绘制视图
- (void)layoutSubviews {
    [super layoutSubviews];
    [self show];
}
//滑动弹出
- (void)show {
    _tableView.frame = CGRectMake(Space_Line, Screen_Height, Screen_Width - (Space_Line * 2), _tableView.rowHeight * (_cellArray.count + 1) + _headView.bounds.size.height + (Space_Line * 2));
    [UIView animateWithDuration:.5 animations:^{
        CGRect rect = _tableView.frame;
        rect.origin.y -= _tableView.bounds.size.height;
        _tableView.frame = rect;
    }];
}
//滑动消失
- (void)dismiss {
    [UIView animateWithDuration:.5 animations:^{
        CGRect rect = _tableView.frame;
        rect.origin.y += _tableView.bounds.size.height;
        _tableView.frame = rect;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
#pragma mark ------ 触摸屏幕其他位置弹下
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismiss];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

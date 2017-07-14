//
//  JasonActionSheetView.h
//  JasonActionSheet
//
//  Created by JasonHao on 2017/7/14.
//  Copyright © 2017年 JasonHao. All rights reserved.
//

#import <UIKit/UIKit.h>

#define Screen_Width [UIScreen mainScreen].bounds.size.width
#define Screen_Height [UIScreen mainScreen].bounds.size.height
#define Space_Line 10
@interface JasonActionSheetView : UIView<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIView *maskView;//背景
@property (nonatomic, strong) UITableView *tableView;//展示表格
@property (nonatomic, strong) NSArray *cellArray;//表格数组
@property (nonatomic,   copy) NSString *cancelTitle;//取消的标题设置
@property (nonatomic, strong) UIView *headView;//标题头视图
@property (nonatomic,   copy) void(^selectedBlock)(NSInteger);//选择单元格block
@property (nonatomic,   copy) void(^cancelBlock)();//取消单元格block

//初始化方法:参数一：头视图，参数二：表格数组，参数三：取消的标题设置，参数四：选择单元格block，参数五：取消block
-(instancetype)initWithHeadView:(UIView *)headView cellArray:(NSArray *)cellArray cancelTitle:(NSString *)cancelTitle selectedBlock:(void(^)(NSInteger))selectedBlock cancelBlock:(void(^)())cancelBlock;

@end

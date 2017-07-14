//
//  ViewController.m
//  JasonActionSheet
//
//  Created by JasonHao on 2017/7/14.
//  Copyright © 2017年 JasonHao. All rights reserved.
//

#import "ViewController.h"
#import "JasonActionSheetView.h"

@interface ViewController ()

@property (nonatomic, strong) UIView *headView;//标题头视图
@property (nonatomic, strong) NSMutableArray *dataArr;//表格数组

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *actionSheetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    actionSheetBtn.frame = CGRectMake(120, 200, 160, 100);
    [actionSheetBtn setTitle:@"弹出actionSheet" forState:UIControlStateNormal];
    [actionSheetBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [actionSheetBtn addTarget:self action:@selector(actionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:actionSheetBtn];
    
}
#pragma mark ------- 弹出按钮
-(void)actionBtnClick:(UIButton *)btn
{
    //弹出ActionSheet
    __weak typeof(self) weakSelf = self;
    JasonActionSheetView *jasonSheetView = [[JasonActionSheetView alloc]initWithHeadView:self.headView cellArray:self.dataArr cancelTitle:@"取消" selectedBlock:^(NSInteger index) {
        //点击单元格后续操作
        if (index == 0) {
            weakSelf.view.backgroundColor = [UIColor redColor];
        }else if(index == 1){
            weakSelf.view.backgroundColor = [UIColor yellowColor];
        }else{
            weakSelf.view.backgroundColor = [UIColor lightGrayColor];
        }
    } cancelBlock:^{
        NSLog(@"点击了取消........");
    }];
    
    [self.view addSubview:jasonSheetView];
    
}
//数组
- (NSMutableArray*)dataArr {
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc]initWithObjects:@"红色",@"黄色",@"灰色", nil];
    }
    return _dataArr;
}
//头视图
- (UIView*)headView {
    if (!_headView) {
        _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width - 20, 100)];
        _headView.backgroundColor = [UIColor whiteColor];
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, self.view.bounds.size.width - 20, 30)];
        titleLabel.text = @"请选择背景颜色";
        titleLabel.font = [UIFont systemFontOfSize:15.0];
        titleLabel.textColor = [UIColor colorWithRed:73/255.0 green:75/255.0 blue:90/255.0 alpha:1];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [_headView addSubview:titleLabel];
        
        UILabel *descLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 270, 30)];
        descLabel.text = @"这里根据需要自定义标题头";
        descLabel.textAlignment = NSTextAlignmentCenter;
        descLabel.center = CGPointMake(_headView.center.x, 55);
        [_headView addSubview:descLabel];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 99.5, self.view.bounds.size.width - 20, .5)];
        line.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
        [_headView addSubview:line];
    }
    return _headView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

//
//  ViewController.m
//  CopyAliapySquaredUpView
//
//  Created by 王盛魁 on 16/8/30.
//  Copyright © 2016年 WangShengKui. All rights reserved.
//

#import "ViewController.h"
#import "SquaredUpView.h"

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<SquaredUpViewDelegate>
@property (nonatomic, strong) NSMutableArray *dataArray; // 页面数据源数组
@property (nonatomic, strong) SquaredUpView *squaredUpView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"九宫格";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.dataArray = [NSMutableArray arrayWithObjects:@"一",@"二", @"三", @"四", @"五", @"六", @"七", @"八", @"九", @"十", @"十一", nil];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"添加" style:UIBarButtonItemStyleDone target:self action:@selector(refreshView)];
    [self creatView];

        // Do any additional setup after loading the view, typically from a nib.
}


- (void)creatView{
    self.squaredUpView = [[SquaredUpView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 200)];
    self.squaredUpView.delegate = self;
    self.squaredUpView.dataArray = self.dataArray;
    [self.view addSubview:self.squaredUpView];
}

- (void)refreshView{
    NSInteger num = arc4random() % 100;
    NSString *str = [NSString stringWithFormat:@"%ld",num];
    [self.dataArray addObject:str];
    [self.squaredUpView refreshSquaredViewWithArray:self.dataArray];
}
- (void)clickSquareWithIndex:(NSInteger)index{
    NSLog(@"index == %ld value = %@",(long)index,self.dataArray[index]);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

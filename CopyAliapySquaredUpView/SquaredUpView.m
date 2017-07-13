//
//  SquaredUpView.m
//  CopyAliapyLiveView
//
//  Created by 王盛魁 on 16/8/30.
//  Copyright © 2016年 WangShengKui. All rights reserved.
//

#import "SquaredUpView.h"
#import "SquareView.h"


@interface SquaredUpView ()<SquareViewDelegate>
@property (nonatomic, assign) CGPoint centerPoint;/**< 当前移动对象的中心点 */
@property (nonatomic, strong) NSMutableArray *modelArray;/**< 九宫格对象数组 */
@property (nonatomic, assign) NSInteger numberOfLine;/**< 行数 */
@property (nonatomic, assign) NSInteger numberOfColumn;/**< 列数 */

@end

@implementation SquaredUpView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.numberOfLine = 1;
        self.numberOfColumn = 5;
    }
    return self;
}
- (void)setDataArray:(NSMutableArray *)dataArray{
    _dataArray = dataArray;
    [self compositionSquareViewWithArray:dataArray];
}
- (void)compositionSquareViewWithArray:(NSArray *)array{
    self.modelArray = [NSMutableArray array];
    if (array.count % self.numberOfColumn == 0) {
        self.numberOfLine = array.count/self.numberOfColumn;
    }else{
        self.numberOfLine = array.count/self.numberOfColumn+1;
    }
    // 格子宽和高
    CGFloat squareWidth = self.bounds.size.width/self.numberOfColumn;
    CGFloat squareHeight = self.bounds.size.height/self.numberOfLine;
    for (NSInteger i = 0; i < self.numberOfLine; i++) {
        for (NSInteger j = 0; j< self.numberOfColumn; j++) {
            if (i*self.numberOfColumn+j == array.count) {
                break;
            }
            SquareView *subView = [[SquareView alloc]initWithFrame:CGRectMake(j * squareWidth, i * squareHeight, squareWidth, squareHeight)];
            subView.delegate = self;
            [subView setSquareDataWithDataArray:array AndIndex:(i*self.numberOfColumn+j)];
            [self addSubview:subView];
            [self.modelArray addObject:subView];
        }
    }
}

- (void)clickOneOfSquareViewWithObject:(SquareView *)squareView{
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickSquareWithIndex:)]) {
        NSInteger index = [squareView indexOfArray:self.modelArray];
        [self.delegate clickSquareWithIndex:index];
    }
}
- (void)beginMoveOneOfSquareViewWithObject:(SquareView *)squareView{
    self.centerPoint = squareView.center;
}
- (void)moveingOneOfSquareViewWithObject:(SquareView *)squareView{
    //目标位置
    NSInteger toIndex = [squareView toIndexOfArray:self.modelArray];
    NSInteger beginIndex = [squareView indexOfArray:self.modelArray];
    if (toIndex >= 0 && toIndex <= self.modelArray.count) {
        SquareView *toView = self.modelArray[toIndex];
        squareView.center = toView.viewCenterPoint;
        self.centerPoint = toView.viewCenterPoint;
        // 格子向前移动
        if (toIndex < beginIndex) {
            for (NSInteger j = beginIndex; j > toIndex; j--) {
                SquareView *squareOne = self.modelArray[j];
                SquareView *squareTwo = self.modelArray[j-1];
                [self.dataArray exchangeObjectAtIndex:j withObjectAtIndex:j-1];
                [UIView animateWithDuration:0.5 animations:^{
                    squareTwo.center = squareOne.viewCenterPoint;
                }];
            }
        }
        // 格子向后移动
        if (toIndex > beginIndex) {
            for (NSInteger j = beginIndex; j < toIndex; j++) {
                SquareView *squareOne = self.modelArray[j];
                SquareView *squareTwo = self.modelArray[j+1];
                [self.dataArray exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                [UIView animateWithDuration:0.5 animations:^{
                    squareTwo.center = squareOne.viewCenterPoint;
                }];
            }
        }
        [self.modelArray removeObject:squareView];
        [self.modelArray insertObject:squareView atIndex:toIndex];
        [self replaceCenterPointOfSquareView];
    }
}
- (void)endMoveOneOfSquareViewWithObject:(SquareView *)squareView{
    squareView.center = self.centerPoint;
}
- (void)replaceCenterPointOfSquareView{
    for (NSInteger i = 0; i < self.modelArray.count; i++) {
        SquareView *squareView = self.modelArray[i];
        squareView.viewCenterPoint = squareView.center;
    }
}
- (void)refreshSquaredViewWithArray:(NSMutableArray *)array{
    NSArray *subViewArray = self.subviews;
    for (int i = 0; i< subViewArray.count; i++) {
        UIView *temp = [subViewArray objectAtIndex:i];
        [temp removeFromSuperview];
    }
    self.dataArray = array;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

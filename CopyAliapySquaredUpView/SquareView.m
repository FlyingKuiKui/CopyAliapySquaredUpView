//
//  SquareView.m
//  CopyAliapySquaredUpView
//
//  Created by 王盛魁 on 16/8/30.
//  Copyright © 2016年 WangShengKui. All rights reserved.
//

#import "SquareView.h"
#define arc4RandomUIColor [UIColor colorWithRed:arc4random() % 256/255.0 green:arc4random() % 256/255.0 blue:arc4random() % 256/255.0 alpha:0.5]

@interface SquareView ()
@property (nonatomic, strong) UILabel *lbl; // 测试控件
@end


@implementation SquareView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUIViewWithFrame:frame];
        // 长按手势
        UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressGestureAction:)];
        [self addGestureRecognizer:longPressGesture];
        // 轻拍手势
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
        tapGesture.numberOfTapsRequired = 1;
        [self addGestureRecognizer:tapGesture];
        self.viewCenterPoint = self.center;
    }
    return self;
}
#pragma mark - 创建控件
- (void)setUpUIViewWithFrame:(CGRect)frame{
    self.lbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 20)];
    _lbl.textColor = [UIColor blackColor];
    _lbl.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.lbl];
}
#pragma mark - 长按手势事件
- (void)longPressGestureAction:(UILongPressGestureRecognizer *)gesture{
    switch (gesture.state) {
        // 开始移动
        case UIGestureRecognizerStateBegan:
            if (self.delegate && [self.delegate respondsToSelector:@selector(beginMoveOneOfSquareViewWithObject:)]) {
                [self.superview bringSubviewToFront:self];
                self.transform = CGAffineTransformMakeScale(1.2, 1.2);
                [self.delegate beginMoveOneOfSquareViewWithObject:self];
            }
            break;
        // 正在移动
        case UIGestureRecognizerStateChanged:
            if (self.delegate && [self.delegate respondsToSelector:@selector(moveingOneOfSquareViewWithObject:)]) {
                CGPoint touchPoint = [gesture locationInView:self.superview];
                self.center = touchPoint;
                [self.delegate moveingOneOfSquareViewWithObject:self];
            }
            break;
        // 结束移动
        case UIGestureRecognizerStateEnded:
            if (self.delegate && [self.delegate respondsToSelector:@selector(endMoveOneOfSquareViewWithObject:)]) {
                self.transform = CGAffineTransformIdentity;
                [self.delegate endMoveOneOfSquareViewWithObject:self];
            }
            break;
        default:
            break;
    }
}
#pragma mark - 轻拍手势事件
- (void)tapGestureAction:(UITapGestureRecognizer *)gesture{
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickOneOfSquareViewWithObject:)]) {
        [self.delegate clickOneOfSquareViewWithObject:self];
    }
}

#pragma mark - 控件赋值
- (void)setSquareDataWithDataArray:(NSArray *)dataArray AndIndex:(NSInteger)index{
    self.lbl.text = dataArray[index];
    self.backgroundColor = arc4RandomUIColor;
}

- (NSInteger)indexOfArray:(NSArray *)array{
    NSInteger index = -1;
    if ([array containsObject:self]) {
        for (int i = 0; i < array.count; i++) {
            if (array[i] == self) {
                index = i;
            }
        }
    }
    return index;
}
- (NSInteger)toIndexOfArray:(NSArray *)array{
    NSInteger toIndex = -1;
    NSInteger nowIndex = [self indexOfArray:array];
    for (NSInteger index = 0; index < array.count; index++) {
        if (index == nowIndex) {
            continue;
        }
        SquareView *square = [array objectAtIndex:index];
        if (CGRectContainsPoint(square.frame, self.center)) {
            toIndex = index;
        }
    }
    return toIndex;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

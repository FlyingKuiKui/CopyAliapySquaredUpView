//
//  SquareView.h
//  CopyAliapySquaredUpView
//
//  Created by 王盛魁 on 16/8/30.
//  Copyright © 2016年 WangShengKui. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SquareView;

@protocol SquareViewDelegate <NSObject>

- (void)clickOneOfSquareViewWithObject:(SquareView *)squareView;// 点击格子
- (void)beginMoveOneOfSquareViewWithObject:(SquareView *)squareView;// 格子开始移动
- (void)moveingOneOfSquareViewWithObject:(SquareView *)squareView; // 格子正在移动
- (void)endMoveOneOfSquareViewWithObject:(SquareView *)squareView;// 格子停止移动

@end

@interface SquareView : UIView

@property (nonatomic, assign) CGPoint viewCenterPoint;/**< 格子移动前中心点位置 */
@property (nonatomic, assign) id<SquareViewDelegate> delegate;

/**
 * 控件赋值 
 */

- (void)setSquareDataWithDataArray:(NSArray *)dataArray AndIndex:(NSInteger)index;

- (NSInteger)indexOfArray:(NSArray *)array;
- (NSInteger)toIndexOfArray:(NSArray *)array;

@end

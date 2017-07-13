//
//  SquaredUpView.h
//  CopyAliapyLiveView
//
//  Created by 王盛魁 on 16/8/30.
//  Copyright © 2016年 WangShengKui. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SquaredUpViewDelegate <NSObject>
// 格子点击事件
- (void)clickSquareWithIndex:(NSInteger)index;

@end

@interface SquaredUpView : UIView
@property (nonatomic, strong) NSMutableArray *dataArray;/**< 数据源数组 */
@property (nonatomic, assign) id<SquaredUpViewDelegate> delegate;
- (void)refreshSquaredViewWithArray:(NSMutableArray *)array;
@end

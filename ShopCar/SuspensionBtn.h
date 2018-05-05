//
//  SuspensionBtn.h
//  iseasoftCompany
//
//  Created by songfei on 2018/5/5.
//  Copyright © 2018年 hycrazyfish. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SuspensionBtn : UIButton
//角标设置
- (void)setNub:(NSInteger)proNub;

- (NSInteger)getProNub;



/**
 加入购物车时的动画

 @param image 图片
 @param startFrame 开始的图片Frame
 @param endFrame 结束时的购物车的Frame
 @param completion 动画结束回调block
 */
+ (void)animationWithImage:(UIImage *)image startFrame:(CGRect)startFrame endFrame:(CGRect)endFrame completion:(void (^)(BOOL))completion;

/**
 获取UItableCell相对屏幕的位置

 @param cellIndexPath cell的下标
 @param tableView 表
 @param relativeView 相对View
 @return 返回frame
 */
+ (CGRect)getCellFrameWithIndexPath:(NSIndexPath *)cellIndexPath tableView:(UITableView*)tableView relativeView:(UIView *)relativeView;
@end

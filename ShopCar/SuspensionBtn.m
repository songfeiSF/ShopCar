//
//  SuspensionBtn.m
//  iseasoftCompany
//
//  Created by songfei on 2018/5/5.
//  Copyright © 2018年 hycrazyfish. All rights reserved.
//

#import "SuspensionBtn.h"
#import "UIView+Frame.h"
@interface SuspensionBtn()
@property (nonatomic ,strong) UILabel *numberLabel;
@end
@implementation SuspensionBtn{
    CGPoint startLocation;
}
- (UILabel *)numberLabel{
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.imageView.top + 5, 15, 15)];
        _numberLabel.backgroundColor = [UIColor redColor];
        _numberLabel.textColor = [UIColor whiteColor];
        _numberLabel.font = [UIFont systemFontOfSize:10];
        _numberLabel.textAlignment = NSTextAlignmentCenter;
        _numberLabel.text = @"1";
        _numberLabel.layer.cornerRadius = _numberLabel.frame.size.height/2.0;
        _numberLabel.layer.masksToBounds = true;
        _numberLabel.hidden = true;
    }
    return _numberLabel;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.layer.cornerRadius = frame.size.height/2.0;
        self.layer.masksToBounds = true;
        [self addSubview:self.numberLabel];
    }
    return self;
}

- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {
    CGPoint pt = [[touches anyObject] locationInView:self];
    startLocation = pt;
    [[self superview] bringSubviewToFront:self];
}

-(void)touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event {
    CGPoint pt = [[touches anyObject] locationInView:self];
    float dx = pt.x - startLocation.x;
    float dy = pt.y - startLocation.y;
    CGPoint newcenter = CGPointMake(self.center.x + dx, self.center.y + dy);

    float halfx = CGRectGetMidX(self.bounds);
    newcenter.x = MAX(halfx, newcenter.x);
    newcenter.x = MIN(self.superview.bounds.size.width - halfx, newcenter.x);
    
    float halfy = CGRectGetMidY(self.bounds);
    newcenter.y = MAX(halfy, newcenter.y);
    newcenter.y = MIN(self.superview.bounds.size.height - halfy, newcenter.y);
    
    self.center = newcenter;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint point = self.center;
    if (point.x > [self superview].width/2.0) {
        [UIView animateWithDuration:0.2 animations:^{
            self.left = [self superview].width-self.width;
        }];
    }else{
        [UIView animateWithDuration:0.2 animations:^{
            self.left = 0;
        }];
    }
}

- (void)setNub:(NSInteger)proNub{
    if (proNub == 0) {
        self.numberLabel.hidden = true;
    }else{
        self.numberLabel.hidden = false;
    }
    
    NSString *nubText = [NSString stringWithFormat:@"%ld",proNub];
    if (nubText.length >= 3 && self.numberLabel.width < 30) {
        self.numberLabel.width = self.numberLabel.width *2;
        self.numberLabel.right = self.imageView.right;
        [self layoutIfNeeded];
    }
    
    if (nubText.length < 3) {
        self.numberLabel.width = 15;
        self.numberLabel.right = self.imageView.right;
        [self layoutIfNeeded];
    }
    
    if (self.numberLabel.text.integerValue <= proNub) {
        CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnimation.fromValue = [NSNumber numberWithFloat:1.0];
        scaleAnimation.toValue = [NSNumber numberWithFloat:0.8];
        scaleAnimation.duration = 0.1;
        scaleAnimation.repeatCount = 2;
        scaleAnimation.autoreverses = YES;
        scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [self.imageView.layer addAnimation:scaleAnimation forKey:nil];
    }
    
    self.numberLabel.text = nubText;
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state{
    [super setImage:image forState:state];
    self.numberLabel.top = self.imageView.top;
    self.numberLabel.right = self.imageView.right;
    [self layoutIfNeeded];
}
- (NSInteger)getProNub{
    return self.numberLabel.text.integerValue;
}



+ (void)animationWithImage:(UIImage *)image startFrame:(CGRect)startFrame endFrame:(CGRect)endFrame completion:(void (^)(BOOL))completion{
    
    CGPoint startPoint = CGPointMake(startFrame.origin.x + startFrame.size.width/2.0, startFrame.origin.y + startFrame.size.height);
    
    CGPoint endPoint = CGPointMake(endFrame.origin.x + endFrame.size.width/2.0, endFrame.origin.y + endFrame.size.height/2.0);
    
    CAShapeLayer *animationLayer = [[CAShapeLayer alloc]init];
    animationLayer.frame = CGRectMake(startPoint.x, startPoint.y, startFrame.size.width, startFrame.size.height);
    
    animationLayer.contents = (id)image.CGImage;
    
    // 获取window的最顶层视图控制器
    UIViewController *rootVC = [[UIApplication sharedApplication].delegate window].rootViewController;
    UIViewController *parentVC = rootVC;
    while ((parentVC = rootVC.presentedViewController) != nil ) {
        rootVC = parentVC;
    }
    while ([rootVC isKindOfClass:[UINavigationController class]]) {
        rootVC = [(UINavigationController *)rootVC topViewController];
    }
    
    // 添加layer到顶层视图控制器上
    [rootVC.view.layer addSublayer:animationLayer];
    
    
    //创建轨迹
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    
    [bezierPath moveToPoint:startPoint];
    [bezierPath addQuadCurveToPoint:endPoint controlPoint:CGPointMake(endPoint.x, endPoint.y)];
    
    // 创建动画 移动动画
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.duration = 1;
    pathAnimation.removedOnCompletion = false;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.path = bezierPath.CGPath;
    
    // 创建动画 缩小动画
    CABasicAnimation *scalAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scalAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    scalAnimation.toValue = [NSNumber numberWithFloat:0.3];
    scalAnimation.duration = 1.0;
    scalAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    scalAnimation.removedOnCompletion = false;
    scalAnimation.fillMode = kCAFillModeForwards;
    
    [animationLayer addAnimation:pathAnimation forKey:nil];
    [animationLayer addAnimation:scalAnimation forKey:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [animationLayer removeFromSuperlayer];
        completion(YES);
    });
}

+ (CGRect)getCellFrameWithIndexPath:(NSIndexPath *)cellIndexPath tableView:(UITableView*)tableView relativeView:(UIView *)relativeView{
    CGRect rectInTableView = [tableView rectForRowAtIndexPath:cellIndexPath];
    CGRect rectInSuperView = [tableView convertRect:rectInTableView toView:relativeView];
    
    return rectInSuperView;
}
@end

//
//  RefreshView.m
//  RefreshView
//
//  Created by Xujiangfei on 2018/6/5.
//  Copyright © 2018年 Xujiangfei. All rights reserved.
//

#import "RefreshView.h"

NSTimeInterval const animationDuration = 0.5;

@interface RefreshView()

@property (nonatomic, copy) NSArray *circleArray;

@property (nonatomic, strong) CAShapeLayer *shapeLayerOne;
@property (nonatomic, strong) CAShapeLayer *shapeLayerTwo;
@property (nonatomic, strong) CAShapeLayer *shapeLayerThree;

@property (nonatomic, strong) NSMutableArray *layerArrays;

@end

@implementation RefreshView


- (void)setColorArray:(NSArray *)colorArray{
    _colorArray = colorArray;
    //    [self drawCircle];
}

- (void)setProgress:(CGFloat)progress{
    _progress = progress;
    _layerArrays = [NSMutableArray arrayWithCapacity:3];
    [self setNeedsDisplay];
}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    NSInteger index;
    
    _shapeLayerOne = [CAShapeLayer layer];
    _shapeLayerOne.frame = self.bounds;
    _shapeLayerTwo = [CAShapeLayer layer];
    _shapeLayerTwo.frame = self.bounds;
    _shapeLayerThree = [CAShapeLayer layer];
    _shapeLayerThree.frame = self.bounds;
    [_layerArrays addObject:_shapeLayerOne];
    [_layerArrays addObject:_shapeLayerTwo];
    [_layerArrays addObject:_shapeLayerThree];

    [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    
    if (_progress <= 1 / 3.0) {
        index = 0;
    }else if (_progress <= 2 / 3.0){
        index = 1;
    }else{
        index = 2;
    }
    CGPoint center = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.width / 2.0);
    CGFloat radius = self.bounds.size.width / 6.0;
    for (NSInteger i = 0; i <= index; i++) {
        CGFloat start = M_PI_2 * 3 - M_PI * 2 / 3.0 * i;
        CGFloat end = 0;
        
        if (i == 0) {
            if (_progress <= 1 / 3.0) {
                end = start - M_PI * 2 * _progress;
            }else{
                end = start - M_PI * 2 / 3.0;
            }
        }else if (i == 1){
            if (_progress <= 2 / 3.0) {
                end = start - M_PI * 2 * (_progress - 1 / 3.0);
            }else{
                end = start - M_PI * 2 / 3.0;
            }
        }else{
            end = start - M_PI * 2 * (_progress - 2 / 3.0);
        }
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:start endAngle:end clockwise:NO];
        path.lineCapStyle = kCGLineCapRound;
        path.lineJoinStyle = kCGLineJoinRound;
        
        UIColor *color = _colorArray[i];
        
        CAShapeLayer *layer = _layerArrays[i];
        layer.lineWidth = 6.0;
        layer.fillColor = [UIColor clearColor].CGColor;
        layer.strokeColor = color.CGColor;

        
        layer.path = path.CGPath;
        
        [self.layer addSublayer:layer];
        
    }
    
    if (_progress == 1) {
        [self nextStep];
    }
}

- (void)nextStep{
    
    //移除之前的layer
    [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    
    CGPoint center = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.width / 2.0);
    CGFloat radius = self.bounds.size.width / 6.0;
    
    //创建新的layer，之间有一定的角度分隔
    for (NSInteger i = 0; i <= 2; i++) {
        
        CGFloat start = M_PI_2 * 3 - M_PI * 2 / 3.0 * i;
        CGFloat end = start - M_PI * 2 / 3.0 + M_PI / 4.0;
        
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:start endAngle:end clockwise:NO];
        path.lineCapStyle = kCGLineCapRound;
        path.lineJoinStyle = kCGLineJoinRound;
        
        UIColor *color = _colorArray[i];
        
        CAShapeLayer *layer = _layerArrays[i];
        layer.lineWidth = 6.0;
        layer.fillColor = [UIColor clearColor].CGColor;
        layer.strokeColor = color.CGColor;
        layer.path = path.CGPath;
        
        [self.layer addSublayer:layer];
    }
    
    
    for (CAShapeLayer *layer in _layerArrays) {
        //旋转
        CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2 / 3.0];
        rotationAnimation.duration = 0.2;
        rotationAnimation.cumulative = YES;
        rotationAnimation.repeatCount = 3;
        rotationAnimation.removedOnCompletion = YES;
        rotationAnimation.fillMode = kCAFillModeForwards;
        
        [layer addAnimation:rotationAnimation forKey:@"speed"];
    }
    
    
    
    for (NSInteger i = 0; i < _layerArrays.count; i++) {
        CAShapeLayer *layer = _layerArrays[i];
     
        //旋转
        CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotationAnimation.beginTime = CACurrentMediaTime() + animationDuration;
        rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2 / 3.0];
        rotationAnimation.duration = animationDuration;
        rotationAnimation.cumulative = YES;
        rotationAnimation.repeatCount = MAXFLOAT;
        rotationAnimation.removedOnCompletion = NO;
        rotationAnimation.fillMode = kCAFillModeForwards;
        
        [layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
        
        // 比例缩放
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        animation.beginTime = CACurrentMediaTime() + animationDuration;
        // 持续时间
        animation.duration = animationDuration;
        // 重复次数
        animation.repeatCount = MAXFLOAT;
        // 起始scale
        animation.fromValue = @(1);
        // 终止scale
        animation.toValue = @(1.2);
        // 添加动画
        animation.autoreverses = YES;
        [layer addAnimation:animation forKey:@"zoom"];
        
        // 比例缩放
        CABasicAnimation *animationOne = [CABasicAnimation animationWithKeyPath:@"lineWidth"];
        animationOne.beginTime = CACurrentMediaTime() + animationDuration;
        // 持续时间
        animationOne.duration = animationDuration;
        // 重复次数
        animationOne.repeatCount = MAXFLOAT;
        // 起始scale
        animationOne.fromValue = @(6);
        // 终止scale
        animationOne.toValue = @(2.5);
        // 添加动画
        animationOne.autoreverses = YES;
        animationOne.fillMode = kCAFillModeForwards;

        [layer addAnimation:animationOne forKey:@"lineWith"];
        
        
        CAAnimationGroup *group = [CAAnimationGroup animation];
        //会自动执行animations数组当中所有的动画对象
        group.animations = @[rotationAnimation, animation, animationOne];
        group.removedOnCompletion = NO;
        group.fillMode = kCAFillModeForwards;
        [layer addAnimation:group forKey:nil];
        
    }

}


@end

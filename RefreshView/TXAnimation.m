//
//  TXAnimation.m
//  HKWireless
//
//  Created by niegaotao on 16/2/24.
//  Copyright © 2016年 niegaotao. All rights reserved.
//

#import "TXAnimation.h"

@implementation TXAnimation

+ (CALayer *)replicatorLayer_Circle:(CGFloat)w{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = CGRectMake(0, 0, 80, 80);
    shapeLayer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 80, 80)].CGPath;
    shapeLayer.fillColor = [UIColor redColor].CGColor;
    shapeLayer.opacity = 0.0;
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[[TXAnimation alphaAnimation],[TXAnimation scaleAnimation]];
    animationGroup.duration = 4.0;
    animationGroup.autoreverses = NO;
    animationGroup.repeatCount = HUGE;
    
    [shapeLayer addAnimation:animationGroup forKey:@"animationGroup"];
    
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.frame = CGRectMake((w-80)/2, (w-80)/2, 80, 80);
    replicatorLayer.instanceDelay = 0.5;
    replicatorLayer.instanceCount = 8;
    [replicatorLayer addSublayer:shapeLayer];
    return replicatorLayer;
}

+ (CALayer *)replicatorLayer_Wave:(CGFloat)w{
    CGFloat between = 5.0;
    CGFloat radius = (100-2*between)/3;
    CAShapeLayer *shape = [CAShapeLayer layer];
    shape.frame = CGRectMake(0, (100-radius)/2, radius, radius);
    shape.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, radius, radius)].CGPath;
    shape.fillColor = [UIColor redColor].CGColor;
    [shape addAnimation:[TXAnimation scaleAnimation1] forKey:@"scaleAnimation"];
    
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.frame = CGRectMake((w-100)/2, (w-100)/2, 100, 100);
    replicatorLayer.instanceDelay = 0.2;
    replicatorLayer.instanceCount = 3;
    replicatorLayer.instanceTransform = CATransform3DMakeTranslation(between*2+radius,0,0);
    [replicatorLayer addSublayer:shape];
    
    return replicatorLayer;
}

+ (CALayer *)replicatorLayer_Trans:(CGFloat)w{
    CGFloat between = 5.0;
    CGFloat radius = (100-2*between)/3;
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = CGRectMake(0, (100-radius)/2, radius, radius);
    shapeLayer.path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, radius, radius)].CGPath;
    shapeLayer.fillColor = [UIColor redColor].CGColor;
    [shapeLayer addAnimation:[TXAnimation flipAnimation] forKey:@"flipAnimation"];
    
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.frame = CGRectMake((w-100)/2, (w-100)/2, 100, 100);
    replicatorLayer.instanceDelay = 0.1;
    replicatorLayer.instanceCount = 3;
    replicatorLayer.instanceTransform = CATransform3DMakeTranslation(between+radius, 0, 0);
    [replicatorLayer addSublayer:shapeLayer];
    
    return replicatorLayer;
}

+ (CALayer *)replicatorLayer_Triangle:(CGFloat)w{
    CGFloat radius = 100/4;
    CGFloat transX = 100 - radius;
    CAShapeLayer *shape = [CAShapeLayer layer];
    shape.frame = CGRectMake(0, 0, radius, radius);
    shape.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, radius, radius)].CGPath;
    shape.strokeColor = [UIColor redColor].CGColor;
    shape.fillColor = [UIColor redColor].CGColor;
    shape.lineWidth = 1;
    //    [shape addAnimation:[TXAnimation rotationAnimation:transX] forKey:@"startAnimations"];
    
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.frame = CGRectMake((w-100)/2, (w-100)/2, radius, radius);
    replicatorLayer.instanceDelay = 0.0;
    replicatorLayer.instanceCount = 3;
    CATransform3D trans3D = CATransform3DIdentity;
    trans3D = CATransform3DTranslate(trans3D, transX, 0, 0);
    trans3D = CATransform3DRotate(trans3D, 120.0*M_PI/180.0, 0.0, 0.0, 1.0);
    replicatorLayer.instanceTransform = trans3D;
    [replicatorLayer addSublayer:shape];
    
    return replicatorLayer;
}

+ (CALayer *)replicatorLayer_Grid:(CGFloat)w{
    NSInteger column = 3;
    CGFloat between = 5.0;
    CGFloat radius = (100 - between * (column - 1))/column;
    CAShapeLayer *shape = [CAShapeLayer layer];
    shape.frame = CGRectMake(0, 0, radius, radius);
    shape.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, radius, radius)].CGPath;
    shape.fillColor = [UIColor redColor].CGColor;
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[[TXAnimation scaleAnimation1], [TXAnimation alphaAnimation]];
    animationGroup.duration = 1.0;
    animationGroup.autoreverses = YES;
    animationGroup.repeatCount = HUGE;
    [shape addAnimation:animationGroup forKey:@"groupAnimation"];
    
    CAReplicatorLayer *replicatorLayerX = [CAReplicatorLayer layer];
    replicatorLayerX.frame = CGRectMake((w-100)/2, (w-100)/2, 100, 100);
    replicatorLayerX.instanceDelay = 0.3;
    replicatorLayerX.instanceCount = column;
    replicatorLayerX.instanceTransform = CATransform3DTranslate(CATransform3DIdentity, radius+between, 0, 0);
    [replicatorLayerX addSublayer:shape];
    
    
    CAReplicatorLayer *replicatorLayerY = [CAReplicatorLayer layer];
    replicatorLayerY.frame = CGRectMake(0, 0, 100, 100);
    replicatorLayerY.instanceDelay = 0.3;
    replicatorLayerY.instanceCount = column;
    replicatorLayerY.instanceTransform = CATransform3DTranslate(CATransform3DIdentity, 0, radius+between, 0);
    [replicatorLayerY addSublayer:replicatorLayerX];
    
    return replicatorLayerY;
}

+ (CABasicAnimation *)alphaAnimation{
    CABasicAnimation *alpha = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alpha.fromValue = @(1.0);
    alpha.toValue = @(0.0);
    return alpha;
}

+ (CABasicAnimation *)scaleAnimation{
    CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform"];
    CATransform3D identiity = CATransform3DIdentity;
    scale.fromValue = [NSValue valueWithCATransform3D:CATransform3DScale(identiity, 0.0, 0.0, 0.0)];
    scale.toValue = [NSValue valueWithCATransform3D:CATransform3DScale(identiity, 1.0, 1.0, 0.0)];
    return scale;
}

+ (CABasicAnimation *)scaleAnimation1{
    CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform"];
    CATransform3D identity  = CATransform3DIdentity;
    
    scale.fromValue = [NSValue valueWithCATransform3D:CATransform3DScale(identity, 1.0, 1.0, 0.0)];
    scale.toValue = [NSValue valueWithCATransform3D:CATransform3DScale(identity, 0.2, 0.2, 0.0)];
    scale.autoreverses = YES;
    scale.repeatCount = HUGE;
    scale.duration = 0.6;
    return scale;
}

+ (CABasicAnimation *)flipAnimation{
    CABasicAnimation *flip = [CABasicAnimation animationWithKeyPath:@"transform"];
    CATransform3D identity  = CATransform3DIdentity;
    
    CATransform3D fromValue  = CATransform3DRotate(identity, 0.0, 0.0, 1.0, 0.0);
    flip.fromValue = [NSValue valueWithCATransform3D:fromValue];
    
    CATransform3D toValue  = CATransform3DRotate(identity, M_PI, 0.0, 1.0, 0.0);
    flip.toValue = [NSValue valueWithCATransform3D:toValue];
    
    flip.repeatCount = HUGE;
    flip.duration = 0.6;
    return flip;
}

+ (CAAnimationGroup *)rotationAnimation:(CGFloat)transX{
    CAAnimationGroup *group = [CAAnimationGroup animation];
    
    CABasicAnimation *rotationAnim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //默认是顺时针效果，若将fromValue和toValue的值互换，则为逆时针效果
    rotationAnim.fromValue = [NSNumber numberWithFloat:0.f];
    rotationAnim.toValue = [NSNumber numberWithFloat: M_PI * 2 / 3.0];
    rotationAnim.duration = 1;
    rotationAnim.autoreverses = NO;
    rotationAnim.fillMode = kCAFillModeForwards;
    rotationAnim.repeatCount = MAXFLOAT;
    
    CABasicAnimation *scaleAnim = [CABasicAnimation  animation];
    scaleAnim.keyPath = @"transform.scale";
    scaleAnim.toValue = @0.5;
    scaleAnim.autoreverses = YES;
    scaleAnim.duration = 1;
    scaleAnim.repeatCount = MAXFLOAT;


    group.animations = @[rotationAnim,scaleAnim];
    
    return group;
}


+ (CALayer *)gradientLayer:(CGRect)frame colors:(NSArray *)colors horizontal:(BOOL)horizontal{
    CAGradientLayer *sublayer = [CAGradientLayer layer];
    sublayer.frame = frame;
    if(horizontal){
        sublayer.startPoint = CGPointMake(0.0, 0.5);
        sublayer.endPoint = CGPointMake(1.0, 0.5);
    }
    else{
        sublayer.startPoint = CGPointMake(0.5, 0.0);
        sublayer.endPoint = CGPointMake(0.5, 1.0);
    }
    sublayer.colors = colors;
    return sublayer;
}


+ (CALayer *)gradientLayer:(CGRect)frame colors:(NSArray *)colors start:(CGPoint)startPoint end:(CGPoint)endPoint{
    CAGradientLayer *sublayer = [CAGradientLayer layer];
    sublayer.frame = frame;
    sublayer.startPoint = startPoint;
    sublayer.endPoint = endPoint;
    sublayer.colors = colors;
    return sublayer;
}
@end























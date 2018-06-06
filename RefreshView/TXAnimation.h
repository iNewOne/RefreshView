//
//  TXAnimation.h
//  HKWireless
//
//  Created by niegaotao on 16/2/24.
//  Copyright © 2016年 niegaotao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TXAnimation : NSObject

+ (CALayer *)replicatorLayer_Circle:(CGFloat)w;

+ (CALayer *)replicatorLayer_Wave:(CGFloat)w;

+ (CALayer *)replicatorLayer_Triangle:(CGFloat)w;

+ (CALayer *)replicatorLayer_Grid:(CGFloat)w;

+ (CALayer *)replicatorLayer_Trans:(CGFloat)w;

+ (CALayer *)gradientLayer:(CGRect)frame colors:(NSArray *)colors horizontal:(BOOL)horizontal;

+ (CAAnimationGroup *)rotationAnimation:(CGFloat)transX;
@end

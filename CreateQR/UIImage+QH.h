//
//  UIImage+QH.h
//  CreateQR
//
//  Created by white on 2017/11/15.
//Copyright © 2017年 white. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (QH)
/**
 *  长货架上的banner
 */
+ (void)createQR:(NSString *)string name:(NSString *)name logoImage:(UIImage *)logoImage;
/**
 *  六宫格上的banner 添加二维码和文字
 */
+ (void)createSixQR:(NSString *)string name:(NSString *)name  logoImage:(UIImage *)logoImage;
/**
 *  冰箱上的banner 添加二维码和文字
 */
+ (void)createRefrigeratorQR:(NSString *)string name:(NSString *)name  logoImage:(UIImage *)logoImage;
@end

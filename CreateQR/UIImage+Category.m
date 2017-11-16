//
//  UIImage+Category.m
//  CreateQR
//
//  Created by white on 2017/5/24.
//  Copyright © 2017年 white. All rights reserved.
//

#import "UIImage+Category.h"

@implementation UIImage (Category)
+ (UIImage *)creatNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat)size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1. 创建bitmap
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}



//
//+ (UIImage *)imageInsertedImage: (UIImage *)originImage insertImage: (UIImage *)insertImage radius: (CGFloat)radius {
//    
//    if (!insertImage) { return originImage; }
//    
//    insertImage = [UIImage imageOfRoundRectWithImage: insertImage size: insertImage.size radius: radius];
//    
//    UIImage * whiteBG = [UIImage imageNamed: @"whiteBG"];
//    
//    whiteBG = [UIImage imageOfRoundRectWithImage: whiteBG size: whiteBG.size radius: radius];
//    
//    //白色边缘宽度
//    
//    const CGFloat whiteSize = 2.f;
//    
//    CGSize brinkSize = CGSizeMake(originImage.size.width / 4, originImage.size.height / 4);
//    
//    CGFloat brinkX = (originImage.size.width - brinkSize.width) * 0.5;
//    
//    CGFloat brinkY = (originImage.size.height - brinkSize.height) * 0.5;
//    
//    CGSize imageSize = CGSizeMake(brinkSize.width - 2 * whiteSize, brinkSize.height - 2 * whiteSize);
//    
//    CGFloat imageX = brinkX + whiteSize;
//    
//    CGFloat imageY = brinkY + whiteSize;
//    
//    UIGraphicsBeginImageContext(originImage.size);
//    
//    [originImage drawInRect: (CGRect){ 0, 0, (originImage.size) }];
//    
//    [whiteBG drawInRect: (CGRect){ brinkX, brinkY, (brinkSize) }];
//    
//    [insertImage drawInRect: (CGRect){ imageX, imageY, (imageSize) }];
//    
//    UIImage * resultImage = UIGraphicsGetImageFromCurrentImageContext();
//    
//    UIGraphicsEndImageContext();
//    
//    return resultImage;
//    
//}
//+ (UIImage *)imageOfRoundRectWithImage: (UIImage *)image size: (CGSize)size radius: (CGFloat)radius
//
//{
//    
//    if (!image) { return nil; }
//    
//    const CGFloat width = size.width;
//    
//    const CGFloat height = size.height;
//    
//    radius = MAX(5.f, radius);
//    
//    radius = MIN(10.f, radius);
//    
//    UIImage * img = image;
//    
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//    
//    CGContextRef context = CGBitmapContextCreate(NULL, width, height, 8, 4 * width, colorSpace, kCGImageAlphaPremultipliedFirst);
//    
//    CGRect rect = CGRectMake(0, 0, width, height);
//    
//    //绘制圆角
//    
//    CGContextBeginPath(context);
//    
//    addRoundRectToPath(context, rect, radius, img.CGImage);
//    
//    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
//    
//    img = [UIImage imageWithCGImage: imageMasked];
//    
//    CGContextRelease(context);
//    
//    CGColorSpaceRelease(colorSpace);
//    
//    CGImageRelease(imageMasked);
//    
//    return img;
//    
//}

@end

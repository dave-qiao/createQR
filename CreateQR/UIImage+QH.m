//
//  UIImage+QH.m
//  CreateQR
//
//  Created by white on 2017/11/15.
//Copyright © 2017年 white. All rights reserved.
//

#import "UIImage+QH.h"
#import "UIImage+Category.h"
#import "UIImage+DPI.h"

@implementation UIImage (QH)
/**
 *  长货架上的banner 添加二维码和文字
 */
+ (UIImage *)addQRImage:(UIImage *)QRImage
                  IdStr:(NSString *)idStr {
    UIImage *backImage = [UIImage imageNamed:@"DaHuoGui"];
    UIGraphicsBeginImageContext(CGSizeMake(backImage.size.width * 3.0, backImage.size.height * 3.0));
    // 把二维码图片画上去 (这里是以图形上下文, 左上角为(0,0)点
    [backImage drawInRect:CGRectMake(0, 0, backImage.size.width * 3.0, backImage.size.height * 3.0)];
    //再把小图片画上去
    UIImage *sImage = QRImage;
    
    CGFloat sImageW = backImage.size.width * 88.0/1190.0;
    CGFloat sImageH= sImageW;
    CGFloat s_w = 940.0/1190.0;
    CGFloat sImageX = backImage.size.width * s_w;
    CGFloat s_h = 116.0/320;
    CGFloat sImgaeY = backImage.size.height * s_h;
    
    [sImage drawInRect:CGRectMake(sImageX * 3.0, sImgaeY * 3.0, sImageW * 3.0, sImageH * 3.0)];
    
    
    
    CGRect textRect = CGRectMake(sImageX * 3.0, (sImgaeY+sImageH) * 3.0, sImageW * 3.0,backImage.size.width * 14.0/1190.0 * 3.0);
    {
        NSString* textContent = [NSString stringWithFormat:@"编号：%@",idStr];
        NSMutableParagraphStyle* textStyle = [[NSMutableParagraphStyle alloc] init];
        textStyle.alignment = NSTextAlignmentCenter;
        NSDictionary* textFontAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:36 * 3.0], NSForegroundColorAttributeName: UIColor.blackColor, NSParagraphStyleAttributeName: textStyle};
        
        CGFloat textTextHeight = [textContent boundingRectWithSize: CGSizeMake(textRect.size.width, INFINITY) options: NSStringDrawingUsesLineFragmentOrigin attributes: textFontAttributes context: nil].size.height;
        
        [textContent drawInRect: CGRectMake(CGRectGetMinX(textRect), CGRectGetMinY(textRect) + (textRect.size.height - textTextHeight) / 2, textRect.size.width, textTextHeight) withAttributes: textFontAttributes];
    }
    
    
    // 6、获取当前画得的这张图片
    UIImage *final_image = UIGraphicsGetImageFromCurrentImageContext();
    // 7、关闭图形上下文
    UIGraphicsEndImageContext();
    
    final_image = [self removeBlank:final_image];
    
    return final_image;
}


/**
 *  六宫格上的banner 添加二维码和文字
 */
+ (UIImage *)addQRImageToSix:(UIImage *)QRImage
                       IdStr:(NSString *)idStr {
    UIImage *backImage = [UIImage imageNamed:@"LiuGongGe"];
    //    UIGraphicsBeginImageContext(CGSizeMake(backImage.size.width * 3.0, backImage.size.height * 3.0));
    UIGraphicsBeginImageContextWithOptions(backImage.size, YES, 3.0);
    // 把二维码图片画上去 (这里是以图形上下文, 左上角为(0,0)点
    [backImage drawInRect:CGRectMake(0, 0, backImage.size.width , backImage.size.height )];
    //再把小图片画上去
    UIImage *sImage = QRImage;
    
    CGFloat sImageW = 1048/3.0;
    CGFloat sImageH= sImageW;
    
    CGFloat sImageX = 2480/3.0;
    
    CGFloat sImgaeY = 1118/3.0;
    
    [sImage drawInRect:CGRectMake(sImageX, sImgaeY, sImageW, sImageH )];
    
    
    
    CGRect textRect = CGRectMake(sImageX , (sImgaeY+sImageH), sImageW ,108/3.0);
    {
        NSString* textContent = [NSString stringWithFormat:@"编号：%@",idStr];
        NSMutableParagraphStyle* textStyle = [[NSMutableParagraphStyle alloc] init];
        textStyle.alignment = NSTextAlignmentCenter;
        
        NSDictionary* textFontAttributes = @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size:28], NSForegroundColorAttributeName: [UIColor colorWithRed:0 green:0 blue:0 alpha:.6], NSParagraphStyleAttributeName: textStyle};
        
        CGFloat textTextHeight = [textContent boundingRectWithSize: CGSizeMake(textRect.size.width, INFINITY) options: NSStringDrawingUsesLineFragmentOrigin attributes: textFontAttributes context: nil].size.height;
        
        [textContent drawInRect: CGRectMake(CGRectGetMinX(textRect), CGRectGetMinY(textRect) + (textRect.size.height - textTextHeight) / 2, textRect.size.width, textTextHeight) withAttributes: textFontAttributes];
    }
    
    
    // 6、获取当前画得的这张图片
    UIImage *final_image = UIGraphicsGetImageFromCurrentImageContext();
    // 7、关闭图形上下文
    UIGraphicsEndImageContext();
    
    //    final_image = [self removeBlank:final_image];
    
    return final_image;
}

/**
 *  移除长货架上banner的空白背景
 */
+ (UIImage *)removeBlank:(UIImage *)image {
    UIImage *backImage = image;
    UIGraphicsBeginImageContext(CGSizeMake(12827, 2315));
    [backImage drawInRect:CGRectMake(-134,-332,backImage.size.width, backImage.size.height)];
    // 6、获取当前画得的这张图片
    UIImage *final_image = UIGraphicsGetImageFromCurrentImageContext();
    // 7、关闭图形上下文
    UIGraphicsEndImageContext();
    return final_image;
}


/**
 *  移除六宫格的空白背景
 */
+ (UIImage *)removeSixBlank:(UIImage *)image {
    UIImage *backImage = image;
    UIGraphicsBeginImageContext(CGSizeMake(3616, 2553));
    // 把二维码图片画上去 (这里是以图形上下文, 左上角为(0,0)点
    [backImage drawInRect:CGRectMake(-1446,-79,backImage.size.width*3, backImage.size.height*3)];
    // 6、获取当前画得的这张图片
    UIImage *final_image = UIGraphicsGetImageFromCurrentImageContext();
    // 7、关闭图形上下文
    UIGraphicsEndImageContext();
    return final_image;
}


/**
 *  冰箱上的banner 添加二维码和文字
 */
+ (UIImage *)addRefrigeratorQRImage:(UIImage *)QRImage
                              IdStr:(NSString *)idStr {
    UIImage *backImage = [UIImage imageNamed:@"BingGui"];
    
    UIGraphicsBeginImageContext(CGSizeMake(backImage.size.width, backImage.size.height));
    
    // 把banner背景图片画上去 (这里是以图形上下文, 左上角为(0,0)点
    [backImage drawInRect:CGRectMake(0, 0, backImage.size.width, backImage.size.height)];
    
    //再把二维码画上去
    UIImage *sImage = QRImage;
    CGFloat sImageW = backImage.size.width * 1470.0/6922.0;//二维码宽
    CGFloat sImageH= sImageW;
    CGFloat s_w = 5022.0/6922.0;//坐标x 在宽度上的比例
    CGFloat sImageX = backImage.size.width * s_w;//二维码x
    CGFloat s_h = 1480.0/3851;//坐标y 在宽度上的比例
    CGFloat sImgaeY = backImage.size.height * s_h;//二维码y
    
    [sImage drawInRect:CGRectMake(sImageX , sImgaeY , sImageW , sImageH )];
    
    // 添加文字
    CGRect textRect = CGRectMake(sImageX , (sImgaeY + sImageH + 40) , sImageW ,backImage.size.width * 14.0/3610);
    {
        NSString* textContent = [NSString stringWithFormat:@"编号：%@",idStr];
        NSMutableParagraphStyle* textStyle = [[NSMutableParagraphStyle alloc] init];
        textStyle.alignment = NSTextAlignmentCenter;
        NSDictionary* textFontAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:36], NSForegroundColorAttributeName: UIColor.blackColor, NSParagraphStyleAttributeName: textStyle};
        
        CGFloat textTextHeight = [textContent boundingRectWithSize: CGSizeMake(textRect.size.width, INFINITY) options: NSStringDrawingUsesLineFragmentOrigin attributes: textFontAttributes context: nil].size.height;
        
        [textContent drawInRect: CGRectMake(CGRectGetMinX(textRect), CGRectGetMinY(textRect) + (textRect.size.height - textTextHeight) / 2, textRect.size.width, textTextHeight) withAttributes: textFontAttributes];
    }
    
    
    // 6、获取当前画得的这张图片
    UIImage *final_image = UIGraphicsGetImageFromCurrentImageContext();
    // 7、关闭图形上下文
    UIGraphicsEndImageContext();
    return final_image;
}



/**
 *  长货架上的banner
 */
+ (void)createQR:(NSString *)string name:(NSString *)name logoImage:(UIImage *)logoImage{
    // 1.创建过滤器，这里的@"CIQRCodeGenerator"是固定的
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    // 2.恢复默认设置
    [filter setDefaults];
    
    
    [filter setValue:@"H" forKey:@"inputCorrectionLevel"];
    
    // 3. 给过滤器添加数据
    NSString *dataString = string;
    NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    // 注意，这里的value必须是NSData类型
    [filter setValue:data forKeyPath:@"inputMessage"];
    
    // 4. 生成二维码
    CIImage *outputImage = [filter outputImage];
    
    // 5. 显示二维码
    UIImage * image = [UIImage creatNonInterpolatedUIImageFormCIImage:outputImage withSize:10000];
    if (logoImage) {
        // 6. 添加logo到二维码
        image = [self addImage:logoImage atImage:image];
    }
    // 7. 添加二维码到背景图
    image = [self addQRImage:image IdStr:name];
    
    
    CGSize size = image.size;
    size.width *= 0.33353808*0.71949119;
    size.height *= 0.33353808*0.71949119; //没有为什么，一点一点试出来的数字
    UIGraphicsBeginImageContextWithOptions(size, YES, 4.167);
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    image = UIGraphicsGetImageFromCurrentImageContext();
    // 8、关闭图形上下文
    UIGraphicsEndImageContext();
    
    NSString * documentsDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    [self saveImage:image withFileName:name ofType:@"png" inDirectory:documentsDirectoryPath];
}

/**
 *  六宫格上的banner 添加二维码和文字
 */
+ (void)createSixQR:(NSString *)string name:(NSString *)name  logoImage:(UIImage *)logoImage{
    // 1.创建过滤器，这里的@"CIQRCodeGenerator"是固定的
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    // 2.恢复默认设置
    [filter setDefaults];
    
    
    [filter setValue:@"H" forKey:@"inputCorrectionLevel"];
    
    // 3. 给过滤器添加数据
    NSString *dataString = string;
    
    NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    // 注意，这里的value必须是NSData类型
    [filter setValue:data forKeyPath:@"inputMessage"];
    
    // 4. 生成二维码
    CIImage *outputImage = [filter outputImage];
    
    // 5. 从CIImage 创建高清二维码
    UIImage * image = [UIImage creatNonInterpolatedUIImageFormCIImage:outputImage withSize:10000];
    
    if (logoImage) {
        // 6. 给二维码添加logo
        image = [self addImage:logoImage atImage:image];
    }
    // 7. 讲二维码添加到背景图片上
    image = [self addQRImageToSix:image IdStr:name];
    
    CGSize size = image.size;
    size.width *= 0.7195;
    size.height *= 0.7195;
    UIGraphicsBeginImageContextWithOptions(size, YES, 4.167);
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    image = UIGraphicsGetImageFromCurrentImageContext();
    // 8、关闭图形上下文
    UIGraphicsEndImageContext();
    
    
    NSString * documentsDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    [self saveImage:image withFileName:name ofType:@"png" inDirectory:documentsDirectoryPath];
}

/**
 *  冰箱上的banner 添加二维码和文字
 */
+ (void)createRefrigeratorQR:(NSString *)string name:(NSString *)name  logoImage:(UIImage *)logoImage{
    // 1.创建过滤器，这里的@"CIQRCodeGenerator"是固定的
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    // 2.恢复默认设置
    [filter setDefaults];
    
    
    [filter setValue:@"H" forKey:@"inputCorrectionLevel"];
    
    // 3. 给过滤器添加数据
    NSString *dataString = string;
    NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    // 注意，这里的value必须是NSData类型
    [filter setValue:data forKeyPath:@"inputMessage"];
    
    // 4. 生成二维码
    CIImage *outputImage = [filter outputImage];
    
    // 5. 从CIImage 创建高清二维码
    UIImage * image = [UIImage creatNonInterpolatedUIImageFormCIImage:outputImage withSize:10000];
    if (logoImage) {
        // 6. 给二维码添加logo
        image = [self addImage:logoImage atImage:image];
    }
    // 7. 讲二维码添加到背景图片上
    image = [self addRefrigeratorQRImage:image IdStr:name];
    
    // 这里的0.7195 以及4.167 不要问我为什么，为了达到分辨率300，计算以及一点点测试修改得到的
    CGSize size = image.size;
    size.width *= 0.7195;
    size.height *= 0.7195;
    UIGraphicsBeginImageContextWithOptions(size, YES, 4.167);
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    image = UIGraphicsGetImageFromCurrentImageContext();
    // 8、关闭图形上下文
    UIGraphicsEndImageContext();
    
    
    NSString * documentsDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    [self saveImage:image withFileName:name ofType:@"png" inDirectory:documentsDirectoryPath];
}
@end

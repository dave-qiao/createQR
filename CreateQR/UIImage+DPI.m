//
//  UIImage+_00DPI.m
//  Demo
//
//  Created by white on 2017/9/11.
//  Copyright © 2017年 white. All rights reserved.
//

#import "UIImage+DPI.h"
#import <ImageIO/ImageIO.h>
#import <CoreImage/CoreImage.h>
#import "UIImage+Category.h"

@implementation UIImage (DPI)
/**
 * @brief 分辨率尺寸 这里的分辨率是乘于了image的scale
 */
- (CGSize)sizeToDpi {
    NSData *data = UIImagePNGRepresentation(self);
    CGImageSourceRef imageRef = CGImageSourceCreateWithData((__bridge CFDataRef)(data), NULL);
    CFDictionaryRef imagePropertiesDict = CGImageSourceCopyPropertiesAtIndex(imageRef, 0, NULL);
    CGFloat dpiHeight = [(NSString *)CFDictionaryGetValue(imagePropertiesDict, @"DPIHeight") floatValue];
    CGFloat dpiWidth = [(NSString *)CFDictionaryGetValue(imagePropertiesDict, @"DPIWidth") floatValue];
    return CGSizeMake(dpiWidth, dpiHeight);
}

/**
 * @brief 分辨率
 */
- (CGFloat)dpi {
    CGSize size = [self sizeToDpi];
    CGFloat dpi = MAX(size.width/self.scale, size.height/self.scale);
    return dpi == 0?72:dpi;
}

/**
 * @brief 厘米
 */
- (CGSize)sizeToCM {
    CGSize size = [self inchSize];
    size.width *= 2.54;
    size.height *= 2.54;
    return size;
}
/**
 * @brief 英寸
 */
- (CGSize)inchSize {
    CGFloat dpi = [self dpi];
    CGSize size = CGSizeMake(self.size.width * self.scale / dpi, self.size.height * self.scale / dpi);
    return size;
}

/**
 * @brief 生成300分辨率的图片
 */
- (UIImage *)dpi_300Image {
    return [self imageWithDpi:300.f];
}

/**
 * @brief 生成300分辨率的图片
 */
- (UIImage *)imageWithDpi:(CGFloat)dpi {
    UIImage *dpiImage = [UIImage imageWithCGImage:self.CGImage scale:dpi/[self dpi] orientation:UIImageOrientationUp];
    return dpiImage;
}

/**
 * @brief 保存到本地
 */
- (void)saveToLocal {
    NSString *name = [NSString stringWithFormat:@"%@",[NSDate date]];
    [self saveWithName:name];
}

/**
 * @brief 保存到本地 
 * @param name 文件名字
 */
- (void)saveWithName:(NSString *)name {
    if ([name containsString:@"."]) {
        NSMutableArray *array = [[name componentsSeparatedByString:@"."] mutableCopy];
        NSArray *imageFormarts = @[@"jpg",@"jpeg",@"png",@"bmp",@"iff",@"ilbm",@"tiff",@"tif",@"gif",@"mng",@"xpm",@"psd",@"sai",@"psp",@"ufo",@"xcf",@"pcx",@"ppm",@"WebP",@"ps",@"eps",@"pdf",@"ai",@"fh",@"swf",@"fla",@"svg",@"wmf",@"dxf",@"cgm"];
        for (NSInteger i = 0; i < imageFormarts.count; i++) {
            if ([[array lastObject] isEqualToString:imageFormarts[i]]) {
                [array removeLastObject];
                break;
            }
        }
        name = @"";
        for (NSInteger i = 0; i < array.count; i++) {
            name = [name stringByAppendingString:array[i]];
            name = [name stringByAppendingString:@"."];
        }
    }else {
        name = [name stringByAppendingString:@"."];
    }
    
    NSString * documentsDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [documentsDirectoryPath stringByAppendingString:[NSString stringWithFormat:@"/%@png",name]];
    NSLog(@"%@",path);
    [UIImagePNGRepresentation(self) writeToFile:path atomically:YES];
}

/**
 * @brief 生成size大小的图片,单位CM
 */
+ (UIImage *)imageWithCMSize:(CGSize)size {
    return [self imageWithInchSize:CGSizeMake(size.width/2.54, size.height/2.54)];
}

/**
 * @brief 生成size大小的图片,单位inch
 */
+ (UIImage *)imageWithInchSize:(CGSize)size {
    
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width*300, size.height*300);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [[UIColor whiteColor] CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    image = [image dpi_300Image];
    return image;
}

/**
 *  @brief  根据颜色生成纯色图片
 *
 *  @param color 颜色
 *
 *  @return 纯色图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}














/**
 * 给二维码加logo
 */
+ (UIImage *)addImage:(UIImage *)image atImage:(UIImage *)backImage {
    // 5、开启绘图, 获取图形上下文 (上下文的大小, 就是二维码的大小)
    UIGraphicsBeginImageContext(backImage.size);
    // 把二维码图片画上去 (这里是以图形上下文, 左上角为(0,0)点
    [backImage drawInRect:CGRectMake(0, 0, backImage.size.width, backImage.size.height)];
    //再把小图片画上去
    UIImage *sImage = image;
    
    CGFloat sImageW = 2500; //logo w
    CGFloat sImageH= 2757; // logo h
    CGFloat sImageX = (10000 - sImageW) * 0.5; //logo x
    CGFloat sImgaeY = (10000 - sImageH) * 0.5; //logo y
    
    [sImage drawInRect:CGRectMake(sImageX, sImgaeY, sImageW, sImageH)];
    // 6、获取当前画得的这张图片
    UIImage *final_image = UIGraphicsGetImageFromCurrentImageContext();
    // 7、关闭图形上下文
    UIGraphicsEndImageContext();
    return final_image;
}

/**
 *  保存图片
 */
+ (void) saveImage:(UIImage *)image withFileName:(NSString *)imageName ofType:(NSString *)extension inDirectory:(NSString *)directoryPath {
    
    if ([[extension lowercaseString] isEqualToString:@"png"]) {
        
        [UIImagePNGRepresentation(image) writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"png"]] options:NSAtomicWrite error:nil];
        
    } else if ([[extension lowercaseString] isEqualToString:@"jpg"] || [[extension lowercaseString] isEqualToString:@"jpeg"]) {
        
        [UIImageJPEGRepresentation(image, 1.0) writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"jpg"]] options:NSAtomicWrite error:nil];
        
    } else {
        
        //ALog(@"Image Save Failed\nExtension: (%@) is not recognized, use (PNG/JPG)", extension);
        
        NSLog(@"文件后缀不认识");
        
    }
}

+ (UIImage *)createQRImageWithContent:(NSString *)content logoImage:(UIImage *)logoImage {
    // 1.创建过滤器，这里的@"CIQRCodeGenerator"是固定的
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    // 2.恢复默认设置
    [filter setDefaults];
    
    
    [filter setValue:@"H" forKey:@"inputCorrectionLevel"];
    
    // 3. 给过滤器添加数据
    NSData *data = [content dataUsingEncoding:NSUTF8StringEncoding];
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
    
    return image;
}

+ (UIImage *)addRefrigeratorQRImage:(UIImage *)QRImage
                            qrframe:(CGRect)qrframe
                             string:(NSString *)string
                        stringFrame:(CGRect)stringframe
                            atImage:(UIImage *)bgImgae{
    UIGraphicsBeginImageContext(CGSizeMake(CGImageGetWidth(bgImgae.CGImage), CGImageGetHeight(bgImgae.CGImage)));
    qrframe = CGRectMake(qrframe.origin.x, qrframe.origin.y, qrframe.size.width, qrframe.size.height);
    if (string) {
        stringframe = CGRectMake(stringframe.origin.x, stringframe.origin.y, stringframe.size.width, stringframe.size.height);
    }
    
    // 把banner背景图片画上去 (这里是以图形上下文, 左上角为(0,0)点
    [bgImgae drawInRect:CGRectMake(0, 0, CGImageGetWidth(bgImgae.CGImage), CGImageGetHeight(bgImgae.CGImage))];
    
    //再把二维码画上去
    UIImage *sImage = QRImage;
    [sImage drawInRect:qrframe];
    if (string.length > 0) {
        // 添加文字
        CGRect textRect = stringframe;
        {
            NSString* textContent = string;
            NSMutableParagraphStyle* textStyle = [[NSMutableParagraphStyle alloc] init];
            textStyle.alignment = NSTextAlignmentCenter;
            NSDictionary* textFontAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:36], NSForegroundColorAttributeName: UIColor.blackColor, NSParagraphStyleAttributeName: textStyle};
            
            CGFloat textTextHeight = [textContent boundingRectWithSize: CGSizeMake(textRect.size.width, INFINITY) options: NSStringDrawingUsesLineFragmentOrigin attributes: textFontAttributes context: nil].size.height;
            
            [textContent drawInRect: CGRectMake(CGRectGetMinX(textRect), CGRectGetMinY(textRect) + (textRect.size.height - textTextHeight) / 2, textRect.size.width, textTextHeight) withAttributes: textFontAttributes];
        }
    }
    
    // 6、获取当前画得的这张图片
    UIImage *final_image = UIGraphicsGetImageFromCurrentImageContext();
    // 7、关闭图形上下文
    UIGraphicsEndImageContext();
    return final_image;
}

+ (UIImage *)insetQRImage:(NSString *)qrstring
             atImage:(UIImage *)bgImage
             qrFrame:(CGRect )qrframe
           logoImage:(UIImage *)logoImage
              string:(NSString *)string
         stringFrame:(CGRect)stringframe
            fileName:(NSString *)fileName
{
    return [self insetQRImage:qrstring atImage:bgImage qrFrame:qrframe logoImage:logoImage string:string stringFrame:stringframe fileName:fileName savePath:nil];
}

+ (UIImage *)insetQRImage:(NSString *)qrstring
                  atImage:(UIImage *)bgImage
                  qrFrame:(CGRect )qrframe
                logoImage:(UIImage *)logoImage
                   string:(NSString *)string
              stringFrame:(CGRect)stringframe
                 fileName:(NSString *)fileName
                 savePath:(NSString *)savePath {
    if (!savePath) {
        savePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    }
    // 生成二维码(二维码logo在方法内设置)
    UIImage *image = [self createQRImageWithContent:qrstring logoImage:logoImage];
    // 二维码添加到背景图片上
    image = [self addRefrigeratorQRImage:image qrframe:qrframe string:string stringFrame:stringframe atImage:bgImage];
    // 转换到300dpi
    image = [image dpi_300Image];
//    image = [image imageWithDpi:300.f]; //这个是穿参的写法
    // 保存图片
    [self saveImage:image withFileName:fileName ofType:@"png" inDirectory:savePath];
    NSLog(@"%@",savePath);
    return image;
}

@end

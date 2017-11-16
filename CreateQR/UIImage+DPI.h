//
//  UIImage+_00DPI.h
//  Demo
//
//  Created by white on 2017/9/11.
//  Copyright © 2017年 white. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (DPI)

/**
 * @brief 分辨率尺寸 这里的分辨率是乘于了image的scale
 */
- (CGSize)sizeToDpi;

/**
 * @brief 分辨率
 */
- (CGFloat)dpi;

/**
 * @brief 厘米
 */
- (CGSize)sizeToCM;

/**
 * @brief 英寸
 */
- (CGSize)inchSize;

/**
 * @brief 生成300分辨率的图片
 */
- (UIImage *)dpi_300Image;

/**
 * @brief 生成300分辨率的图片
 */
- (UIImage *)imageWithDpi:(CGFloat)dpi;

/**
 * @brief 保存到本地
 */
- (void)saveToLocal;

/**
 * @brief 保存到本地
 * @param name 文件名字
 */
- (void)saveWithName:(NSString *)name;

/**
 * @brief 生成size大小的图片,单位CM
 */
+ (UIImage *)imageWithCMSize:(CGSize)size;

/**
 * @brief 生成size大小的图片,单位inch
 */
+ (UIImage *)imageWithInchSize:(CGSize)size;

/**
 * 给二维码加logo
 */
+ (UIImage *)addImage:(UIImage *)image atImage:(UIImage *)backImage;
/**
 * @brief 保存图片
 */
+ (void) saveImage:(UIImage *)image withFileName:(NSString *)imageName ofType:(NSString *)extension inDirectory:(NSString *)directoryPath;
/**
 * @brief 创建二维码
 */
+ (UIImage *)createQRImageWithContent:(NSString *)content logoImage:(UIImage *)logoImage;
/**
 * @brief 添加二维码和文字
 */
+ (UIImage *)addRefrigeratorQRImage:(UIImage *)QRImage
                            qrframe:(CGRect)qrframe
                             string:(NSString *)string
                        stringFrame:(CGRect)stringframe
                            atImage:(UIImage *)bgImgae;

/**
 * @brief 创建300dpi的合成图片
 */
+ (UIImage *)insetQRImage:(NSString *)qrstring
             atImage:(UIImage *)bgImage
             qrFrame:(CGRect )qrframe
           logoImage:(UIImage *)logoImage
              string:(NSString *)string
         stringFrame:(CGRect)stringframe
            fileName:(NSString *)fileName;

+ (UIImage *)insetQRImage:(NSString *)qrstring
                  atImage:(UIImage *)bgImage
                  qrFrame:(CGRect )qrframe
                logoImage:(UIImage *)logoImage
                   string:(NSString *)string
              stringFrame:(CGRect)stringframe
                 fileName:(NSString *)fileName
                 savePath:(NSString *)savePath;
@end

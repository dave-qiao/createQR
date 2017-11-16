//
//  UIImage+Category.h
//  CreateQR
//
//  Created by white on 2017/5/24.
//  Copyright © 2017年 white. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Category)
+ (UIImage *)creatNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat)size;
@end

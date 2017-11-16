//
//  ViewController.m
//  CreateQR
//
//  Created by white on 2017/5/24.
//  Copyright © 2017年 white. All rights reserved.
//

#import "ViewController.h"
#import <CoreImage/CoreImage.h>
#import "UIImage+Category.h"
#import "UIImage+DPI.h"
#import "UIImage+QH.h"

typedef enum : NSUInteger {
    DaHuoGui,
    LiuGongGe,
    BingGui,
} CreateType;

@interface ViewController ()
@property (nonatomic, strong) UIImage *logoImage;

@property (nonatomic,   copy) NSArray *qrContents;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 单个测试
    self.logoImage = [UIImage imageNamed:@"logo"];
    NSString *name = [NSString stringWithFormat:@"%@",@([[NSDate date] timeIntervalSince1970])];
    [UIImage insetQRImage:@"http://weixin.qq.com"//二维码内容
               atImage:[UIImage imageNamed:@"BingGui"]//背景图片
               qrFrame:CGRectMake(4823, 545, 1362, 1362)//二维码的位置大小
                logoImage:self.logoImage//logo
                string:@"LB123456"//需要添加的文字
           stringFrame:CGRectMake(5409, 1905, 200, 36)// 文字的位置大小
              fileName:@"LB123456"];// 文件保存名字

    // 批量
    // self.logoImage = [UIImage imageNamed:@"logo"];
    
    // NSData *data = [[NSData alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"DaHuoGui" ofType:@"json"]];
    // self.qrContents = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    // [self createImageAtIndex:@(0)];
}

- (void)createImageAtIndex:(NSNumber *)index {
    if (index.integerValue >= self.qrContents.count) {
        return;
    }
    NSDictionary *dic = self.qrContents[index.integerValue];
    NSString *name = dic[@"hc"];//保存的名字
    NSString *content = dic[@"qr"];//二维码内容
    NSLog(@"%@",content);
    // NSString *number = [NSString stringWithFormat:@"%@",index];
    UIImage *image = [UIImage insetQRImage:content//二维码内容
                  atImage:[UIImage imageNamed:@"BingGui"]//背景图片
                  qrFrame:CGRectMake(4823, 545, 1362, 1362)//二维码的位置大小
                logoImage:self.logoImage//logo
                   string:name//需要添加的文字
              stringFrame:CGRectMake(5409, 1905, 200, 36)// 文字的位置大小
                 fileName:name];// 文件保存名字
    image = nil;
    [self performSelector:@selector(createImageAtIndex:) withObject:@(index.integerValue + 1) afterDelay:.5];
}


- (void)quhuoCreate {
    NSData *data;
    
    CreateType type;
    
    //    type = DaHuoGui;//大货柜
    //    type = LiuGongGe;//六宫格
    type = BingGui;//冰柜
    
    switch (type) {
        case DaHuoGui:
            data = [[NSData alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"DaHuoGui" ofType:@"json"]];
            break;
        case LiuGongGe:
            data = [[NSData alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"LiuGongGe" ofType:@"json"]];
            break;
        case BingGui:
            data = [[NSData alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"BingGui" ofType:@"json"]];
            break;
        default:
            break;
    }
    
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    for (int i = 0; i < array.count; i++) {
        NSDictionary *dic = array[i];
        /**
         * 店的编号
         */
        NSString *name = [NSString stringWithFormat:@"%@",dic[@"scene_id"]];
        /**
         * 二维码内容
         */
        NSString *content = dic[@"url"];
        
        switch (type) {
            case DaHuoGui:
                [UIImage createQR:content name:name logoImage:self.logoImage];
                break;
            case LiuGongGe:
                [UIImage createSixQR:content name:name logoImage:self.logoImage];
                break;
            case BingGui:
                [UIImage createRefrigeratorQR:content name:name logoImage:self.logoImage];
                break;
            default:
                break;
        }
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

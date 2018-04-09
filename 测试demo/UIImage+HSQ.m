//
//  UIImage+HSQ.m
//  测试demo
//
//  Created by administrator on 2018/4/6.
//  Copyright © 2018年 administrator. All rights reserved.
//

#import "UIImage+HSQ.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation UIImage (HSQ)

+ (void)load{
    
    NSLog(@"1111111111");
    
    // 获取ImageWithName方法的地址
    Method imageWithName = class_getClassMethod(self, @selector(imageWithName:));
    
    // 获取imageNamed方法的地址
    Method imageNamed = class_getClassMethod(self, @selector(imageNamed:));
    
    // 交换方法的地址，相当于交流实现的方式
    method_exchangeImplementations(imageWithName, imageNamed);

}

+ (instancetype)imageWithName:(NSString *)name{
    
    NSLog(@"========2222");
    
    UIImage *image = [self imageWithName:name];
    
    if (image == nil)
    {
        NSLog(@"图片时空的");
    }
    else
    {
        NSLog(@"=====");
    }
    
    return image;
}

@end

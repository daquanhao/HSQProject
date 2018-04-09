//
//  HSQCustomTextView.m
//  测试demo
//
//  Created by administrator on 2018/4/8.
//  Copyright © 2018年 administrator. All rights reserved.
//

/********************** 特别注意 **************************/

// UITextView的光标的位置及大小

// IphoneX (4, 7, 2, 19.666666)

// Iphone 7 plus (4, 7, 2, 21.66666)

// iphone 7 (4, 7, 2, 19.5)

// iphone SE (4, 7, 2, 17)

// 综上所述：光标的高度会根据UITextView里面文字的大小而改变。

#define KPlaceholderX 6
#define KPlaceholderY 7

#import "HSQCustomTextView.h"

@implementation HSQCustomTextView

/**
 * @brief 初始化视图
 */
- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        // 当UITextView的文字发生改变时，UITextView自己会发出一个UITextViewTextDidChangeNotification通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:self];
    }
    
    return self;
}

/**
 * @brief 重写提示文字
 */
- (void)setPlaceholder:(NSString *)placeholder{
    
    _placeholder = placeholder;
    
    [self setNeedsDisplay];
}

/**
 * @brief 重写提示文字的颜色
 */
- (void)setPlaceholderColor:(UIColor *)placeholderColor{
    
    _placeholderColor = placeholderColor;
    
    [self setNeedsDisplay];
}

/**
 * @brief 重写输入的文字
 */
- (void)setText:(NSString *)text{
    
    [super setText:text];
    
    // setNeedsDisplay 会在下一个消息循环的时候，调用drawRect方法
    [self setNeedsDisplay];
}

/**
 * @brief 重写文字的大小
 */
- (void)setFont:(UIFont *)font{
    
    [super setFont:font];
    
    [self setNeedsDisplay];
}

/**
 * @brief 监听文字的变化
 */
- (void)textChange{
    
    [self setNeedsDisplay];
}

/**
 * @brief 使用drawRect方法重画提示文字
 */
- (void)drawRect:(CGRect)rect {
    
    // 1.判断文字有没有改变
    if (self.hasText) return;
    
    NSMutableDictionary *diction = [NSMutableDictionary dictionary];
    
    diction[NSFontAttributeName] = self.font;
    
    diction[NSForegroundColorAttributeName] = self.placeholderColor ? self.placeholderColor : [UIColor grayColor];
    
    [self.placeholder drawInRect:CGRectMake(KPlaceholderX, KPlaceholderY, self.frame.size.width - 2 * KPlaceholderX, self.frame.size.height - 2 * KPlaceholderY) withAttributes:diction];

}

/**
 * @brief 当视图销毁的时候，移除消息通知
 */
- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}













@end

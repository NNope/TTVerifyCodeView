//
//  TTVerifyCodeView.h
//  TTVerifyCodeField
//
//  Created by 谈Xx on 2018/2/27.
//  Copyright © 2018年 谈Xx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VerifyCodeField.h"

typedef NS_OPTIONS(NSUInteger, FieldBorderType) {
    FieldBorderTypeDefault = 0,
    FieldBorderTypeHighlight = 1,
    FieldBorderTypeNone = 2,
};

@class TTVerifyCodeView;
@protocol TTVerifyCodeViewDelegate <NSObject>

/**
 验证码输入完成后的回调

 @param verifyCodeView verifyCodeView
 @param codeString codeString
 */
- (void)verifyCodeViewDidFinshed:(TTVerifyCodeView *)verifyCodeView CodeString:(NSString *)codeString;
@end

@interface TTVerifyCodeView : UIView<VerifyCodeFieldDeleteDelegate>

/**
 验证码长度 默认6位
 */
@property (nonatomic, assign) IBInspectable int CodeCount;

/**
 验证码边框颜色
 */
@property (nonatomic, strong) IBInspectable UIColor *normalColor;

/**
 验证码边框高亮颜色
 */
@property (nonatomic, strong) IBInspectable UIColor *highlightColor;

/**
 验证码光标颜色 默认与normalColor一致
 FieldBorderTypeNone时 默认无光标，可单独设置
 */
@property (nonatomic, strong) IBInspectable UIColor *cursorColor;

/**
 验证码字符颜色 默认黑色
 */
@property (nonatomic, strong) IBInspectable UIColor *codeColor;

/**
 验证码字体大小 默认26
 */
@property (nonatomic, assign) IBInspectable CGFloat fontSize;

/**
 验证码控件风格
 */
@property (nonatomic, assign) IBInspectable FieldBorderType fieldBorderType;

/**
 FieldBorderTypeNone时的验证码间距 默认为10
 */
@property (nonatomic, assign) IBInspectable CGFloat margin;

/**
 代理对象
 */
@property (nonatomic, weak) IBOutlet id<TTVerifyCodeViewDelegate> delegate;

/**
 当前输入的验证码
 */
@property (nonatomic, strong) NSString *codeString;

/**
 实例方法 创建一个TTVerifyCodeView

 @param type BorderType
 @param normalColor normalColor
 @param highlightColor highlightColor
 @return TTVerifyCodeView
 */
- (instancetype)initWithFieldBorderType:(FieldBorderType)type NormalColor:(UIColor *)normalColor HighlightColor:(UIColor *)highlightColor;

/**
 类方法 创建一个TTVerifyCodeView

 @param type BorderType
 @param normalColor normalColor
 @param highlightColor highlightColor
 @return TTVerifyCodeView
 */
+ (instancetype)verifyCodeViewBorderType:(FieldBorderType)type NormalColor:(UIColor *)normalColor HighlightColor:(UIColor *)highlightColor;

/**
 创建一个Default风格的TTVerifyCodeView
 */
+ (instancetype)verifyCodeViewBorderTypeDefaultNormalColor:(UIColor *)normalColor HighlightColor:(UIColor *)highlightColor CursorColor:(UIColor *)cursorColor CodeColor:(UIColor *)codeColor;

/**
 创建一个Highlight风格的TTVerifyCodeView
 */
+ (instancetype)verifyCodeViewBorderTypeHighlightNormalColor:(UIColor *)normalColor HighlightColor:(UIColor *)highlightColor CursorColor:(UIColor *)cursorColor CodeColor:(UIColor *)codeColor;

/**
 创建一个None风格的TTVerifyCodeView
 */
+ (instancetype)verifyCodeViewBorderTypeNoneNormalColor:(UIColor *)normalColor CursorColor:(UIColor *)cursorColor CodeColor:(UIColor *)codeColor Margin:(CGFloat)margin;
@end

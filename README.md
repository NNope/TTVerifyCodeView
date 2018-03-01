# TTVerifyCodeView
短信验证码输入控件

### 提供三种风格的短信验证码输入控件
![WX20180301-115523@2x.png](http://upload-images.jianshu.io/upload_images/810907-ed569ab4d5f0b820.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![WX20180301-115557@2x.png](http://upload-images.jianshu.io/upload_images/810907-3c5c16b12e58dfc0.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![WX20180301-115857@2x.png](http://upload-images.jianshu.io/upload_images/810907-73c8b78dc8a73737.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 支持以下属性设置

```objc
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

```

### 1.代码使用
```objc
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
```
### 2.IB使用方式

1. 支持各属性设置

![WX20180301-120419@2x.png](http://upload-images.jianshu.io/upload_images/810907-da09e683d2f90854.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

2. type属性需要手动增加keypath，使用数字进行对应枚举值的设置

![WX20180301-120438@2x.png](http://upload-images.jianshu.io/upload_images/810907-cee847c3c6272ab8.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

3. delegate的设置
![WX20180301-120634@2x.png](http://upload-images.jianshu.io/upload_images/810907-971c668e90048d4d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

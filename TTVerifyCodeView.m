//
//  TTVerifyCodeView.m
//  TTVerifyCodeField
//
//  Created by 谈Xx on 2018/2/27.
//  Copyright © 2018年 谈Xx. All rights reserved.
//

#import "TTVerifyCodeView.h"

@interface TTVerifyCodeView()
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) NSMutableArray *arrCodeField;
@end

@implementation TTVerifyCodeView

- (instancetype)initWithFieldBorderType:(FieldBorderType)type NormalColor:(UIColor *)normalColor HighlightColor:(UIColor *)highlightColor
{
    self = [super init];
    if (self) {
        [self defaultConfig];
        self.normalColor = normalColor;
        self.highlightColor = highlightColor;
        self.fieldBorderType = type;
    }
    return self;
}

+ (instancetype)verifyCodeViewBorderType:(FieldBorderType)type NormalColor:(UIColor *)normalColor HighlightColor:(UIColor *)highlightColor;
{
    TTVerifyCodeView *codeview = [[TTVerifyCodeView alloc] initWithFieldBorderType:type NormalColor:normalColor HighlightColor:highlightColor];
    return codeview;
}

+ (instancetype)verifyCodeViewBorderTypeDefaultNormalColor:(UIColor *)normalColor HighlightColor:(UIColor *)highlightColor CursorColor:(UIColor *)cursorColor CodeColor:(UIColor *)codeColor;
{
    TTVerifyCodeView *codeview = [self verifyCodeViewBorderType:FieldBorderTypeDefault NormalColor:normalColor HighlightColor:highlightColor];
    codeview.cursorColor = cursorColor?:codeview.cursorColor;
    codeview.codeColor = codeColor?:codeview.codeColor;
    return codeview;
}

+ (instancetype)verifyCodeViewBorderTypeHighlightNormalColor:(UIColor *)normalColor HighlightColor:(UIColor *)highlightColor CursorColor:(UIColor *)cursorColor CodeColor:(UIColor *)codeColor;
{
    TTVerifyCodeView *codeview = [self verifyCodeViewBorderType:FieldBorderTypeHighlight NormalColor:normalColor HighlightColor:highlightColor];
    codeview.cursorColor = cursorColor?:codeview.cursorColor;
    codeview.codeColor = codeColor?:codeview.codeColor;
    return codeview;
}

+ (instancetype)verifyCodeViewBorderTypeNoneNormalColor:(UIColor *)normalColor CursorColor:(UIColor *)cursorColor CodeColor:(UIColor *)codeColor Margin:(CGFloat)margin;
{
    TTVerifyCodeView *codeview = [self verifyCodeViewBorderType:FieldBorderTypeNone NormalColor:normalColor HighlightColor:nil];
    codeview.margin = margin;
    codeview.cursorColor = cursorColor?:codeview.cursorColor;
    codeview.codeColor = codeColor?:codeview.codeColor;
    return codeview;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self defaultConfig];
    }
    return self;
}

- (void)defaultConfig
{
    self.fieldBorderType = FieldBorderTypeDefault;
    self.CodeCount = 6;
    self.arrCodeField = [NSMutableArray array];
    self.codeString = @"";
    self.fontSize = 26;
    self.codeColor = [UIColor blackColor];
}

-(void)setFieldBorderType:(FieldBorderType)fieldBorderType
{
    _fieldBorderType = fieldBorderType;
    if (fieldBorderType == FieldBorderTypeNone)
    {
        self.margin = 10;
        self.cursorColor = [UIColor clearColor];
    }
    else
    {
        self.cursorColor = self.normalColor;
    }
}

-(void)layoutSubviews
{
    if (self.arrCodeField.count == 0)
    {
        CGFloat width = (self.bounds.size.width - (self.CodeCount-1)*self.margin) / self.CodeCount;
        for (int i = 0; i < self.CodeCount; i++)
        {
            VerifyCodeField *td = [[VerifyCodeField alloc] init];
            td.lblCode.font = [UIFont systemFontOfSize:self.fontSize];
            td.tintColor = self.cursorColor;
            
            td.frame = CGRectMake(i * (width+self.margin), 0, width, self.bounds.size.height);
            td.lblCode.textColor = self.codeColor;
            td.tag = 1000+i;
            td.textAlignment = NSTextAlignmentCenter;
            td.deleteDelegate = self;
            [td addTarget:self action:@selector(textFieldTextChange:) forControlEvents:UIControlEventEditingChanged];
            
            [self addSubview:td];
            [self.arrCodeField addObject:td];
            
            // 加线
            switch (self.fieldBorderType)
            {
                case FieldBorderTypeDefault:
                {
                    if (i == 0)
                    {
                        [td borderForColor:self.highlightColor borderWidth:1 borderType:UIBorderSideTypeLeft|UIBorderSideTypeTop|UIBorderSideTypeBottom];
                    }
                    else
                    {
                        if (i == self.CodeCount - 1)
                        {
                            [td borderForColor:self.highlightColor borderWidth:1 borderType:UIBorderSideTypeRight|UIBorderSideTypeTop|UIBorderSideTypeBottom];
                        }
                        else
                        {
                            [td borderForColor:self.highlightColor borderWidth:1 borderType:UIBorderSideTypeTop|UIBorderSideTypeBottom];
                        }
                        [td borderForColor:self.normalColor borderWidth:1 borderType:UIBorderSideTypeLeft];
                    }
                    
                }
                    break;
                case FieldBorderTypeHighlight:
                {
                    if (i == 0)
                    {
                        [td borderForColor:self.normalColor borderWidth:1 borderType:UIBorderSideTypeAll];
                    }
                    else
                    {
                        [td borderForColor:self.normalColor borderWidth:1 borderType:UIBorderSideTypeRight|UIBorderSideTypeTop|UIBorderSideTypeBottom];
                    }
                }
                    break;
                case FieldBorderTypeNone:
                {
                     [td borderForColor:self.normalColor borderWidth:2 borderType:UIBorderSideTypeBottom];
                }
                    break;
                    
                default:
                    break;
            }
        }
        UIView *tapView = [[UIView alloc] initWithFrame:self.bounds];
        [tapView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(beginEditting)]];
        [self addSubview:tapView];
        
    }
}

- (void)beginEditting
{
    NSInteger index = self.codeString.length;
    
    if ( index == self.CodeCount)
    {
        index = self.CodeCount-1;
    }
    [self becomeNextResponder:index];
}

// 指定该索引的控件被激活
- (void)becomeNextResponder:(NSInteger)index
{
    VerifyCodeField *next = self.arrCodeField[index];
    // 高亮风格 设置高亮边框
    if (self.fieldBorderType == FieldBorderTypeHighlight)
    {
        [self updateFieldBorderIsHighlight:YES TextField:next CurrentIndex:index];
    }
    self.currentIndex = index;
    [next becomeFirstResponder];
}

- (void)textFieldTextChange:(VerifyCodeField *)textField
{
    self.codeString = @"";
    [self.arrCodeField enumerateObjectsUsingBlock:^(VerifyCodeField *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.text.length > 0)
        {
            NSString *code = [obj.text substringToIndex:1];
            obj.lblCode.text = code;
            self.codeString = [self.codeString stringByAppendingString:code];
        }
        else
        {
            obj.lblCode.text = @"";
        }
    }];
    // 移动光标
    NSInteger index = self.codeString.length;
    // 高亮风格 移除当前高亮
    if (self.fieldBorderType == FieldBorderTypeHighlight)
    {
        [self updateFieldBorderIsHighlight:NO TextField:textField CurrentIndex:index];
    }
    if ( index < self.CodeCount)
    {
        [self becomeNextResponder:index];
    }
    else if (index == self.CodeCount)
    {
        [self endEditing:YES];
        if (self.delegate && [self.delegate respondsToSelector:@selector(verifyCodeViewDidFinshed:CodeString:)])
        {
            [self.delegate verifyCodeViewDidFinshed:self CodeString:self.codeString];
        }
    }
}

- (void)updateFieldBorderIsHighlight:(BOOL)isHighlight TextField:(VerifyCodeField *)textfield CurrentIndex:(NSInteger)currentIndex
{
    [textfield removeBorderLayer];
    UIColor *color = isHighlight?self.highlightColor:self.normalColor;

    UIBorderSideType type;
    if (self.currentIndex > currentIndex)
    {
        type = isHighlight?UIBorderSideTypeAll:UIBorderSideTypeTop|UIBorderSideTypeRight|UIBorderSideTypeBottom;
    }
    else
    {
        if (!isHighlight && (textfield.tag - 1000) != self.CodeCount-1)
        {
            type = UIBorderSideTypeTop|UIBorderSideTypeLeft|UIBorderSideTypeBottom;
        }
        else
        {
            type = UIBorderSideTypeAll;
        }
    }
    
    [textfield borderForColor:color borderWidth:1 borderType:type];
}

// 后退删除键处理
-(void)verifyCodeFieldDeleteBackwardClicked:(VerifyCodeField *)verifyCodeField
{
    if (verifyCodeField.text.length > 0)
    {
        verifyCodeField.text = @"";
    }
    else
    {
        // 找到当前控件的索引
        NSUInteger index = [self.arrCodeField indexOfObjectPassingTest:^BOOL(VerifyCodeField *  _Nonnull field, NSUInteger idx, BOOL * _Nonnull stop) {
            return field.tag == verifyCodeField.tag;
        }];
        if (index==0)
        {
            return;
        }
        else
        {
            // 删除上一个控件的字符
            VerifyCodeField *previous = self.arrCodeField[index-1];
            previous.text = @"";
        }
    }
    // 更新字符显示和UI
    [self textFieldTextChange:verifyCodeField];
}



@end

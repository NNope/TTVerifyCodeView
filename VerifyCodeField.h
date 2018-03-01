//
//  VerifyCodeField.h
//  TTVerifyCodeField
//
//  Created by 谈Xx on 2018/2/27.
//  Copyright © 2018年 谈Xx. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, UIBorderSideType) {
    UIBorderSideTypeAll = 0,
    UIBorderSideTypeTop = 1 << 0,
    UIBorderSideTypeBottom = 1 << 1,
    UIBorderSideTypeLeft = 1 << 2,
    UIBorderSideTypeRight = 1 << 3,
};

@class VerifyCodeField;
@protocol VerifyCodeFieldDeleteDelegate <NSObject>
- (void)verifyCodeFieldDeleteBackwardClicked:(VerifyCodeField *)verifyCodeField;
@end

@interface VerifyCodeField : UITextField
@property (nonatomic, strong) UILabel *lblCode;
@property (nonatomic, weak) id<VerifyCodeFieldDeleteDelegate> deleteDelegate;

- (void)removeBorderLayer;
- (void)borderForColor:(UIColor *)color borderWidth:(CGFloat)borderWidth borderType:(UIBorderSideType)borderType;

@end

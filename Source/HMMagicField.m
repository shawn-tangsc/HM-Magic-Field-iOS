//
//  BHBMagicField.m
//  BHBMagicFieldDemo
//
//  Created by bihongbo on 15/12/29.
//  Copyright © 2015年 bihongbo. All rights reserved.
//

#import "HMMagicField.h"

@interface HMMagicField ()

@property (nonatomic,copy) NSString * placeholderText;
@property (nonatomic,strong) UIFont * placeholderFont;
@property (nonatomic,strong) UIColor * placeholderColor;
@property (nonatomic,strong) UILabel * placeholderAnimationLbl;
@property (nonatomic,strong) NSAttributedString * placeHolderAttributedString;

@end

@implementation HMMagicField
/**
    根据传入的frame初始化。
 
 */
- (instancetype)init
{
    self = [super init];
    if (self) {
        _placeholdAnimationable = YES;
        self.placeholderAnimationLbl = [[UILabel alloc] initWithFrame:self.bounds];
        self.placeholderAnimationLbl.userInteractionEnabled = NO;
        self.placeholderAnimationLbl.font = self.font;
        self.placeholderFont = self.font;
        self.placeholderAnimationLbl.textColor = [UIColor lightGrayColor];
        self.placeholderColor = self.placeholderAnimationLbl.textColor;
        self.animationColor = self.placeholderColor;
        self.animationFont = self.placeholderFont;
        self.placeholderAnimationLbl.textAlignment = NSTextAlignmentLeft;
        self.moveDistance = self.frame.size.height;
        self.clipsToBounds = NO;
        [self addSubview:self.placeholderAnimationLbl];

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeEditing) name:UITextFieldTextDidChangeNotification object:nil];

    }
    return self;
}

- (CGRect)textRectForBounds:(CGRect)bounds
{
    bounds.size.width -= self.padding.left + self.border.left;
    bounds.origin.x += self.padding.left + self.border.left;
    
    bounds.size.height -= self.padding.top + self.border.top;
    bounds.origin.y += self.padding.top + self.border.top;
    
    bounds.size.width -= self.padding.right + self.border.right;
    
    bounds.size.height -= self.padding.bottom + self.border.bottom;
    
    return bounds;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



- (void)layoutSubviews{
    [super layoutSubviews];
}

- (void)setText:(NSString *)text{
    [super setText:text];
    if (text.length > 0) {
        [self upAnimation];
    }else{
        [self restoreAnimation];
    }
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    if (self.text.length > 0  || [self isFirstResponder]) {
        self.placeholderAnimationLbl.frame =  self.placeholderAnimationLbl.frame;
    }else{
        self.placeholderAnimationLbl.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    }
    if (self.moveDistance == 0) {
        self.moveDistance = frame.size.height / 2;
    }
}

- (void)setFont:(UIFont *)font{
    [super setFont:font];
    self.placeholderFont = font;
    self.placeholderAnimationLbl.font = self.font;
    
}


/**
 *  文字提醒set方法
 *
 */
-(void)setPlaceholder:(NSString *)placeholder
{
    _placeholderText = placeholder;
    self.placeholderAnimationLbl.text = placeholder;
}

- (void)setAttributedPlaceholder:(NSAttributedString *)attributedPlaceholder{
    _placeHolderAttributedString = attributedPlaceholder;
    self.placeholderAnimationLbl.attributedText = attributedPlaceholder;
}


- (BOOL)becomeFirstResponder{
    [self upAnimation];
    return [super becomeFirstResponder];
}

- (BOOL)resignFirstResponder{
    [self restoreAnimation];
    return [super resignFirstResponder];
}

-(void)changeEditing
{
    if (!self.placeholdAnimationable) {
        if ([self.text isEqualToString:@""]) {
            self.placeholderAnimationLbl.hidden = NO;
        }
        else
        {
            self.placeholderAnimationLbl.hidden = YES;
        }
    }else{
        self.placeholderAnimationLbl.hidden = NO;
    }
    
}

- (void)upAnimation{
    if (self.placeholdAnimationable) {
        CGRect targetFrame = self.placeholderAnimationLbl.frame;
        targetFrame.origin.y = - self.moveDistance;
        [UIView animateWithDuration:.25 animations:^{
            self.placeholderAnimationLbl.frame = targetFrame;
            self.placeholderAnimationLbl.textColor = self.animationColor;
            self.placeholderAnimationLbl.font = self.animationFont;
        }];
    }
}

- (void)restoreAnimation{
    if (self.placeholdAnimationable) {
        if (self.text.length > 0 || self.placeholderAnimationLbl.frame.origin.y == 0) {
            return ;
        }
        CGRect targetFrame = self.placeholderAnimationLbl.frame;
        targetFrame.origin.y = 0;
        [UIView animateWithDuration:.25 animations:^{
            self.placeholderAnimationLbl.frame = targetFrame;
            self.placeholderAnimationLbl.textColor = self.placeholderColor;
            self.placeholderAnimationLbl.font = self.placeholderFont;
            if (self.placeHolderAttributedString) {
                self.placeholderAnimationLbl.attributedText = self.placeHolderAttributedString;
            }
        }];
    }

}

@end

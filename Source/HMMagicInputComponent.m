//
//  HMMagicInputComponent.m
//  axxtClientApp
//
//  Created by 唐嗣成 on 2018/6/25.
//  Copyright © 2018年 axxt. All rights reserved.
//

#import "HMMagicInputComponent.h"
#import "HMMagicField.h"
#import "WXConvert.h"
#import <WeexPluginLoader/WeexPluginLoader.h>
WX_PlUGIN_EXPORT_COMPONENT(hm-magic-input,HMMagicInputComponent);


@interface HMMagicInputComponent()

@property (nonatomic, strong) HMMagicField *inputView;
@property (nonatomic, assign) BOOL allowCopyPaste;
@property (nonatomic, assign) CGFloat animationFont;
@property (nonatomic, assign) CGFloat moveDistance;

@end
@implementation HMMagicInputComponent


- (instancetype)initWithRef:(NSString *)ref type:(NSString *)type styles:(NSDictionary *)styles attributes:(NSDictionary *)attributes events:(NSArray *)events weexInstance:(WXSDKInstance *)weexInstance{
    if (self = [super initWithRef:ref type:type styles:styles attributes:attributes events:events weexInstance:weexInstance]) {
        _allowCopyPaste = YES;
        if (attributes[@"allowCopyPaste"]) {
            _allowCopyPaste = [WXConvert BOOL:attributes[@"allowCopyPaste"]];
        }
        if (attributes[@"animationFont"]){
            _animationFont =[attributes[@"animationFont"] floatValue];
        }
        if (attributes[@"moveDistance"]){
            _moveDistance = [attributes[@"moveDistance"] floatValue];
        }
    }
    return self;
}


-(void)viewDidLoad
{
    [super viewDidLoad];
    _inputView.delegate = self;
}

- (void)updateBindingData:(NSDictionary *)data{
    [super updateBindingData:data];
}

- (void)updateAttributes:(NSDictionary *)attributes
{
    [super updateAttributes:attributes];

}

- (UIView *)loadView{
    _inputView = [[HMMagicField alloc] init];
    if(self.animationFont){
        _inputView.animationFont = [UIFont systemFontOfSize:self.animationFont];
    }else{
        _inputView.animationFont = [UIFont systemFontOfSize:11];
    }
    
    if(self.moveDistance){
      _inputView.moveDistance = self.moveDistance;
    }
    return _inputView;
}


# pragma mark - overwrite method
-(NSString *)text
{
    return _inputView.text;
}
- (void)setText:(NSString *)text
{
    _inputView.text = text;
}
-(void)setTextColor:(UIColor *)color
{
    _inputView.textColor = color;
}

-(void)setTextAlignment:(NSTextAlignment)textAlignForStyle
{
    _inputView.textAlignment = textAlignForStyle;
}
-(void)setUserInteractionEnabled:(BOOL)userInteractionEnabled
{
    _inputView.userInteractionEnabled = userInteractionEnabled;
}
-(void)setEnabled:(BOOL)enabled
{
    _inputView.enabled=enabled;
}
-(void)setReturnKeyType:(UIReturnKeyType)returnKeyType
{
    _inputView.returnKeyType = returnKeyType;
}
-(void)setInputAccessoryView:(UIView *)inputAccessoryView
{
    _inputView.inputAccessoryView = inputAccessoryView;
}
-(void)setKeyboardType:(UIKeyboardType)keyboardType
{
    _inputView.keyboardType = keyboardType;
}
-(void)setSecureTextEntry:(BOOL)secureTextEntry
{
    _inputView.secureTextEntry = secureTextEntry;
}
-(void)setEditPadding:(UIEdgeInsets)padding
{
    [_inputView setPadding:padding];
}
-(void)setEditBorder:(UIEdgeInsets)border
{
    [_inputView setBorder:border];
}

-(void)setAttributedPlaceholder:(NSMutableAttributedString *)attributedString font:font
{
    [_inputView setAttributedPlaceholder:attributedString];
}

-(void)setFont:(UIFont *)font
{
    [_inputView setFont:font];
}

-(void)setEditSelectionRange:(NSInteger)selectionStart selectionEnd:(NSInteger)selectionEnd
{
    UITextPosition *startPos =  [self.inputView positionFromPosition:self.inputView.beginningOfDocument offset:selectionStart];
    UITextPosition *endPos = [self.inputView positionFromPosition:self.inputView.beginningOfDocument offset:selectionEnd];
    UITextRange *textRange = [self.inputView textRangeFromPosition:startPos
                                                        toPosition:endPos];
    self.inputView.selectedTextRange = textRange;
}

-(NSDictionary *)getEditSelectionRange
{
    NSInteger selectionStart = [self.inputView offsetFromPosition:self.inputView.beginningOfDocument toPosition:self.inputView.selectedTextRange.start];
    NSInteger selectionEnd = [self.inputView offsetFromPosition:self.inputView.beginningOfDocument toPosition:self.inputView.selectedTextRange.end];
    NSDictionary *res = @{@"selectionStart":@(selectionStart),@"selectionEnd":@(selectionEnd)};
    return res;
}

@end

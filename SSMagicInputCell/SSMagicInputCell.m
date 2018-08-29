//
//  SSMagicInputCell.m
//  SSMagicInputCellDemo
//
//  Created by RockXeng on 2018/8/29.
//  Copyright © 2018年 ShuSheng. All rights reserved.
//

#import "SSMagicInputCell.h"
#import <Masonry.h>

@implementation SSMagicInputCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _leftLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _leftLabel.textColor = [UIColor grayColor];
        _leftLabel.font = [UIFont systemFontOfSize:14.f];
        _leftLabel.textAlignment = NSTextAlignmentLeft;
        
        [self.contentView addSubview:_leftLabel];
        
        _rightTextView = [[SSTextView alloc] initWithFrame:CGRectZero];
        _rightTextView.textColor = [UIColor grayColor];
        _rightTextView.font = [UIFont systemFontOfSize:14.f];
        _rightTextView.scrollEnabled = NO;
        _rightTextView.textAlignment = NSTextAlignmentLeft;
        _rightTextView.userInteractionEnabled = YES;
        _rightTextView.delegate = self;
        
        __weak typeof(self) weakSelf = self;
        _rightTextView.heightDidChangeBlock = ^(NSString *text, CGFloat height) {
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(ss_textViewCell:textHeightChange:)]) {
                [weakSelf.delegate ss_textViewCell:weakSelf textHeightChange:text];
            }
        };
        
        [self.contentView addSubview:_rightTextView];
    }
    
    return self;
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)updateConstraints {
    [_leftLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10.f);
        make.centerY.equalTo(self);
        make.width.equalTo(@75.f);
    }];
    
    [_rightTextView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftLabel.mas_right);
        make.top.equalTo(self.contentView.mas_top).offset(5.f);
        make.trailing.equalTo(self.contentView.mas_trailing).offset(-15.f);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5.f);
        make.height.greaterThanOrEqualTo(@24.f);
    }];
    
    [super updateConstraints];
}

- (void)updateCellWithLeft:(NSString *)leftString
                     right:(NSString *)rightString
               placeholder:(NSString *)placeholder
                 maxLength:(NSInteger)maxLength {
    _leftLabel.text = leftString;
    _rightTextView.text = rightString;
    _rightTextView.placeholder = placeholder;
    _maxLength = maxLength;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        [textView resignFirstResponder];
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    
    if(range.length + range.location > textView.text.length){
        return NO;
    }
    NSUInteger newLength = [textView.text length] + [text length] - range.length;
    if ([text isEqualToString:@""]) { //delete one character
        return YES;
    }
    if (self.maxLength <= 0) {
        self.maxLength = MAXFLOAT;
    }
    
    return newLength <= self.maxLength;
}

- (void)textViewDidChange:(UITextView *)textView {
    [self handleWithTextView:(SSTextView *)textView];
}

- (void)handleWithTextView:(SSTextView *)textView {
    if (self.delegate && [self.delegate respondsToSelector:@selector(ss_textViewDidChange:)]) {
        [self.delegate ss_textViewDidChange:textView];
    }
}

@end

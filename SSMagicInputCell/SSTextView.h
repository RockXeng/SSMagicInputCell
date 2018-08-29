//
//  SSTextView.h
//  SSMagicInputCellDemo
//
//  Created by RockXeng on 2018/8/29.
//  Copyright © 2018年 ShuSheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSTextView : UITextView
/**
 设置placeholder
 
 默认值为 `nil`
 */
@property (nonatomic, strong) NSString *placeholder;

/**
 设置富文本placeholder
 
 默认值是 `nil`
 */
@property (nonatomic, strong) NSAttributedString *attributedPlaceholder;

- (CGRect)placeholderRectForBounds:(CGRect)bounds;

/** 只有输入状态下，高度改变了的时候才会调用 */
@property (nonatomic, copy) void(^heightDidChangeBlock)(NSString *text, CGFloat height);

@end

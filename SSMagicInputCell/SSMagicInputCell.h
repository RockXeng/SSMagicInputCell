//
//  SSMagicInputCell.h
//  SSMagicInputCellDemo
//
//  Created by RockXeng on 2018/8/29.
//  Copyright © 2018年 ShuSheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSTextView.h"

@class SSMagicInputCell;

@protocol SSMagicInputCellDelegate <NSObject>

- (void)ss_textViewDidChange:(SSTextView *)textView;

- (void)ss_textViewCell:(SSMagicInputCell* )cell textHeightChange:(NSString *)text;

@end

@interface SSMagicInputCell : UITableViewCell <UITextViewDelegate>

@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) SSTextView *rightTextView;

@property (nonatomic, assign) NSInteger maxLength;
@property (nonatomic, weak) id<SSMagicInputCellDelegate> delegate;

- (void)updateCellWithLeft:(NSString *)leftString
                     right:(NSString *)rightString
               placeholder:(NSString *)placeholder
                 maxLength:(NSInteger)maxLength;

@end

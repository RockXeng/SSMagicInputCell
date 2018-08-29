//
//  SSTextView.m
//  SSMagicInputCellDemo
//
//  Created by RockXeng on 2018/8/29.
//  Copyright © 2018年 ShuSheng. All rights reserved.
//

#import "SSTextView.h"

@interface SSTextView ()

@property (nonatomic, assign) NSInteger textHeight;

@end

@implementation SSTextView

#pragma mark - Accessors

@synthesize attributedPlaceholder = _attributedPlaceholder;

- (void)setText:(NSString *)string {
    [super setText:string];
    [self setNeedsDisplay];
}


- (void)insertText:(NSString *)string {
    [super insertText:string];
    [self setNeedsDisplay];
}


- (void)setAttributedText:(NSAttributedString *)attributedText {
    [super setAttributedText:attributedText];
    [self setNeedsDisplay];
}


- (void)setPlaceholder:(NSString *)string {
    if ([string isEqualToString:self.attributedPlaceholder.string]) {
        return;
    }
    
    NSMutableDictionary *attributes = [[NSMutableDictionary alloc] init];
    if ([self isFirstResponder] && self.typingAttributes) {
        [attributes addEntriesFromDictionary:self.typingAttributes];
    } else {
        attributes[NSFontAttributeName] = self.font;
        attributes[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
        
        if (self.textAlignment != NSTextAlignmentLeft) {
            NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
            paragraph.alignment = self.textAlignment;
            attributes[NSParagraphStyleAttributeName] = paragraph;
        }
    }
    
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:string attributes:attributes];
}


- (NSString *)placeholder {
    return self.attributedPlaceholder.string;
}


- (void)setAttributedPlaceholder:(NSAttributedString *)attributedPlaceholder {
    if ([_attributedPlaceholder isEqualToAttributedString:attributedPlaceholder]) {
        return;
    }
    
    _attributedPlaceholder = attributedPlaceholder;
    
    [self setNeedsDisplay];
}


- (void)setContentInset:(UIEdgeInsets)contentInset {
    [super setContentInset:contentInset];
    [self setNeedsDisplay];
}


- (void)setFont:(UIFont *)font {
    [super setFont:font];
    [self setNeedsDisplay];
}


- (void)setTextAlignment:(NSTextAlignment)textAlignment {
    [super setTextAlignment:textAlignment];
    [self setNeedsDisplay];
}


#pragma mark - NSObject

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:self];
}


#pragma mark - UIView

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        [self initialize];
    }
    return self;
}


- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self initialize];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    // Draw placeholder if necessary
    if (self.text.length == 0 && self.attributedPlaceholder) {
        CGRect placeholderRect = [self placeholderRectForBounds:self.bounds];
        [self.attributedPlaceholder drawInRect:placeholderRect];
    }
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    // Redraw placeholder text when the layout changes if necessary
    if (self.attributedPlaceholder && self.text.length == 0) {
        [self setNeedsDisplay];
    }
}

#pragma mark - Placeholder

- (CGRect)placeholderRectForBounds:(CGRect)bounds {
    CGRect rect = UIEdgeInsetsInsetRect(bounds, self.contentInset);
    
    if ([self respondsToSelector:@selector(textContainer)]) {
        rect = UIEdgeInsetsInsetRect(rect, self.textContainerInset);
        CGFloat padding = self.textContainer.lineFragmentPadding;
        rect.origin.x += padding;
        rect.size.width -= padding * 2.0f;
    } else {
        if (self.contentInset.left == 0.0f) {
            rect.origin.x += 8.0f;
        }
        rect.origin.y += 8.0f;
    }
    
    return rect;
}

#pragma mark - Private

- (void)initialize {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:self];
}

-(void)setHeightDidChangeBlock:(void (^)(NSString *, CGFloat))heightDidChangeBlock{
    _heightDidChangeBlock = heightDidChangeBlock;
    
    [self textChanged:nil];
}

- (void)textChanged:(NSNotification *)notification {
    NSInteger height = ceilf([self sizeThatFits:CGSizeMake(self.bounds.size.width, MAXFLOAT)].height);
    
    if (self.textHeight != height) { // 高度如果不一样，就换行改变了高度
        self.textHeight = height;
        if (self.heightDidChangeBlock) {
            self.heightDidChangeBlock(self.text,height);
        }
    }
    
    [self setNeedsDisplay];
}

@end

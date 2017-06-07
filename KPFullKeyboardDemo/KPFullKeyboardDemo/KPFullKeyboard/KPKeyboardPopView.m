//
//  KPKeyboardPopView.m
//  KPFullKeyboardDemo
//
//  Created by lyleKP on 2017/6/7.
//  Copyright © 2017年 lyle. All rights reserved.
//

#import "KPKeyboardPopView.h"
#import "KPKeyBoardConstant.h"

@interface KPKeyboardPopView()

@property (weak, nonatomic) IBOutlet UILabel *titleLetter;

@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *letterLeadingConstraint;

@end

@implementation KPKeyboardPopView


+ (instancetype)popView
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    return NO;
}

- (void)showFromButton:(UIButton *)button
{
    if (button == nil) {
        return;
    }
    self.titleLetter.text = button.currentTitle;
    
    CGRect btnFrame = [button convertRect:button.bounds toView:nil];
    
    CGFloat popViewW = AUTO_ADAPT_SIZE_VALUE(72, 82, 88);
    CGFloat popViewH = AUTO_ADAPT_SIZE_VALUE(100, 108, 118);
    CGFloat popViewX = 0;
    
    CGFloat popViewY = btnFrame.origin.y - (popViewH - btnFrame.size.height);
//    if ([button.currentTitle.lowercaseString isEqualToString:@"q"] || [button.currentTitle isEqualToString:@"1"] || [button.currentTitle isEqualToString:@"~"])
    if ([button.currentTitle.lowercaseString isEqualToString:@"1"] || [button.currentTitle isEqualToString:@"Q"] || [button.currentTitle isEqualToString:@"A"]|| [button.currentTitle isEqualToString:@"Z"]){           // 按钮在左边的情形
        self.backImageView.image = [UIImage imageNamed:@"keyboard_pop_left"];
        popViewX = btnFrame.origin.x - AUTO_ADAPT_SIZE_VALUE(4, 4, 4);
        self.letterLeadingConstraint.constant = AUTO_ADAPT_SIZE_VALUE(9, 11, 11);
//    } else if ([button.currentTitle.lowercaseString isEqualToString:@"p"] || [button.currentTitle isEqualToString:@"0"] || [button.currentTitle isEqualToString:@"#"])
        } else if ([button.currentTitle.lowercaseString isEqualToString:@"0"] || [button.currentTitle isEqualToString:@"O"] || [button.currentTitle isEqualToString:@"P"]){           // 按钮在右边的情形
        self.backImageView.image = [UIImage imageNamed:@"keyboard_pop_right"];
        popViewX = btnFrame.origin.x + btnFrame.size.width - AUTO_ADAPT_SIZE_VALUE(69, 79, 85);
        self.letterLeadingConstraint.constant = AUTO_ADAPT_SIZE_VALUE(25, 29, 33);
    } else {                                            // 按钮在中间部分
        self.backImageView.image = [UIImage imageNamed:@"keyboard_pop"];
        popViewX = btnFrame.origin.x - (popViewW - btnFrame.size.width) * 0.5;
        self.letterLeadingConstraint.constant = AUTO_ADAPT_SIZE_VALUE(16, 20, 22);
    }
    
    CGRect frame = CGRectMake(popViewX, popViewY, popViewW, popViewH);
    
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    self.frame = frame;
    [window addSubview:self];
}


@end

//
//  KPKeyBoard.m
//  KPFullKeyboardDemo
//
//  Created by lyleKP on 2017/6/6.
//  Copyright © 2017年 lyle. All rights reserved.
//

#import "KPKeyBoard.h"

#import "KPKeyboardPopView.h"

NSInteger const numberKeysCount = 10;
NSInteger const letterKeysCount = 26;

NSString * const kNumberKeyboardKeys[] = {
    @"1", @"2", @"3",@"4", @"5", @"6", @"7", @"8", @"9", @"0"
};

NSString * const kLetterKeyboardKeys[] = {
    @"Q", @"W", @"E",@"R", @"T", @"Y",@"U", @"I", @"O",
    @"A", @"S", @"D",@"F", @"G", @"H",@"J", @"K", @"P",
    @"Z", @"X", @"C",@"V", @"B", @"N",@"M", @"L"
};

#define  numberKeyWidth   [UIScreen mainScreen].bounds.size.width / numberKeysCount
CGFloat  const numberKeyHeight = 40.0f;

#define  letterKeyWidth   [UIScreen mainScreen].bounds.size.width / 9
CGFloat  const letterKeyHeight = 40.0f;


NSInteger  const letterLineCount = 3;


@interface KPKeyBoard ()

@property (nonatomic, strong) KPKeyboardPopView *popView;

@property (nonatomic,strong) NSArray *numbersAry;
@property (nonatomic,strong) NSArray *lettersAry;

@property (nonatomic,strong) NSMutableArray * allkeyButtonsAry ;

@property (nonatomic,strong) UIButton *confirmButton;
@property (nonatomic,strong) UIButton *deleteButton;

@property (nonatomic, strong) UIButton *lastButton;

@end


@implementation KPKeyBoard



+ (instancetype)keyBoard {
    KPKeyBoard * keyBoard  = [[KPKeyBoard alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 212, [UIScreen mainScreen].bounds.size.width, 212)];
    return keyBoard;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:245/255.0 alpha:1];
        self.userInteractionEnabled = YES;
        [self setUpUILayout];
    }
    return self;
}


#pragma mark -  privite method


- (UIButton *)keyboardButtonWithLocation:(CGPoint)location
{
    NSUInteger count = self.allkeyButtonsAry.count;
    for (NSUInteger i = 0; i < count; i++) {
        UIButton *btn = self.allkeyButtonsAry[i];
        if (CGRectContainsPoint(btn.frame, location)) {
            return btn;
        }
    }
    return nil;
}



- (void)setUpUILayout {
    
    for(NSInteger i = 0 ; i <self.numbersAry.count; i ++){
        UIButton *numberButton  = [UIButton buttonWithType:UIButtonTypeCustom];
        numberButton.userInteractionEnabled = NO;
        [numberButton setFrame:CGRectMake(i*numberKeyWidth+1, 1, numberKeyWidth-1, numberKeyHeight)];
        [numberButton setTitle:self.numbersAry[i] forState:UIControlStateNormal];
        [numberButton setTitleColor:[UIColor colorWithRed:144/255.0 green:144/255.0 blue:144/255.0 alpha:1] forState:UIControlStateNormal];
        numberButton.titleLabel.font = [UIFont systemFontOfSize:17];
        numberButton.backgroundColor = [UIColor whiteColor];
        [self.allkeyButtonsAry addObject:numberButton];
        [self addSubview:numberButton];
        [self bringSubviewToFront:numberButton];
    }
    
    
    for(NSInteger i = 0 ; i < letterLineCount ;i ++ ){
        NSInteger maxCountInRow = 9;
        for (NSInteger j = 0 ; j <maxCountInRow; j++) {
            if(i ==2 && j == 8){
                UIButton *blankView  = [UIButton buttonWithType:UIButtonTypeCustom];
                [blankView setFrame:CGRectMake(j*letterKeyWidth+1, 41+i*40 +1, letterKeyWidth-1, letterKeyHeight-1)];
                blankView.backgroundColor = [UIColor whiteColor];
                blankView.userInteractionEnabled = YES; //是的空白键不响应touch事件
                [self addSubview:blankView];
            }else{
                UIButton *letterButton  = [UIButton buttonWithType:UIButtonTypeCustom];
                letterButton.userInteractionEnabled = NO;
                [letterButton setFrame:CGRectMake(j*letterKeyWidth+1, 41+i*40 +1, letterKeyWidth-1, letterKeyHeight-1)];
                [letterButton setTitle:self.lettersAry[i*9+j] forState:UIControlStateNormal];
                [letterButton setTitleColor:[UIColor colorWithRed:144/255.0 green:144/255.0 blue:144/255.0 alpha:1] forState:UIControlStateNormal];
                letterButton.titleLabel.font = [UIFont systemFontOfSize:17];
                letterButton.backgroundColor = [UIColor whiteColor];
                [self.allkeyButtonsAry addObject:letterButton];
                [self addSubview:letterButton];
                [self bringSubviewToFront:letterButton];
            }
        }
    }
    [self addSubview:self.confirmButton];
    [self addSubview:self.deleteButton];

}



#pragma mark - Touch Responders

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    NSLog(@"touchesBegan:");
    self.lastButton = nil;
    [self touchesMoved:touches withEvent:event];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    NSLog(@"touchesMoved:");
    UITouch *touch = touches.anyObject;
    CGPoint location = [touch locationInView:touch.view];
    UIButton *btn = [self keyboardButtonWithLocation:location];
    if (btn) {
        self.lastButton = btn;
        [self.popView showFromButton:btn];
    }
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    NSLog(@"touchesCancelled:");
    [self.popView removeFromSuperview];
    
    UITouch *touch = touches.anyObject;
    CGPoint location = [touch locationInView:touch.view];
    UIButton *btn = [self keyboardButtonWithLocation:location];
    
    if (btn) {
        NSLog(@"touched:  %@",btn.currentTitle);
        if (self.delegate && [self.delegate respondsToSelector:@selector(didTouchedKey:)]) {
            [self.delegate didTouchedKey:btn.currentTitle];
        }
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    NSLog(@"touchesCancelled:");
    [self.popView removeFromSuperview];
}




#pragma mark -  property

- (NSMutableArray *)allkeyButtonsAry {
    if(!_allkeyButtonsAry){
        _allkeyButtonsAry = [NSMutableArray new];
    }
    return _allkeyButtonsAry;
}
- (UIButton *)confirmButton {
    if(!_confirmButton){
        UIButton *button  = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(0, self.frame.size.height-50, [UIScreen mainScreen].bounds.size.width-60, 50)];
        [button setTitle:@"确定" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithRed:254/255.0 green:128/255.0 blue:38/255.0 alpha:1] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        button.backgroundColor = [UIColor whiteColor];
        _confirmButton =button;
        [_confirmButton addTarget:self.delegate action:@selector(didTouchedConfirm) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}

- (UIButton *)deleteButton {
    if(!_deleteButton){
        UIButton *button  = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-60-1, self.frame.size.height-50, 60-1, 50)];
        [button setImage:[UIImage imageNamed:@"icon_letterDelete@3x"] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        button.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];
        _deleteButton = button;
        [_deleteButton addTarget:self.delegate action:@selector(didTouchedDelete) forControlEvents:UIControlEventTouchUpInside];
    }
    return  _deleteButton;
}



- (NSArray *)numbersAry{
    static NSArray *numbersAry;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        numbersAry = [NSArray arrayWithObjects:kNumberKeyboardKeys count:numberKeysCount];
    });
    return numbersAry;
}

- (NSArray *)lettersAry{
    static NSArray *lettersAry;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        lettersAry = [NSArray arrayWithObjects:kLetterKeyboardKeys count:letterKeysCount];
    });
    return lettersAry;
}


- (KPKeyboardPopView *)popView {
    if (!_popView) {
        _popView = [KPKeyboardPopView popView];
    }
    return _popView;
}



@end

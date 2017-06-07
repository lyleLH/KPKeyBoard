//
//  KPKeyBoard.h
//  KPFullKeyboardDemo
//
//  Created by lyleKP on 2017/6/6.
//  Copyright © 2017年 lyle. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KPKeyBoard;
@protocol KPKeyBoardDelegate<NSObject>

@optional

- (void)didTouchedKey:(NSString*)string;

- (void)didTouchedDelete;

- (void)didTouchedConfirm;

@end

@interface KPKeyBoard : UIView

@property (nonatomic,weak) id<KPKeyBoardDelegate> delegate;

+ (instancetype)keyBoard;

@end




//
//  KPKeyBoardConstant.h
//  KPFullKeyboardDemo
//
//  Created by lyleKP on 2017/6/7.
//  Copyright © 2017年 lyle. All rights reserved.
//

#ifndef KPKeyBoardConstant_h
#define KPKeyBoardConstant_h

#define IS_IPHONE6 ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && [UIScreen mainScreen].bounds.size.height == 667 || [UIScreen mainScreen].bounds.size.width == 667)

#define IS_IPHONE6_PLUS ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && [UIScreen mainScreen].bounds.size.height == 736 || [UIScreen mainScreen].bounds.size.width == 736)

#define AUTO_ADAPT_SIZE_VALUE(iPhone4_5, iPhone6, iPhone6plus) (IS_IPHONE6 ? iPhone6 : (IS_IPHONE6_PLUS ? iPhone6plus : iPhone4_5))


#endif /* KPKeyBoardConstant_h */

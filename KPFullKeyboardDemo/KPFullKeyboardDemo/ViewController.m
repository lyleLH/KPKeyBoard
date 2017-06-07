//
//  ViewController.m
//  KPFullKeyboardDemo
//
//  Created by lyleKP on 2017/6/6.
//  Copyright © 2017年 lyle. All rights reserved.
//

#import "ViewController.h"
#import "KPKeyBoard.h"

@interface ViewController () <KPKeyBoardDelegate>

@property (strong, nonatomic) IBOutlet UITextField *textField;

@property (strong, nonatomic)  KPKeyBoard* keyBoard;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.textField.inputView = self.keyBoard;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [tap setCancelsTouchesInView:NO];
    [self.view addGestureRecognizer:tap];
}

#pragma mark - KPKeyBoardDelegate Method

- (void)didTouchedKey:(NSString *)string {
    [self.textField insertText:string];
}

- (void)didTouchedDelete {
    [self.textField deleteBackward];
}

- (void)didTouchedConfirm {
    NSLog(@"确定");
    
}

#pragma mark - 触摸处理键盘收起
- (void)handleTap:(UITapGestureRecognizer *)recognizer
{
    [self.view endEditing:YES];
}

-(KPKeyBoard *)keyBoard{
    if(!_keyBoard){
        _keyBoard = [KPKeyBoard keyBoard];
        _keyBoard.delegate = self;
    }
    return _keyBoard;
}
@end

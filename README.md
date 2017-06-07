# KPKeyBoard
大写字母和数字输入的简化键盘

## Preview

![image](https://github.com/lyleLH/KPKeyBoard/blob/master/2017-06-07%2012_42_40.gif)

## How To Use

```

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textField.inputView = self.keyBoard;
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


-(KPKeyBoard *)keyBoard{
    if(!_keyBoard){
        _keyBoard = [KPKeyBoard keyBoard];
        _keyBoard.delegate = self;
    }
    return _keyBoard;
}

```

# KPKeyBoard
大写字母和数字输入的简化键盘

## Preview

<!--![image](https://github.com/lyleLH/KPKeyBoard/blob/master/2017-06-07%2012_42_40.gif =375*667)-->


![2017-06-07 12_42_40.gif](http://upload-images.jianshu.io/upload_images/1206973-e2cb9f6ac33ed51d.gif?imageMogr2/auto-orient/strip =375x667){: width="375px" height="667px"}



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

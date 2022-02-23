//
//  ZHView.m
//  自定义弹窗（代理和block）
//
//  Created by 刘忠华 on 2022/2/23.
//

#import "ZHView.h"

@interface ZHView()

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UIButton *sureButton;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *message;
@end

@implementation ZHView


/**
 自定义view有四种
 1.代理
 2.block
 3.xib
 以上三种都是创建view来制作弹窗
 4.控制器
 
 推荐使用block delegate模式 block优势：可以在创建view处编写业务逻辑，逻辑简单清晰 代理优势：在业务比较复杂时用代理*/
/**block模式**/
-(instancetype)initTitle:(NSString *)title message:(NSString *)message block:(void (^)(NSInteger))block {
    
    self = [[[NSBundle mainBundle] loadNibNamed:@"ZHView" owner:self options:nil] lastObject];
    
    if (self = [super init]) {
        self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.85];
        self.frame = [UIScreen mainScreen].bounds;
        self.title = title;
        self.message = message;
        self.buttonBlock = block;
        
//        [self setupUI];
    }
    return self;
}

/**代理模式**/
-(instancetype)initTitle:(NSString *)title message:(NSString *)message sureButton:(NSString *)sureButton {
    
    if (self = [super init]) {
        self.title = title;
        self.message = message;
        [self setupUI];
    }
    return self;
}


-(void)setupUI {
    
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.85];

    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width-80, 150)];
    self.contentView.center = self.center;
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.contentView.layer.cornerRadius = 5;
    [self addSubview:self.contentView];
    
    UILabel *titleLable = [[ UILabel alloc] initWithFrame:CGRectMake(0, 10, self.contentView.frame.size.width, 22)];
    titleLable.text = self.title;
    titleLable.font = [UIFont systemFontOfSize:20 weight:UIFontWeightBold];
    titleLable.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:titleLable];
    
    UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, self.contentView.frame.size.width, 22)];
    messageLabel.text = self.message;
    messageLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightRegular];
    messageLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:messageLabel];
    
    UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.contentView.frame.size.height-40, self.contentView.frame.size.width*0.5, 40)];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    cancelButton.backgroundColor = [UIColor grayColor];
    [cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:cancelButton];
    
    UIButton *sureButton = [[UIButton alloc] initWithFrame:CGRectMake(self.contentView.frame.size.width*0.5, self.contentView.frame.size.height-40, self.contentView.frame.size.width*0.5, 40)];
    [sureButton setTitle:@"确认" forState:UIControlStateNormal];
    sureButton.backgroundColor = [UIColor blueColor];
    [sureButton addTarget:self action:@selector(sureButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:sureButton];
    
}

-(void)show {
    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
    [window addSubview:self];
}

-(void)sureButtonClick {
    
    if (self.buttonBlock) {
        self.buttonBlock(ZHViewClickButtonTypeSure);
    }
    if ([self.delegate respondsToSelector:@selector(ZHViewDelegateButtonClickWithIndex:)]) {
        [self.delegate ZHViewDelegateButtonClickWithIndex:ZHViewClickButtonTypeSure];
    }
    [self dismiss];
}

-(void)cancelButtonClick {
    if (self.buttonBlock) {
        self.buttonBlock(ZHViewClickButtonTypeCancel);
    }
    if ([self.delegate respondsToSelector:@selector(ZHViewDelegateButtonClickWithIndex:)]) {
        [self.delegate ZHViewDelegateButtonClickWithIndex:ZHViewClickButtonTypeCancel];
    }
    [self dismiss];
}

- (IBAction)cancelBtnClick:(id)sender {
    [self cancelButtonClick];
}

- (IBAction)sureBtnClick:(id)sender {
    [self sureButtonClick];
}

-(void)dismiss {
    [self removeFromSuperview];
}
@end

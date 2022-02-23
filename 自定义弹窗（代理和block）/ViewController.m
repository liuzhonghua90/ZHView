//
//  ViewController.m
//  自定义弹窗（代理和block）
//
//  Created by 刘忠华 on 2022/2/23.
//

#import "ViewController.h"
#import "ZHView.h"

@interface ViewController () <ZHViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 40)];
    [btn setTitle:@"弹窗展示" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor blueColor];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(void)btnClick {
    //    ZHView *alertView = [[ZHView alloc] initTitle:@"温馨提示" message:@"你确定要退出吗？" sureButton:@"确定"];
    //    alertView.delegate = self;
    //    [alertView show];
        ZHView *alertView = [[ZHView alloc] initTitle:@"温馨提示" message:@"你确定要退出吗？" block:^(NSInteger index) {
            NSLog(@"index----%ld",index);
        }];
        [alertView show];
}

-(void)ZHViewDelegateButtonClickWithIndex:(NSInteger)index {
    NSLog(@"index----%ld",index);
}

/**第4种方式 控制器moda**/
-(void)modaViewCtr {
    //UIViewController （为自己创建的控制器）
    UIViewController * popVC = [[UIViewController alloc] init];
    UIColor * color = [UIColor blackColor];
    popVC.view.backgroundColor = [color colorWithAlphaComponent:0.85];
    popVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self presentViewController:popVC animated:NO completion:nil];
}

@end

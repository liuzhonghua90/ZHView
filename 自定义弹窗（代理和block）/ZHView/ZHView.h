//
//  ZHView.h
//  自定义弹窗（代理和block）
//
//  Created by 刘忠华 on 2022/2/23.
//  弹窗构造 标题 副标题 取消 确认

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ZHViewClickButtonTypeCancel = 0,
    ZHViewClickButtonTypeSure,
} ZHViewClickButtonType;


/**************************代理模式********************/
//1.定义一个协议
@protocol ZHViewDelegate <NSObject>

//2.协议方法
-(void)ZHViewDelegateButtonClickWithIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_BEGIN

@interface ZHView : UIView

@property (nonatomic, copy) void (^buttonBlock) (NSInteger index);

//3.申明一个遵守ZHViewDelegate的代理
@property (nonatomic, weak) id<ZHViewDelegate> delegate;
//4.初始化一个view方法
-(instancetype)initTitle:(NSString *)title message:(NSString *)message sureButton:(NSString *)sureButton;
//5.展示弹窗
-(void)show;
//6.弹窗消失
-(void)dismiss;


/**block模式*****/


-(instancetype)initTitle:(NSString *)title message:(NSString *)message block:(void (^) (NSInteger index))block;


@end

NS_ASSUME_NONNULL_END

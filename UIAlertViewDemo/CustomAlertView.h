//
//  CustomAlertView.h
//  UIAlertViewDemo
//
//  Created by fhc on 16/1/14.
//  Copyright © 2016年 fhc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowWindow : UIWindow
@end

@interface CustomAlertButton : UIButton
@property (assign,nonatomic) int buttonIndex;
@end

@protocol CustomAlertViewDelegate <NSObject>
@optional
-(void) customAlertView:(nonnull id) alertView andClickAt:(nonnull CustomAlertButton*) alertButton;
@end

@interface CustomAlertView : UIView
@property(strong,nonatomic,readonly,nullable)  ShowWindow *showWindow;
-(nonnull instancetype)initWithTitle:(nullable NSString *)title delegate:(nullable id<CustomAlertViewDelegate>)delegate andButtonList:(nonnull NSArray<NSString*>*) buttonList andContntView:(nullable UIView*) contentView ;
-(void) show;


@end

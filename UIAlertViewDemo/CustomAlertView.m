//
//  CustomAlertView.m
//  UIAlertViewDemo
//
//  Created by fhc on 16/1/14.
//  Copyright © 2016年 fhc. All rights reserved.
//

#import "CustomAlertView.h"
#define CA_WIDTH 284
#define LINE_COLOR [UIColor lightGrayColor]//线的颜色
#define BUTTON_COLOR [UIColor blueColor]//button文字颜色
#define CONTROL_COLOR [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1]//控件的背景色



@implementation CustomAlertButton
@end


@implementation ShowWindow
@end

@implementation CustomAlertView

{
    UIView * _titleView,* _contengView,*_btnView;

    NSString * _title;
    id<CustomAlertViewDelegate> _delegate;
    NSArray<NSString*>* _buttonList;
    UIView * _content;
    
}


-(nonnull instancetype)initWithTitle:(nullable NSString *)title delegate:(nullable id<CustomAlertViewDelegate>)delegate andButtonList:(nonnull NSArray<NSString*>*) buttonList andContntView:(nullable UIView*) contentView
{
    self = [super init];
    if (self) {
        _title = title;
        _delegate = delegate;
        _buttonList = buttonList;
        _content = contentView;
        [self addObserver];
    }
    return self;
}

-(void) reloadControls
{
    self.showWindow = [[ShowWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.showWindow.backgroundColor =[UIColor clearColor];
    
    UIView *bgView = [[UIView alloc] initWithFrame:self.showWindow.frame];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.5;
    
    [self.showWindow addSubview:bgView];
    self.showWindow.windowLevel = UIWindowLevelNormal;
    self.backgroundColor = CONTROL_COLOR;
    self.layer.cornerRadius = 10;
    self.layer.masksToBounds = YES;
    
    
    float controlHeight = 0;
    
    if (_title&&_title.length) {//创建_titleView 以及内容
        UIFont * font = [UIFont boldSystemFontOfSize:16];
        CGSize size = [_title sizeWithFont:font constrainedToSize:CGSizeMake(CA_WIDTH-30, 2000) lineBreakMode:NSLineBreakByCharWrapping];
        [_title sizeWithAttributes:nil];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, CA_WIDTH-30, size.height)];
        titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = font;
        titleLabel.text = _title;
        
        _titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CA_WIDTH, titleLabel.bounds.size.height + 30)];
        
        [_titleView addSubview:titleLabel];
        controlHeight = _titleView.bounds.size.height;
        
        [self addSubview:_titleView];
    }
    
    
    if (_content) {//创建_contentView 以及将传进来的contentView装进_contentView
        UIView *hLine = [[UIView alloc] initWithFrame:CGRectMake(0, controlHeight, CA_WIDTH, 1)];//水平黑线
        hLine.backgroundColor = LINE_COLOR;
        controlHeight += 1;
        
        
        _contengView = [[UIView alloc] initWithFrame:CGRectMake(15, controlHeight, CA_WIDTH-30, _content.bounds.size.height+30+1)];
        [_contengView addSubview:_content];
        controlHeight += _contengView.bounds.size.height;
        
        [self addSubview:hLine];
        [self addSubview:_contengView];
        
        CGRect frame = CGRectMake((_contengView.bounds.size.width - _content.bounds.size.width)/2.0,
                                  (_contengView.bounds.size.height - _content.bounds.size.height)/2.0,
                                  _content.bounds.size.width,
                                  _content.bounds.size.height);
        _content.frame = frame;
        
    }
    
    if (_buttonList.count>0) {//创建 _btnView
        
        if(_buttonList.count==2)//只有在两个按钮的情况下需要画竖线
        {
            UIView *hLine = [[UIView alloc] initWithFrame:CGRectMake(0, controlHeight, CA_WIDTH, 1)];
            hLine.backgroundColor = LINE_COLOR;
            controlHeight+=1;
            
            _btnView = [[UIView alloc] initWithFrame:CGRectMake(0, controlHeight, CA_WIDTH, 44)];
            
            float btnWidth = (_btnView.bounds.size.width - 1)/2.0;
            for (int i = 0 ; i< _buttonList.count; i++) {
                CustomAlertButton *btn = [[CustomAlertButton alloc ] initWithFrame:CGRectMake((btnWidth+1) * i, 0, btnWidth, 44)];
                [btn setTitle:_buttonList[i] forState:UIControlStateNormal];
                btn.buttonIndex = i;
                [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
                [_btnView addSubview:btn];
                [btn setTitleColor:BUTTON_COLOR forState:UIControlStateNormal];
            }
            
            UIView *vLine = [[UIView alloc] initWithFrame:CGRectMake(btnWidth, 0, 1, 44)];//垂直黑线
            vLine.backgroundColor = LINE_COLOR;
            
            [_btnView addSubview:vLine];
            
            
            controlHeight+=44;
            [self addSubview:hLine];
            [self addSubview:_btnView];
            
        }
        else
        {
            _btnView = [[UIView alloc ] initWithFrame:CGRectMake(0, controlHeight, CA_WIDTH , 45 * _buttonList.count)];
            for (int i = 0 ; i<_buttonList.count; i++) {
                UIView *hLine = [[UIView alloc] initWithFrame:CGRectMake(0, controlHeight, CA_WIDTH, 1)];
                hLine.backgroundColor = LINE_COLOR;
                
                CustomAlertButton *btn = [[CustomAlertButton alloc ] initWithFrame:CGRectMake(0, 44* i+1, CA_WIDTH, 44)];
                btn.buttonIndex = i;
                [btn setTitle:_buttonList[i] forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
                [btn setTitleColor:BUTTON_COLOR forState:UIControlStateNormal];
                
                controlHeight+=1;
                controlHeight+=44;
                [self addSubview:hLine];
                [_btnView addSubview:btn];
            }
            
            [self addSubview:_btnView];
        }
        
    }
    
    self.frame = CGRectMake(0, 0, 284, controlHeight);
    [self.showWindow addSubview:self];
    self.center = self.showWindow.center;
}

-(void)setShowWindow:(ShowWindow *)showWindow
{
    _showWindow = showWindow;
}

-(void) show
{
    [self reloadControls];
    [self.showWindow makeKeyAndVisible];
}

-(void) btnClick:(CustomAlertButton*) sender
{
    if (_delegate&&[_delegate respondsToSelector:@selector(customAlertView:andClickAt:)]) {
        [_delegate customAlertView:self andClickAt:sender];
    }
    
    self.showWindow.windowLevel = UIWindowLevelNormal;
    for (UIView *view in self.showWindow.subviews) {
        [view removeFromSuperview];
    }
    self.showWindow = nil;
    
    
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    [_titleView removeFromSuperview];
    [_contengView removeFromSuperview];
    [_btnView removeFromSuperview];
    _titleView = nil;
    _contengView = nil;
    _btnView = nil;
    
    
    [self setNeedsDisplay];
//    NSLog(@"%@",self.showWindow);
    
}

-(void) addObserver
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowNotification:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
}


-(void) keyboardWillShowNotification:(NSNotification*) notify
{
    NSDictionary * userinfo = notify.userInfo;
    NSValue *endFrameVal = userinfo[UIKeyboardFrameEndUserInfoKey];
    CGRect endFrame = [endFrameVal CGRectValue];
    CGSize size = [UIScreen mainScreen].bounds.size;
    CGRect windowRect = CGRectMake(0, 0, size.width, endFrame.origin.y);
    self.center =CGPointMake( CGRectGetMidX(windowRect),  CGRectGetMidY(windowRect));

}

-(void) keyboardWillHideNotification:(NSNotification*) notify
{

    CGRect windowRect = [UIScreen mainScreen].bounds;
    self.center =CGPointMake( CGRectGetMidX(windowRect),  CGRectGetMidY(windowRect));
}

-(void)dealloc
{
     [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

//
//  ViewController.m
//  UIAlertViewDemo
//
//  Created by fhc on 16/4/11.
//  Copyright © 2016年 fhc. All rights reserved.
//

#import "ViewController.h"
#import "CustomAlertView.h"

@interface ViewController ()<CustomAlertViewDelegate>
@property(strong,nonatomic) CustomAlertView *alertPicker,*alertTextBox;
@property(strong,nonatomic) UIDatePicker *picker;
@property(strong,nonatomic) UITextField *textField;
@property(strong,nonatomic) UIButton *btnPicker,*btnTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //init button
    self.btnPicker = [[UIButton alloc] initWithFrame:CGRectMake(10, 100, 100, 30)];
    [self.btnPicker setTitle:@"btnPicker" forState:UIControlStateNormal];
    [self.btnPicker addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.btnPicker.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.btnPicker];
    
    self.btnTextField = [[UIButton alloc] initWithFrame:CGRectMake(10, 200, 100, 30)];
    [self.btnTextField setTitle:@"btnTextField" forState:UIControlStateNormal];
    [self.btnTextField addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.btnTextField.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.btnTextField];
    
    //init alertview
    self.picker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, 300, 100)];
    self.picker.datePickerMode = UIDatePickerModeTime;
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    self.alertPicker = [[CustomAlertView alloc] initWithTitle:@"PickerTitle" delegate:self andButtonList:@[@"Cancel",@"OK"] andContntView:self.picker];
    self.alertTextBox = [[CustomAlertView alloc] initWithTitle:@"TextBoxTitle" delegate:self andButtonList:@[@"Cancel",@"OK"]  andContntView:self.textField];
}

-(void) btnClick:(id) sender
{
    if (sender == self.btnPicker) {
        [self.alertPicker show];
    }
    else if (sender == self.btnTextField)
    {
        [self.alertTextBox show];
    }
}

#pragma mark-- CustomAlertViewDelegate
-(void)customAlertView:(id)alertView andClickAt:(CustomAlertButton *)alertButton
{
    if (alertButton.buttonIndex==0) {
        return;
    }

    if (alertView == self.alertPicker) {
        NSLog(@"%@",self.picker.date);
    }
    else if (alertView == self.alertTextBox)
    {
        NSLog(@"%@",self.textField.text);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  VSViewController2.h
//  Lab5-ElliotYun
//
//  Created by Labuser on 11/4/14.
//  Copyright (c) 2014 com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VSViewController2 : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *Ship5;
@property (strong, nonatomic) IBOutlet UIButton *Ship4;
@property (strong, nonatomic) IBOutlet UIButton *Ship3;
@property (strong, nonatomic) IBOutlet UIButton *Ship2;
@property (strong, nonatomic) IBOutlet UIButton *Ship1;
@property (weak, nonatomic) IBOutlet UILabel *PlayerLabel2;
@property (weak, nonatomic) IBOutlet UIButton *DoneButton2;
@property (weak, nonatomic) IBOutlet UIButton *DoneButton;

@property UINavigationController *navController;

@end

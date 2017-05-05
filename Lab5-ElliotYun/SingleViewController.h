//
//  SingleViewController.h
//  Lab5-ElliotYun
//
//  Created by Labuser on 11/6/14.
//  Copyright (c) 2014 com. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AVFoundation/AVFoundation.h>

@protocol SingleViewProtocol <NSObject>

- (void)dismissAndPresentSinglePlay;

@end

@interface SingleViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *Ship5;
@property (strong, nonatomic) IBOutlet UIButton *Ship4;
@property (strong, nonatomic) IBOutlet UIButton *Ship3;
@property (strong, nonatomic) IBOutlet UIButton *Ship2;
@property (strong, nonatomic) IBOutlet UIButton *Ship1;
@property (weak, nonatomic) IBOutlet UIButton *DoneButton;
@property (weak, nonatomic) IBOutlet UILabel *PlayerLabel;

@property (nonatomic,weak) id <SingleViewProtocol> delegate;


@end

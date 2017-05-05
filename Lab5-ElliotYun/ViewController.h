//
//  ViewController.h
//  Lab5-ElliotYun
//
//  Created by Labuser on 11/3/14.
//  Copyright (c) 2014 com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "VSViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController <AVAudioPlayerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *vsButton;
@property (weak, nonatomic) IBOutlet UIButton *singButton;



@end

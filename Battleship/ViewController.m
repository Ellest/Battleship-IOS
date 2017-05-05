//
//  ViewController.m
//  Lab5-ElliotYun
//
//  Created by Labuser on 11/3/14.
//  Copyright (c) 2014 com. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "VSViewController.h"
#import "SingleViewController.h"

@interface ViewController ()
{
    AVAudioPlayer *av;
}

@end

@implementation ViewController

UInt32 soundID;


- (void)viewDidLoad
{
    [super viewDidLoad];

    [av play];
    
    /*CFBundleRef mainBundle = CFBundleGetMainBundle();
    CFURLRef soundUrl;
    soundUrl = CFBundleCopyResourceURL(mainBundle, (CFStringRef) @"bomb-01", CFSTR ("wav"), NULL);
    AudioServicesCreateSystemSoundID(soundUrl, &soundID);*/

    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"1024x1024.jpeg"]];
    
}
- (IBAction)vsButtonAct:(id)sender {
    //AudioServicesPlaySystemSound(soundID);
    [self performSegueWithIdentifier:@"push2" sender:self];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)singAction:(id)sender {
    [self performSegueWithIdentifier:@"push1" sender:self];
}

@end

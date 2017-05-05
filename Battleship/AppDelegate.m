//
//  AppDelegate.m
//  Lab5-ElliotYun
//
//  Created by Labuser on 11/3/14.
//  Copyright (c) 2014 com. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize navController, viewC;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    gameBoard = [[NSMutableArray alloc] init];
    for (int i = 0; i < 100; i++){
        [gameBoard addObject:@"0"];
    }
    gameBoard2 = [[NSMutableArray alloc] init];
    for (int i = 0; i < 100; i++){
        [gameBoard2 addObject:@"0"];
    }
    playBoard = [[NSMutableArray alloc] init];
    playBoard2 = [[NSMutableArray alloc] init];
    pieceBoard = [[NSMutableArray alloc] init];
    pieceBoard2 = [[NSMutableArray alloc] init];
    /*UIButton *blankButton = [[UIButton alloc] init];
    for (int i = 0; i < 100; i++){
        [gameBoard2 addObject:blankButton];
    }*/
    playerFlag = 1;
    
    player1ships = 17;
    player2ships = 17;
    
    // cord array for each ship (player 1)
    g1Ship1 = [[NSMutableArray alloc] initWithObjects:@"0", @"0", nil];
    g1Ship2 = [[NSMutableArray alloc] initWithObjects:@"0", @"0", @"0", nil];
    g1Ship3 = [[NSMutableArray alloc] initWithObjects:@"0", @"0", @"0", nil];
    g1Ship4 = [[NSMutableArray alloc] initWithObjects:@"0", @"0", @"0", @"0", nil];
    g1Ship5 = [[NSMutableArray alloc] initWithObjects:@"0", @"0", @"0", @"0", @"0", nil];
    
    // cord array for each ship (player 2)
    g2Ship1 = [[NSMutableArray alloc] initWithObjects:@"0", @"0", nil];
    g2Ship2 = [[NSMutableArray alloc] initWithObjects:@"0", @"0", @"0", nil];
    g2Ship3 = [[NSMutableArray alloc] initWithObjects:@"0", @"0", @"0", nil];
    g2Ship4 = [[NSMutableArray alloc] initWithObjects:@"0", @"0", @"0", @"0", nil];
    g2Ship5 = [[NSMutableArray alloc] initWithObjects:@"0", @"0", @"0", @"0", @"0", nil];
    
    shipsLeft1 = [[NSMutableArray alloc] initWithObjects:g1Ship1, g1Ship2, g1Ship3, g1Ship4, g1Ship5, nil];
    shipsLeft2 = [[NSMutableArray alloc] initWithObjects:g2Ship1, g2Ship2, g2Ship3, g2Ship4, g2Ship5, nil];
    
    shipsLeftCount1 = 5;
    shipsLeftCount2 = 5;
    
    NSNumber *numb = [NSNumber numberWithBool:true];
    sinkStatus1 = [[NSMutableArray alloc] initWithObjects:numb, numb, numb, numb, numb, nil];
    sinkStatus2 = [[NSMutableArray alloc] initWithObjects:numb, numb, numb, numb, numb, nil];
    
    navController = [[UINavigationController alloc] init];
    viewC = [[ViewController alloc] init];
    [navController pushViewController:viewC animated:YES];
    
    whoseTurn = 0;
    //[self.window addSubview:self.viewC.view];
    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

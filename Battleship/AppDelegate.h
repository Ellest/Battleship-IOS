//
//  AppDelegate.h
//  Lab5-ElliotYun
//
//  Created by Labuser on 11/3/14.
//  Copyright (c) 2014 com. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ViewController.h"

NSMutableArray *gameBoard;
NSMutableArray *gameBoard2;
NSMutableArray *playBoard;
NSMutableArray *playBoard2;
NSMutableArray *pieceBoard;
NSMutableArray *pieceBoard2;
int playerFlag;
int player1ships;
int player2ships;
int vsIndTrack;
int vsLoaded;

NSMutableArray *shipsLeft1;
NSMutableArray *shipsLeft2;
NSMutableArray *g1Ship1;
NSMutableArray *g1Ship2;
NSMutableArray *g1Ship3;
NSMutableArray *g1Ship4;
NSMutableArray *g1Ship5;

NSMutableArray *g2Ship1;
NSMutableArray *g2Ship2;
NSMutableArray *g2Ship3;
NSMutableArray *g2Ship4;
NSMutableArray *g2Ship5;

int whoseTurn;
int shipsLeftCount1;
int shipsLeftCount2;

NSMutableArray *sinkStatus1;
NSMutableArray *sinkStatus2;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property UINavigationController *navController;
@property ViewController *viewC;

@end

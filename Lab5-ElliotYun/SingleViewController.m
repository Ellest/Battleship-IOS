//
//  SingleViewController.m
//  Lab5-ElliotYun
//
//  Created by Labuser on 11/6/14.
//  Copyright (c) 2014 com. All rights reserved.
//

#import "SingleViewController.h"
#import "AppDelegate.h"
#import "SinglePlayViewController.h"

@interface SingleViewController ()

@end

@implementation SingleViewController

@synthesize PlayerLabel, DoneButton;

UIButton *button;
int xCo;
CGFloat yCo;
NSArray *ships;
int bWidth;
int bHeight;
const int xBound = 184;
const int yBound = 312;
const int xBoundE3 = 584;
const int yBoundE3 = 712;
int xxx = 77;
int yyy = 312;
bool shipsPlaced;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

/*- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"pusher"]) {
        SinglePlayViewController *sv = segue.destinationViewController;
        sv.viewww = self;
    }
}*/

- (void)placeAI
{
    // 1 horizontal right , 2 vertical down, 3 horizontal left, 4 vertical up
    int decisionX;
    int decisionY;
    int decision;
    int dInd;
    int shipNum;
    bool notDone = true;
    // ship 5 (Aircraft Carrier) -----------------------------------------------------------------------------
    shipNum = 5;
    while (notDone){
        decisionX = arc4random() % 9;
        decisionY = arc4random() % 9;
        dInd = 10 * decisionY + decisionX;
        if (dInd == 100){
            continue;
        }
        decision = 0;
        if (decisionY < 4 && decisionX < 4){
            decision = 1;
        }
        else if (decisionY > 5 && decisionX > 5){
            if (arc4random() % 2 == 0){
                decision = 2;
            }
            else {
                decision = 3;
            }
        }
        else if (decisionY < 4){
            if (decisionX > 5){
                decision = 3;
            }
            else{
                if (arc4random() % 2 == 0){
                    decision = 3;
                }
                else {
                    decision = 1;
                }
            }
        }
        else if (decisionX > 5){
            if (arc4random() % 2 == 0){
                decision = 2;
            }
            else {
                decision = 3;
            }
        }
        else if (decisionX < 4){
            if (arc4random() % 2 == 0){
                decision = 2;
            }
            else {
                decision = 1;
            }
        }
        else {
            switch (arc4random() % 3 + 1){
                case 1: decision = 1; break;
                case 2: decision = 2; break;
                case 3: decision = 3; break;
            }
        }
        if (decision == 1){
            // 5 slots
            for (int i = 0; i < shipNum; i++){
                int pInd = dInd + i;
                NSString *pIs = [NSString stringWithFormat:@"%d", pInd];
                [gameBoard2 replaceObjectAtIndex:pInd withObject:@"1"];
                [[shipsLeft2 objectAtIndex:(shipNum - 1)] replaceObjectAtIndex:i withObject:pIs];
            }
        }
        else if (decision == 2){
            for (int i = 0; i < shipNum; i++){
                int pInd = dInd - (i * 10);
                NSString *pIs = [NSString stringWithFormat:@"%d", pInd];
                [gameBoard2 replaceObjectAtIndex:pInd withObject:@"1"];
                [[shipsLeft2 objectAtIndex:(shipNum - 1)] replaceObjectAtIndex:i withObject:pIs];
            }
        }
        else{
            for (int i = 0; i < shipNum; i++){
                int pInd = dInd - i;
                NSString *pIs = [NSString stringWithFormat:@"%d", pInd];
                [gameBoard2 replaceObjectAtIndex:pInd withObject:@"1"];
                [[shipsLeft2 objectAtIndex:(shipNum - 1)] replaceObjectAtIndex:i withObject:pIs];
            }
        }
        notDone = false;
    }
    
    // ship 4 (Battleship) ---------------------------------------------------------------------------------
    
    shipNum = 4;
    notDone = true;
    while (notDone){
        NSLog(@"Continuing");
        decisionX = arc4random() % 9;
        decisionY = arc4random() % 9;
        dInd = 10 * decisionY + decisionX;
        if (dInd == 100){
            continue;
        }
        decision = 0;
        if (decisionY < 3 && decisionX < 3){
            decision = 1;
        }
        else if (decisionY > 6 && decisionX > 6){
            if (arc4random() % 2 == 0){
                decision = 2;
            }
            else {
                decision = 3;
            }
        }
        else if (decisionY < 3){
            if (decisionX > 6){
                decision = 3;
            }
            else{
                if (arc4random() % 2 == 0){
                    decision = 3;
                }
                else {
                    decision = 1;
                }
            }
        }
        else if (decisionX > 6){
            if (arc4random() % 2 == 0){
                decision = 2;
            }
            else {
                decision = 3;
            }
        }
        else if (decisionX < 3){
            if (arc4random() % 2 == 0){
                decision = 2;
            }
            else {
                decision = 1;
            }
        }
        else {
            switch (arc4random() % 3 + 1){
                case 1: decision = 1; break;
                case 2: decision = 2; break;
                case 3: decision = 3; break;
            }
        }
        if (decision == 1){
            // 5 slots
            int cntr = 0;
            for (int i = 0; i < shipNum; i++){
                int pInd = dInd + i;
                NSString *pIs = [NSString stringWithFormat:@"%d", pInd];
                if ([[gameBoard2 objectAtIndex:pInd] isEqualToString:@"1"]){
                    for (int j = 1; j <= i; j++){
                        int rInd = pInd - j;
                        [gameBoard2 replaceObjectAtIndex:rInd withObject:@"0"];
                    }
                    for (int k = 0; i < shipNum; i++){
                        [[shipsLeft2 objectAtIndex:(shipNum - 1)] replaceObjectAtIndex:k withObject:@"0"];
                    }
                    cntr = 1;
                }
                else {
                    [gameBoard2 replaceObjectAtIndex:pInd withObject:@"1"];
                    [[shipsLeft2 objectAtIndex:(shipNum - 1)] replaceObjectAtIndex:i withObject:pIs];
                }
            }
            if (cntr != 0){
                continue;
            }
            notDone = false;
        }
        else if (decision == 2){
            int cntr = 0;
            for (int i = 0; i < shipNum; i++){
                int pInd = dInd - (i * 10);
                NSString *pIs = [NSString stringWithFormat:@"%d", pInd];
                if ([[gameBoard2 objectAtIndex:pInd] isEqualToString:@"1"]){
                    for (int j = 1; j <= i; j++){
                        int rInd = pInd + (j * 10);
                        [gameBoard2 replaceObjectAtIndex:rInd withObject:@"0"];
                    }
                    for (int k = 0; i < shipNum; i++){
                        [[shipsLeft2 objectAtIndex:(shipNum - 1)] replaceObjectAtIndex:k withObject:@"0"];
                    }
                    cntr = 1;
                }
                else {
                    [gameBoard2 replaceObjectAtIndex:pInd withObject:@"1"];
                    [[shipsLeft2 objectAtIndex:(shipNum - 1)] replaceObjectAtIndex:i withObject:pIs];
                }
            }
            if (cntr != 0){
                continue;
            }
            notDone = false;
        }
        else{
            int cntr = 0;
            for (int i = 0; i < shipNum; i++){
                int pInd = dInd - i;
                NSString *pIs = [NSString stringWithFormat:@"%d", pInd];
                if ([[gameBoard2 objectAtIndex:pInd] isEqualToString:@"1"]){
                    for (int j = 1; j <= i; j++){
                        int rInd = pInd + j;
                        [gameBoard2 replaceObjectAtIndex:rInd withObject:@"0"];
                    }
                    for (int k = 0; i < shipNum; i++){
                        [[shipsLeft2 objectAtIndex:(shipNum - 1)] replaceObjectAtIndex:k withObject:@"0"];
                    }
                    cntr = 1;
                }
                else {
                    [gameBoard2 replaceObjectAtIndex:pInd withObject:@"1"];
                    [[shipsLeft2 objectAtIndex:(shipNum - 1)] replaceObjectAtIndex:i withObject:pIs];
                }
            }
            if (cntr != 0){
                continue;
            }
            notDone = false;
        }
        
    }
    
    
    // ship 3 (Submarine) ---------------------------------------------------------------------------------
    
    shipNum = 3;
    notDone = true;
    while (notDone){
        NSLog(@"Continuing2");
        decisionX = arc4random() % 9;
        decisionY = arc4random() % 9;
        dInd = 10 * decisionY + decisionX;
        if (dInd == 100){
            continue;
        }
        decision = 0;
        if (decisionY < 2 && decisionX < 2){
            decision = 1;
        }
        else if (decisionY > 7 && decisionX > 7){
            if (arc4random() % 2 == 0){
                decision = 2;
            }
            else {
                decision = 3;
            }
        }
        else if (decisionY < 2){
            if (decisionX > 7){
                decision = 3;
            }
            else{
                if (arc4random() % 2 == 0){
                    decision = 3;
                }
                else {
                    decision = 1;
                }
            }
        }
        else if (decisionX > 7){
            if (arc4random() % 2 == 0){
                decision = 2;
            }
            else {
                decision = 3;
            }
        }
        else if (decisionX < 2){
            if (arc4random() % 2 == 0){
                decision = 2;
            }
            else {
                decision = 1;
            }
        }
        else {
            switch (arc4random() % 3 + 1){
                case 1: decision = 1; break;
                case 2: decision = 2; break;
                case 3: decision = 3; break;
            }
        }
        if (decision == 1){
            // 5 slots
            int cntr = 0;
            for (int i = 0; i < shipNum; i++){
                int pInd = dInd + i;
                NSString *pIs = [NSString stringWithFormat:@"%d", pInd];
                if ([[gameBoard2 objectAtIndex:pInd] isEqualToString:@"1"]){
                    for (int j = 1; j <= i; j++){
                        int rInd = pInd - j;
                        [gameBoard2 replaceObjectAtIndex:rInd withObject:@"0"];
                    }
                    for (int k = 0; i < shipNum; i++){
                        [[shipsLeft2 objectAtIndex:(shipNum - 1)] replaceObjectAtIndex:k withObject:@"0"];
                    }
                    cntr = 1;
                }
                else {
                    [gameBoard2 replaceObjectAtIndex:pInd withObject:@"1"];
                    [[shipsLeft2 objectAtIndex:(shipNum - 1)] replaceObjectAtIndex:i withObject:pIs];
                }
            }
            if (cntr != 0){
                continue;
            }
            notDone = false;
        }
        else if (decision == 2){
            int cntr = 0;
            for (int i = 0; i < shipNum; i++){
                int pInd = dInd - (i * 10);
                NSString *pIs = [NSString stringWithFormat:@"%d", pInd];
                if ([[gameBoard2 objectAtIndex:pInd] isEqualToString:@"1"]){
                    for (int j = 1; j <= i; j++){
                        int rInd = pInd + (j * 10);
                        [gameBoard2 replaceObjectAtIndex:rInd withObject:@"0"];
                    }
                    for (int k = 0; i < shipNum; i++){
                        [[shipsLeft2 objectAtIndex:(shipNum - 1)] replaceObjectAtIndex:k withObject:@"0"];
                    }
                    cntr = 1;
                }
                else {
                    [gameBoard2 replaceObjectAtIndex:pInd withObject:@"1"];
                    [[shipsLeft2 objectAtIndex:(shipNum - 1)] replaceObjectAtIndex:i withObject:pIs];
                }
            }
            if (cntr != 0){
                continue;
            }
            notDone = false;
        }
        else{
            int cntr = 0;
            for (int i = 0; i < shipNum; i++){
                int pInd = dInd - i;
                NSString *pIs = [NSString stringWithFormat:@"%d", pInd];
                if ([[gameBoard2 objectAtIndex:pInd] isEqualToString:@"1"]){
                    for (int j = 1; j <= i; j++){
                        int rInd = pInd + j;
                        [gameBoard2 replaceObjectAtIndex:rInd withObject:@"0"];
                    }
                    for (int k = 0; i < shipNum; i++){
                        [[shipsLeft2 objectAtIndex:(shipNum - 1)] replaceObjectAtIndex:k withObject:@"0"];
                    }
                    cntr = 1;
                }
                else {
                    [gameBoard2 replaceObjectAtIndex:pInd withObject:@"1"];
                    [[shipsLeft2 objectAtIndex:(shipNum - 1)] replaceObjectAtIndex:i withObject:pIs];
                }
            }
            if (cntr != 0){
                continue;
            }
            notDone = false;
        }
    }
    
    // ship 2 (Destroyer) ---------------------------------------------------------------------------------
    
    shipNum = 2;
    notDone = true;
    while (notDone){
        NSLog(@"Continuing3");
        decisionX = arc4random() % 9;
        decisionY = arc4random() % 9;
        dInd = 10 * decisionY + decisionX;
        if (dInd == 100){
            continue;
        }
        decision = 0;
        if (decisionY < 2 && decisionX < 2){
            decision = 1;
        }
        else if (decisionY > 7 && decisionX > 7){
            if (arc4random() % 2 == 0){
                decision = 2;
            }
            else {
                decision = 3;
            }
        }
        else if (decisionY < 2){
            if (decisionX > 7){
                decision = 3;
            }
            else{
                if (arc4random() % 2 == 0){
                    decision = 3;
                }
                else {
                    decision = 1;
                }
            }
        }
        else if (decisionX > 7){
            if (arc4random() % 2 == 0){
                decision = 2;
            }
            else {
                decision = 3;
            }
        }
        else if (decisionX < 2){
            if (arc4random() % 2 == 0){
                decision = 2;
            }
            else {
                decision = 1;
            }
        }
        else {
            switch (arc4random() % 3 + 1){
                case 1: decision = 1; break;
                case 2: decision = 2; break;
                case 3: decision = 3; break;
            }
        }
        if (decision == 1){
            // 5 slots
            int cntr = 0;
            for (int i = 0; i <= shipNum; i++){
                int pInd = dInd + i;
                NSString *pIs = [NSString stringWithFormat:@"%d", pInd];
                if ([[gameBoard2 objectAtIndex:pInd] isEqualToString:@"1"]){
                    for (int j = 1; j <= i; j++){
                        int rInd = pInd - j;
                        [gameBoard2 replaceObjectAtIndex:rInd withObject:@"0"];
                    }
                    for (int k = 0; i <= shipNum; i++){
                        [[shipsLeft2 objectAtIndex:(shipNum - 1)] replaceObjectAtIndex:k withObject:@"0"];
                    }
                    cntr = 1;
                }
                else {
                    [gameBoard2 replaceObjectAtIndex:pInd withObject:@"1"];
                    [[shipsLeft2 objectAtIndex:(shipNum - 1)] replaceObjectAtIndex:i withObject:pIs];
                }
            }
            if (cntr != 0){
                continue;
            }
            notDone = false;
        }
        else if (decision == 2){
            int cntr = 0;
            for (int i = 0; i <= shipNum; i++){
                int pInd = dInd - (i * 10);
                NSString *pIs = [NSString stringWithFormat:@"%d", pInd];
                if ([[gameBoard2 objectAtIndex:pInd] isEqualToString:@"1"]){
                    for (int j = 1; j <= i; j++){
                        int rInd = pInd + (j * 10);
                        [gameBoard2 replaceObjectAtIndex:rInd withObject:@"0"];
                    }
                    for (int k = 0; i <= shipNum; i++){
                        [[shipsLeft2 objectAtIndex:(shipNum - 1)] replaceObjectAtIndex:k withObject:@"0"];
                    }
                    cntr = 1;
                }
                else {
                    [gameBoard2 replaceObjectAtIndex:pInd withObject:@"1"];
                    [[shipsLeft2 objectAtIndex:(shipNum - 1)] replaceObjectAtIndex:i withObject:pIs];
                }
            }
            if (cntr != 0){
                continue;
            }
            notDone = false;
        }
        else{
            int cntr = 0;
            for (int i = 0; i <= shipNum; i++){
                int pInd = dInd - i;
                NSString *pIs = [NSString stringWithFormat:@"%d", pInd];
                if ([[gameBoard2 objectAtIndex:pInd] isEqualToString:@"1"]){
                    for (int j = 1; j <= i; j++){
                        int rInd = pInd + j;
                        [gameBoard2 replaceObjectAtIndex:rInd withObject:@"0"];
                    }
                    for (int k = 0; i <= shipNum; i++){
                        [[shipsLeft2 objectAtIndex:(shipNum - 1)] replaceObjectAtIndex:k withObject:@"0"];
                    }
                    cntr = 1;
                }
                else {
                    [gameBoard2 replaceObjectAtIndex:pInd withObject:@"1"];
                    [[shipsLeft2 objectAtIndex:(shipNum - 1)] replaceObjectAtIndex:i withObject:pIs];
                }
            }
            if (cntr != 0){
                continue;
            }
            notDone = false;
        }
    }
    
    // ship 1 (Patrol Boat) ---------------------------------------------------------------------------------
    
    shipNum = 1;
    notDone = true;
    while (notDone){
        NSLog(@"Continuing4");
        decisionX = arc4random() % 9;
        decisionY = arc4random() % 9;
        dInd = 10 * decisionY + decisionX;
        if (dInd == 100){
            continue;
        }
        decision = 0;
        if (decisionY < 1 && decisionX < 1){
            decision = 1;
        }
        else if (decisionY > 8 && decisionX > 8){
            if (arc4random() % 2 == 0){
                decision = 2;
            }
            else {
                decision = 3;
            }
        }
        else if (decisionY < 1){
            if (decisionX > 8){
                decision = 3;
            }
            else{
                if (arc4random() % 2 == 0){
                    decision = 3;
                }
                else {
                    decision = 1;
                }
            }
        }
        else if (decisionX > 8){
            if (arc4random() % 2 == 0){
                decision = 2;
            }
            else {
                decision = 3;
            }
        }
        else if (decisionX < 1){
            if (arc4random() % 2 == 0){
                decision = 2;
            }
            else {
                decision = 1;
            }
        }
        else {
            switch (arc4random() % 3 + 1){
                case 1: decision = 1; break;
                case 2: decision = 2; break;
                case 3: decision = 3; break;
            }
        }
        if (decision == 1){
            // 5 slots
            int cntr = 0;
            for (int i = 0; i <= shipNum; i++){
                int pInd = dInd + i;
                NSString *pIs = [NSString stringWithFormat:@"%d", pInd];
                if ([[gameBoard2 objectAtIndex:pInd] isEqualToString:@"1"]){
                    for (int j = 1; j <= i; j++){
                        int rInd = pInd - j;
                        [gameBoard2 replaceObjectAtIndex:rInd withObject:@"0"];
                    }
                    for (int k = 0; i <= shipNum; i++){
                        [[shipsLeft2 objectAtIndex:(shipNum - 1)] replaceObjectAtIndex:k withObject:@"0"];
                    }
                    cntr = 1;
                }
                else {
                    [gameBoard2 replaceObjectAtIndex:pInd withObject:@"1"];
                    [[shipsLeft2 objectAtIndex:(shipNum - 1)] replaceObjectAtIndex:i withObject:pIs];
                }
            }
            if (cntr != 0){
                continue;
            }
            notDone = false;
        }
        else if (decision == 2){
            int cntr = 0;
            for (int i = 0; i <= shipNum; i++){
                int pInd = dInd - (i * 10);
                NSString *pIs = [NSString stringWithFormat:@"%d", pInd];
                if ([[gameBoard2 objectAtIndex:pInd] isEqualToString:@"1"]){
                    for (int j = 1; j <= i; j++){
                        int rInd = pInd + (j * 10);
                        [gameBoard2 replaceObjectAtIndex:rInd withObject:@"0"];
                    }
                    for (int k = 0; i <= shipNum; i++){
                        [[shipsLeft2 objectAtIndex:(shipNum - 1)] replaceObjectAtIndex:k withObject:@"0"];
                    }
                    cntr = 1;
                }
                else {
                    [gameBoard2 replaceObjectAtIndex:pInd withObject:@"1"];
                    [[shipsLeft2 objectAtIndex:(shipNum - 1)] replaceObjectAtIndex:i withObject:pIs];
                }
            }
            if (cntr != 0){
                continue;
            }
            notDone = false;
        }
        else{
            int cntr = 0;
            for (int i = 0; i <= shipNum; i++){
                int pInd = dInd - i;
                NSString *pIs = [NSString stringWithFormat:@"%d", pInd];
                if ([[gameBoard2 objectAtIndex:pInd] isEqualToString:@"1"]){
                    for (int j = 1; j <= i; j++){
                        int rInd = pInd + j;
                        [gameBoard2 replaceObjectAtIndex:rInd withObject:@"0"];
                    }
                    for (int k = 0; i <= shipNum; i++){
                        [[shipsLeft2 objectAtIndex:(shipNum - 1)] replaceObjectAtIndex:k withObject:@"0"];
                    }
                    cntr = 1;
                }
                else {
                    [gameBoard2 replaceObjectAtIndex:pInd withObject:@"1"];
                    [[shipsLeft2 objectAtIndex:(shipNum - 1)] replaceObjectAtIndex:i withObject:pIs];
                }
            }
            if (cntr != 0){
                continue;
            }
            notDone = false;
        }
    }

    NSLog(@"Done");
    
    
    shipsPlaced = true;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    whoseTurn = arc4random() % 2 + 1;
    [DoneButton setHidden:true];
                self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"1024x1024.jpeg"]];
    [self.navigationController setNavigationBarHidden:YES];
    UILabel *setLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 200, 100, 100)];
    [setLabel setText:@"AI Placing Pieces. Please Wait"];
    [self.view addSubview:setLabel];
    shipsPlaced = false;
    [self placeAI];
    while (!shipsPlaced){
        NSLog(@"No");
    }
    [setLabel removeFromSuperview];
    [self.PlayerLabel setText:@"Player 1"];
    [self.PlayerLabel setFont:[UIFont fontWithName:@"Superclarendon" size:20.0]];
    [self.PlayerLabel setTextColor:[UIColor whiteColor]];
    // initializing the grid
    int xCord = 184;
    int yCord = 312;
    int xEnd = xCord + 400;
    int yEnd = yCord + 400;
    int xLabel = xCord - 40;
    int yLabel = yCord - 40;
    NSArray *na = [[NSArray alloc] initWithObjects:@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", nil];
    int labe = 0;
    while (xCord < xEnd){
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(xCord, yLabel, 40, 40)];
        NSString *element = [na objectAtIndex:labe];
        label.text = element;
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setTextColor:[UIColor whiteColor]];
        [self.view addSubview:label];
        labe++;
        xCord += 40;
    }
    labe = 10;
    while (yCord < yEnd){
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(xLabel, yCord, 40, 40)];
        NSString *strFromInt = [NSString stringWithFormat:@"%d",labe];
        label.text = strFromInt;
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setTextColor:[UIColor whiteColor]];
        [self.view addSubview:label];
        labe--;
        yCord += 40;
    }
    // resetting draw cords
    xCord = 184;
    yCord = 312;
    while(xCord <= xEnd){
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(xCord, yCord, 2, 400)];
        view.backgroundColor = [UIColor blueColor];
        [self.view addSubview:view];
        xCord += 40.4;
    }
    // resetting draw cords
    xCord = 184;
    yCord = 312;
    while(yCord <= yEnd){
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(xCord, yCord, 400, 2)];
        view.backgroundColor = [UIColor blueColor];
        [self.view addSubview:view];
        yCord += 40.4;
    }
    
    xCord = 184;
    yCord = 547;
    yEnd = yCord + 400;
    int x = 10;
    int y = 10;
    int yButton = yEnd - 40;
    int ind;
    for (int j = 0; j < y; j++) {
        for (int i = 0; i < x; i++) {
            ind = x * j + i;
            //UIView *viewIs = [[UIView alloc] initWithFrame:CGRectMake(xValue, yValue, 40, 40)];
            //[self.view addSubview:viewIs];
            UIButton *buttonz = [UIButton buttonWithType: UIButtonTypeRoundedRect];
            buttonz.frame = CGRectMake(xCord + (i * 40) + 1, yButton - (j * 40) + 1, 40, 40);
            buttonz.tag = ind;
            
            //[button setTitle:@"Hello" forState:UIControlStateNormal];
            [playBoard addObject:buttonz];
            //[playBoard replaceObjectAtIndex:ind withObject:buttonz];
            //[self.view addSubview:buttonz];
        }
    }
    ships = [[NSArray alloc] initWithObjects:self.Ship5, self.Ship4, self.Ship3, self.Ship2, self.Ship1, nil];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)MoveShip:(id)sender withEvent:(UIEvent *) event{
    
    CGPoint point = [[[event allTouches] anyObject] locationInView:self.view];
    UIControl *control = sender;
    control.center = point;
    button = sender;
    [button setTranslatesAutoresizingMaskIntoConstraints:YES];
    [self.view bringSubviewToFront:button];
    yCo = button.frame.origin.y;
    bWidth = button.frame.size.width;
    bHeight = button.frame.size.height;
    [sender addTarget:self action:@selector(touchesEnded:withEvent:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    int checking;
    int topLeftX = button.frame.origin.x;
    int topRightX = button.frame.origin.x + button.frame.size.width;
    int topY = button.frame.origin.y;
    int bottomY = button.frame.origin.y + button.frame.size.height;
    int startX = 77;
    //int startY = yCo;
    CGFloat xCoord = button.frame.origin.x;
    CGFloat yCoord = button.frame.origin.y;
    if (topLeftX < 169 || topRightX > 599 || topY < 297 || bottomY > 727) {
        xCoord = 77;
        yCoord = yCo;
        checking = 1;
        [DoneButton setHidden:true];
    }
    else {
        int width = 40;
        int offSetX = (int)(xCoord-184)%width;
        int offSetY = (int)(yCoord-312)%width;
        if (offSetX > width/2) {
            xCoord += (width - offSetX);
        }
        else {
            xCoord -= offSetX;
        }
        if (offSetY > width/2) {
            yCoord += (width - offSetY);
        }
        else {
            yCoord -= offSetY;
        }
        xCoord += 1;
        yCoord += 1;
    }
    
    /*[UIView animateWithDuration:0.4 delay:0.0 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^ {
     button.frame = CGRectMake(xCoord, yCoord, button.frame.size.width,button.frame.size.height);
     }
     completion:^(BOOL finished) {}
     ];*/
    
    button.frame = CGRectMake(xCoord, yCoord, button.frame.size.width,button.frame.size.height);
    
    NSLog(@"\n");
    checking = 0;
    if (button.frame.origin.x != startX) {
        CGRect frame1 = [button frame];
        for (UIButton* ship in ships) {
            if (button.tag != ship.tag) {
                CGRect frame2 = [ship frame];
                if(CGRectIntersectsRect(frame1, frame2)) {
                    /*[UIView animateWithDuration:0.4 delay:0.0 options: UIViewAnimationOptionCurveEaseInOut
                     animations:^ {
                     button.frame = CGRectMake(startX, yCo, button.frame.size.width,button.frame.size.height);
                     }
                     completion:^(BOOL finished) {}];*/
                    button.frame = CGRectMake(startX, yCo, button.frame.size.width,button.frame.size.height);
                    checking = 1;
                    [DoneButton setHidden:true];
                    break;
                }
            }
        }
    }
    if (button.frame.origin.x == startX){
        checking = 1;
    }
    if (checking != 1){
        for (int i = 0; i < 100; i ++){
            [gameBoard replaceObjectAtIndex:i withObject: @"0"];
        }
        [DoneButton setHidden:true];
        for (UIButton* ship in ships) {
            int shipT = (int)ship.tag;
            shipT--;
            int currX = ship.frame.origin.x;
            int currY = ship.frame.origin.y;
            if (currX < xBound){
                continue;
            }
            int modFactor = 40;
            int compX = currX - xBound;
            int compY = yBoundE3 - currY;
            int modX = compX % modFactor;
            int modY = compY % modFactor;
            compX -= modX;
            compY -= modY;
            int resultX = compX / modFactor;
            int resultY = compY / modFactor;
            //NSLog(@"resultX: %d  resultY: %d", resultX, resultY);
            if (resultY == 10){
                resultY--;
            }
            int index = 10 * resultY + resultX;
            int vertical;
            int horizontal;
            vertical = ship.frame.size.height;
            horizontal = ship.frame.size.width;
            vertical += vertical % 40;
            horizontal += horizontal % 40;
            int horizontalX = horizontal / 40;
            int verticalY = vertical / 40;
            NSString *rss;
            //NSLog(@"horizontalX: %d  verticalY: %d", horizontalX, verticalY);
            if (verticalY == 1){
                for (int i = 0; i < horizontalX; i++){
                    int na = index + i;
                    //NSLog(@"%d", na);
                    rss = [NSString stringWithFormat:@"%d", na];
                    [gameBoard replaceObjectAtIndex:na withObject: @"1"];
                    [[shipsLeft1 objectAtIndex:shipT] replaceObjectAtIndex:i withObject:rss];
                }
            }
            else if (horizontalX == 1){
                for (int i = 0; i < verticalY; i++){
                    int na = index - i * 10 ;
                    //NSLog(@"%d", na);
                    rss = [NSString stringWithFormat:@"%d", na];
                    [gameBoard replaceObjectAtIndex:na withObject: @"1"];
                    [[shipsLeft1 objectAtIndex:shipT] replaceObjectAtIndex:i withObject:rss];
                }
            }
            int counter = 0;
            for (NSObject *object in gameBoard) {
                if ([object isEqual:@"1"])
                    counter++;
            }
            if (counter == 17){
                [DoneButton setHidden:false];
            }
        }
        for (int i = 0; i < 100; i++){
            NSLog(@"%d: %@", i, [gameBoard objectAtIndex:i]);
        }
        if (!shipsPlaced){
            [DoneButton setHidden:true];
        }
        NSLog(@"Touch event for parent");
        /*if (button.tag <= 2){
         int shipId = button.tag + 1;
         }
         else {
         int shipId = button.tag;
         }*/
        //NSLog(@"xCoord: %f  yCoord: %f", xCoord, yCoord);
        
        //NSLog(@"horizontalX: %d   verticalY: %d", horizontalX, verticalY);
        
        //NSLog(@"%@",[gameBoard objectAtIndex:index]);
        //NSLog(@"Index: %d", index);
    }
}

- (void) viewWillAppear:(BOOL)animated
{
    NSLog(@"%d", shipsPlaced);
}

- (IBAction)ShipRotate:(id)sender {
    [DoneButton setHidden:true];
    UIButton *butt = sender;
    [butt setTransform:CGAffineTransformRotate(butt.transform, M_PI/2)];
    //butt.frame = CGRectMake(xx, yy, butt.frame.size.width,butt.frame.size.height);
}
- (IBAction)DoneAct:(id)sender {
    SinglePlayViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"9"];
    [self.navigationController pushViewController:vc animated:YES];
    //[self performSegueWithIdentifier:(NSString *) sender:(id)]
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

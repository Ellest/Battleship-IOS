//
//  SinglePlayViewController.m
//  Lab5-ElliotYun
//
//  Created by Labuser on 11/6/14.
//  Copyright (c) 2014 com. All rights reserved.
//

#import "SinglePlayViewController.h"
#import "AppDelegate.h"

@interface SinglePlayViewController ()
{
    AVAudioPlayer *sinkSound5;
    AVAudioPlayer *winSound5;
    AVAudioPlayer *loseSound5;
}

@end

@implementation SinglePlayViewController

@synthesize lab, s, che, aiDir;

int tagTrack;
int loaded;
int indTrack;
bool hitS;
int hitInd;
//int aiDir;
int hitOrigin;
int dirX;
int dirY;
bool sunkFlag;
int horCount;
int verCount;
int orX;
int orY;
ViewController *viewww;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//- (void)

/*- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"pusher"]) {
        NSLog(@"HI");
    }
}*/

- (void)updater:(int)index :(BOOL)AI
{
    NSLog(@"HI1");
    if (!AI){
    //NSLog(@"%d", (int)[shipsLeft2 count]);
    NSString *sIs = [NSString stringWithFormat:@"%d", index];
    NSMutableArray *currS;
    for (int i = 0; i < [shipsLeft2 count]; i++){
        currS = [shipsLeft2 objectAtIndex:i];
        for (int j = 0; j < [currS count]; j++){
            if ([[currS objectAtIndex:j] isEqualToString:sIs]){
                [currS replaceObjectAtIndex:j withObject:@"-1"];
                if([self isSunken:i :false]){
                    //myFlag4 = true;
                    [sinkSound5 play];
                    NSNumber *newValue = [NSNumber numberWithBool:true];
                    [sinkStatus2 replaceObjectAtIndex:i withObject:newValue];
                    UIAlertView *alertSink = [[UIAlertView alloc] initWithTitle:@"Ship Sunk"
                                                                        message:@""
                                                                       delegate:nil
                                                              cancelButtonTitle:@"OK"
                                                              otherButtonTitles:nil];
                    switch (i + 1){
                        case 1:
                            [alertSink setMessage:@"You Sunk the Patrol Boat"];
                            [alertSink show];
                        case 2:
                            [alertSink setMessage:@"You Sunk the Destroyer"];
                            [alertSink show];
                        case 3:
                            [alertSink setMessage:@"You Sunk the Submarine"];
                            [alertSink show];
                        case 4:
                            [alertSink setMessage:@"You Sunk the Battleship"];
                            [alertSink show];
                        case 5:
                            [alertSink setMessage:@"You Sunk the Aircraft Carrier"];
                            [alertSink show];
                    }
                }
            }
        }
    }
    }
    else {
        NSLog(@"Should be HEre");
        NSString *sIs = [NSString stringWithFormat:@"%d", index];
        NSMutableArray *currS;
        for (int i = 0; i < [shipsLeft1 count]; i++){
            currS = [shipsLeft1 objectAtIndex:i];
            for (int j = 0; j < [currS count]; j++){
                if ([[currS objectAtIndex:j] isEqualToString:sIs]){
                    [currS replaceObjectAtIndex:j withObject:@"-1"];
                    if([self isSunken:i :true]){
                        //myFlag4 = true;
                        [sinkSound5 play];
                        NSNumber *newValue = [NSNumber numberWithBool:true];
                        [sinkStatus1 replaceObjectAtIndex:i withObject:newValue];
                        UIAlertView *alertSink = [[UIAlertView alloc] initWithTitle:@"Ship Sunk"
                                                                            message:@""
                                                                           delegate:nil
                                                                  cancelButtonTitle:@"OK"
                                                                  otherButtonTitles:nil];
                        switch (i + 1){
                            case 1:
                                [alertSink setMessage:@"Patrol Boat Sunk!"];
                                [alertSink show];
                            case 2:
                                [alertSink setMessage:@"Destroyer Sunk!"];
                                [alertSink show];
                            case 3:
                                [alertSink setMessage:@"Submarine Sunk!"];
                                [alertSink show];
                            case 4:
                                [alertSink setMessage:@"Battleship Sunk"];
                                [alertSink show];
                            case 5:
                                [alertSink setMessage:@"Aircraft Carrier Sunk!"];
                                [alertSink show];
                        }
                    }
                }
            }
        }
    }
}

-(BOOL)isSunken:(int)num :(BOOL)AI
{
    NSMutableArray *currA;
    int sinkCheck = 0;
    if (AI){
        currA = [shipsLeft1 objectAtIndex:num];
    }
    else {
        currA = [shipsLeft2 objectAtIndex:num];
    }
    for (int i = 0; i < [currA count]; i++){
        if ([[currA objectAtIndex:i] isEqualToString:@"-1"]){
            sinkCheck++;
        }
    }
    if (sinkCheck == [currA count]){
        NSLog(@"Sunk");
        if (AI){
            sunkFlag = true;
        }
        return true;
    }
    else {
        NSLog(@"NoSunk");
        return false;
    }
}

- (IBAction)buttonPressed :(id)sender
{
    loaded = 0;
    UIButton *newButton = sender;
    int indx = (int)newButton.tag;
    indTrack = indx;
    tagTrack = indx + 100;
    NSLog(@"<1> object at %d: %@", indx, [gameBoard2 objectAtIndex:indx]);
    newButton.enabled = NO;
    if ([[gameBoard2 objectAtIndex:indx] isEqualToString:@"1"]){
        [newButton setBackgroundColor:[UIColor greenColor]];
        [gameBoard2 replaceObjectAtIndex:indx withObject:@"2"];
        [self updater:indx :false];
        player1ships--;
        if (player1ships == 0){
            [winSound5 play];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Game Over"
                                                            message:@"You Win! \n Please Reopen App to Start a New Game"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
        NSLog(@"player1: %d", player1ships);
    }
    else{
        [newButton setBackgroundColor:[UIColor redColor]];
    }
    [playBoard replaceObjectAtIndex:indx withObject:newButton];
    if (hitS){
        [self aIMove];
    }
    else {
        [self aIRandMove];
    }
    
    /*if ([self isViewLoaded]){
        [self viewWillAppear:YES];
    }*/
    //secondPlayer = [[PlayViewController2 alloc] init];
    
    //[self presentViewController:secondPlayer animated:YES completion:nil];
    
}

- (void)viewDidLoad
{
    //[super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
                self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"1024x1024.jpeg"]];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"explosion" ofType:@"wav"];
    NSURL *urlString = [NSURL fileURLWithPath:path];
    NSError *err;
    sinkSound5 = [[AVAudioPlayer alloc] initWithContentsOfURL:urlString error:&err];
    [winSound5 setVolume:3.5];
    
    NSString *path2 = [[NSBundle mainBundle] pathForResource:@"cheer" ofType:@"wav"];
    NSURL *urlString2 = [NSURL fileURLWithPath:path2];
    NSError *err2;
    winSound5 = [[AVAudioPlayer alloc] initWithContentsOfURL:urlString2 error:&err2];
    [winSound5 setVolume:5.0];
    
    NSString *path3 = [[NSBundle mainBundle] pathForResource:@"boo" ofType:@"wav"];
    NSURL *urlString3 = [NSURL fileURLWithPath:path3];
    NSError *err3;
    loseSound5 = [[AVAudioPlayer alloc] initWithContentsOfURL:urlString3 error:&err3];
    [loseSound5 setVolume:5.0];
    //[self.navigationController removeFromParentViewController];
    loaded = 1;
    sunkFlag = false;
    int ind;
    int xCord = 184;
    int yCord = 77;
    int xEnd = xCord + 400;
    int yEnd = yCord + 400;
    int xLabel = xCord - 40;
    int yLabel = yEnd;
    NSArray *na = [[NSArray alloc] initWithObjects:@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", nil];
    int labe = 0;;
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
    yCord = 77;
    while(xCord <= xEnd){
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(xCord, yCord, 2, 400)];
        view.backgroundColor = [UIColor blueColor];
        [self.view addSubview:view];
        xCord += 40.4;
    }
    // resetting draw cords
    xCord = 184;
    yCord = 77;
    while(yCord <= yEnd){
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(xCord, yCord, 400, 2)];
        view.backgroundColor = [UIColor blueColor];
        [self.view addSubview:view];
        yCord += 40.4;
    }
    
    xCord = 184;
    yCord = 77;
    int yButton = 437;
    int x = 10;
    int y = 10;
    for (int j = 0; j < y; j++) {
        for (int i = 0; i < x; i++) {
            ind = x * j + i;
            //UIView *viewIs = [[UIView alloc] initWithFrame:CGRectMake(xValue, yValue, 40, 40)];
            //[self.view addSubview:viewIs];
            //UIButton *buttonzs = [playBoard objectAtIndex:ind];
            //[button setTitle:@"Hello" forState:UIControlStateNormal];
            UIButton *buttonzs = [UIButton buttonWithType: UIButtonTypeRoundedRect];
            buttonzs.frame = CGRectMake(xCord + (i * 40), yButton - (j * 40), 40, 40);
            buttonzs.enabled = NO;
            buttonzs.tag = ind + 100;
            if ([[gameBoard objectAtIndex:ind] isEqualToString:@"0"]){
                //[buttonz setBackgroundColor:[UIColor blueColor]];
            }
            else {
                [buttonzs setBackgroundColor:[UIColor purpleColor]];
            }
            //buttonz.tag = ind;
            //NSLog(@"index: %d  tag: %d", ind, (int)buttonz.tag);
            //[button setTitle:@"Hello" forState:UIControlStateNormal];*/
            [self.view addSubview:buttonzs];
        }
    }
    //UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //secondPlayer = (PlayViewController2*)[self.storyboard instantiateViewControllerWithIdentifier:@"2"];
    xCord = 184;
    yCord = 547;
    xEnd = xCord + 400;
    yEnd = yCord + 400;
    xLabel = xCord - 40;
    yLabel = yCord - 40;
    labe = 0;;
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
    yCord = 547;
    while(xCord <= xEnd){
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(xCord, yCord, 2, 400)];
        view.backgroundColor = [UIColor blueColor];
        [self.view addSubview:view];
        xCord += 40.4;
    }
    // resetting draw cords
    xCord = 184;
    yCord = 547;
    while(yCord <= yEnd){
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(xCord, yCord, 400, 2)];
        view.backgroundColor = [UIColor blueColor];
        [self.view addSubview:view];
        yCord += 40.4;
    }
    
    xCord = 184;
    yCord = 547;
    x = 10;
    y = 10;
    //int yButton = yEnd - 40;
    
    for (int j = 0; j < y; j++) {
        for (int i = 0; i < x; i++) {
            ind = x * j + i;
            //UIView *viewIs = [[UIView alloc] initWithFrame:CGRectMake(xValue, yValue, 40, 40)];
            //[self.view addSubview:viewIs];
            UIButton *buttonz = [playBoard objectAtIndex:ind];
            //[button setTitle:@"Hello" forState:UIControlStateNormal];
            //UIButton *buttonz = [UIButton buttonWithType: UIButtonTypeRoundedRect];
            //buttonz.frame = CGRectMake(xCord + (i * 40), yButton - (j * 40), 40, 40);
            //buttonz.tag = ind;
            //NSLog(@"index: %d  tag: %d", ind, (int)buttonz.tag);
            //[button setTitle:@"Hello" forState:UIControlStateNormal];
            [buttonz addTarget:self
                        action:@selector(buttonPressed:)
              forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:buttonz];
        }
    }
    
    if (whoseTurn == 2){
        [self aIRandMove];
    }
    // Do any additional setup after loading the view.
}

- (void)trackShip :(int)dex :(int)direct
{
    switch (direct){
        case 1:
            dex += 1; break;
        case 2:
            dex -= 10; break;
        case 3:
            dex -= 1; break;
        case 4:
            dex += 10;
    }
    [gameBoard replaceObjectAtIndex:dex withObject:@"2"];
    [self updater:dex :true];
    if (sunkFlag){
        return;
    }
    else {
        [self trackShip:dex :direct];
    }
}


-(void)aIRandMove
{
    int aiX = arc4random() % 10;
    int aiY = arc4random() % 10;
    int aiInd = 10 * aiY + aiX;
    while([[gameBoard objectAtIndex:aiInd] isEqualToString:@"2"] || aiInd == 100){
        aiX = arc4random() % 10;
        aiY = arc4random() % 10;
        aiInd = 10 * aiY + aiX;
    }
    if ([[gameBoard objectAtIndex:aiInd] isEqualToString:@"1"]){
        hitS = true;
        hitInd = aiInd;
        hitOrigin = aiInd;
        dirX = aiX;
        dirY = aiY;
        orX = aiX;
        orY = aiY;
        horCount = 0;
        verCount = 0;
        int hitTag = aiInd + 100;
        [self updater:aiInd :true];
        if (sunkFlag){
            hitS = false;
            sunkFlag = false;
        }
        UIButton *button = (UIButton *)[self.view viewWithTag:hitTag];
        [button setBackgroundColor:[UIColor redColor]];
        [gameBoard replaceObjectAtIndex:aiInd withObject:@"2"];
        aiDir = 1;
        player2ships--;
        if (player2ships == 0){
            [loseSound5 play];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Game Over"
                                                            message:@"Computer Wins! \n Please Reopen App to Start a New Game"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
    }
    else {
        hitS = false;
        hitInd = aiInd;
        int hitTag = aiInd + 100;
        UIButton *button = (UIButton *)[self.view viewWithTag:hitTag];
        [button setBackgroundColor:[UIColor blueColor]];
        [gameBoard replaceObjectAtIndex:aiInd withObject:@"2"];
    }
}



- (void)aIMove
{
    NSLog(@"aiDir: %d  | dirX: %d | dirY: %d | horCount: %d | verCount: %d", aiDir, dirX, dirY, horCount, verCount);
    if (aiDir > 4){
        
        [self aIRandMove];
    }
    if (aiDir == 1 && dirX == 9){
        if (horCount >= 1){
            aiDir = 3;
            dirX = orX;
            dirY = orY;
            hitInd = hitOrigin;
        }
        else {
            aiDir++;
        }
    }
    if (aiDir == 2 && dirY == 0){
        if (verCount >= 1){
            aiDir = 4;
            dirY = orY;
            dirX = orX;
            hitInd = hitOrigin;
        }
        else {
            aiDir++;
        }
    }
    if (aiDir == 3 && dirX == 0){
        if (horCount >= 1){
            if (verCount >= 1 || dirY == 0){
                aiDir = 4;
            }
            else {
                aiDir = 1;
            }
            dirX = orX;
            dirY = orY;
            hitInd = hitOrigin;
        }
        else {
            aiDir++;
        }
    }
    if (aiDir == 4 && dirY == 9){
        if (verCount >= 1){
            aiDir = 2;
            dirY = orY;
            dirX = orX;
            hitInd = hitOrigin;
        }
        else {
            aiDir = 0;
        }
    }
    int aiInd = 0;
    switch (aiDir){
        case 1:
            aiInd = hitInd + 1; break;
        case 2:
            aiInd = hitInd - 10; break;
        case 3:
            aiInd = hitInd - 1; break;
        case 4:
            aiInd = hitInd + 10;
                
    }
    // hit
    if ([[gameBoard objectAtIndex:aiInd] isEqualToString:@"1"]){
        NSLog(@"HIT");
        hitInd = aiInd;
        [self updater:aiInd :true];
        if (sunkFlag){
            sunkFlag = false;
            hitS = false;
            horCount = 0;
            verCount = 0;
        }
        if (aiDir == 1 || aiDir == 3){
            horCount++;
        }
        else if (aiDir == 2 || aiDir == 4){
            verCount++;
        }
        switch (aiDir){
            case 1:
                dirX++; break;
            case 2:
                dirY--; break;
            case 3:
                dirX--; break;
            case 4:
                dirY++; break;
        }
        int hitTag = aiInd + 100;
        UIButton *button = (UIButton *)[self.view viewWithTag:hitTag];
        [button setBackgroundColor:[UIColor redColor]];
        [gameBoard replaceObjectAtIndex:aiInd withObject:@"2"];
        player2ships--;
        if (player2ships == 0){
            [loseSound5 play];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Game Over"
                                                            message:@"Computer Wins! \n Please Reopen App to Start a New Game"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
    }
    // space already attacked
    else if ([[gameBoard objectAtIndex:aiInd] isEqualToString:@"2"]){
        NSLog(@"OCCUPIED");
        if (aiDir == 4){
            [self aIRandMove];
        }
        else{
            aiDir++;
            [self aIMove];
        }
    }
    // miss
    else {
        NSLog(@"MISS");
        int hitTag = aiInd + 100;
        UIButton *button = (UIButton *)[self.view viewWithTag:hitTag];
        [button setBackgroundColor:[UIColor blueColor]];
        [gameBoard replaceObjectAtIndex:aiInd withObject:@"2"];
        if (verCount >= 1){
            hitInd = hitOrigin;
                dirX = orX;
                dirY = orY;
                if (aiDir == 2){
                    aiDir = 4;
                }
                else {
                    aiDir = 2;
                }
        }
        else if (horCount >= 1){
            hitInd = hitOrigin;
            dirX = orX;
            dirY = orY;
            if (aiDir == 1){
                aiDir = 3;
            }
            else {
                aiDir = 1;
            }
        }
        else {
            aiDir++;
        }
    }
}




- (void)viewWillAppear:(BOOL)animated
{
    /*UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Test Message"
                                                    message:@"This is a test"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];*/
    int a = 0;
    if (a == 0){
        NSLog(@"0");
        a++;
    }
    else if (a == 1){
        NSLog(@"1");
    }
    if (loaded != 1){
        int ii = 0;
        for (id obj in gameBoard){
            if ([obj isEqualToString:@"2"]){
                ii++;
            }
        }
        NSLog(@"count is: %d", ii);
        /*for (int i = 0; i < 100; i++){
            if (i % 10 == 0){
                NSLog(@"%d: %@\n", i, [gameBoard objectAtIndex:i]);
            }
            else{
                NSLog(@"%d: %@", i, [gameBoard objectAtIndex:i]);
            }
        }*/
        /*UIButton *button = (UIButton *)[self.view viewWithTag:tagTrack];
        if ([[gameBoard objectAtIndex:indTrack] isEqualToString:@"0"]){
            [button setBackgroundColor:[UIColor orangeColor]];
        }
        else {
            [button setBackgroundColor:[UIColor greenColor]];
        }*/
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

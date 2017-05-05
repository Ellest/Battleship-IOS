//
//  PlayViewController3.m
//  Lab5-ElliotYun
//
//  Created by Labuser on 11/6/14.
//  Copyright (c) 2014 com. All rights reserved.
//

#import "PlayViewController3.h"
#import "AppDelegate.h"

@interface PlayViewController3 ()
{
    AVAudioPlayer *sinkSound3;
    AVAudioPlayer *winSound3;
}

@end

@implementation PlayViewController3

@synthesize secPlayer;

bool justLoaded3;
int myFlag3;
@synthesize shipsL1;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    while (buttonIndex != 0){
    }
    [self.navigationController pushViewController:(UIViewController*)secPlayer animated:YES ];
}

- (void)update3:(int)index
{
    NSLog(@"HI2");
    int debug = 1;
    for (id obj in shipsL1){
        for (id objj in obj){
            NSLog(@"%d:  %@", debug,objj);
        }
        debug++;
    }
    //NSLog(@"%d", (int)[shipsLeft1 count]);
    NSString *sIs2 = [NSString stringWithFormat:@"%d", index];
    NSMutableArray *curr3;
    for (int i = 0; i < [shipsL1 count]; i++){
        curr3 = [shipsL1 objectAtIndex:i];
        for (int j = 0; j < [curr3 count]; j++){
            if ([[curr3 objectAtIndex:j] isEqualToString:sIs2]){
                [curr3 replaceObjectAtIndex:j withObject:@"-1"];
                if([self isSunk3:i]){
                    NSLog(@"Sunk");
                    myFlag3 = true;
                    [sinkSound3 play];
                    NSNumber *newValue = [NSNumber numberWithBool:true];
                    [sinkStatus1 replaceObjectAtIndex:i withObject:newValue];
                    UIAlertView *alertSink = [[UIAlertView alloc] initWithTitle:@"Ship Sunk"
                                                                        message:@""
                                                                       delegate:self
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

-(BOOL)isSunk3:(int)num
{
    int sinkCheckr = 0;
    NSMutableArray *currD = [shipsL1 objectAtIndex:num];
    for (int i = 0; i < [currD count]; i++){
        if ([[currD objectAtIndex:i] isEqualToString:@"-1"]){
            sinkCheckr++;
        }
    }
    if (sinkCheckr == [currD count]){
        return true;
    }
    else {
        return false;
    }
}


- (IBAction)buttonPressedd :(id)sender
{
    justLoaded3 = false;
    myFlag3 = false;
    if (sender == NULL){
        return;
    }
    NSLog(@"HI");
    UIButton *newButton = sender;
    int indx = (int)newButton.tag;
    vsIndTrack = indx;
    newButton.enabled = NO;
    //NSLog(@"<2> object at %d: %@", indx, [gameBoard objectAtIndex:indx]);
    if ([[gameBoard objectAtIndex:indx] isEqualToString:@"1"]){
        [newButton setBackgroundColor:[UIColor greenColor]];
        player1ships--;
        NSLog(@"player1: %d", player1ships);
        if (player1ships == 0){
            [winSound3 play];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Game Over"
                                                            message:@"Player 2 Wins! \n Please Restart the Application for a New Game"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
        else {
            [self update3:indx];
            if (myFlag3){
                // wait for button push
            }
            else {
                [self.navigationController pushViewController:(UIViewController*)secPlayer animated:YES ];
            }
        }
    }
    else{
        [newButton setBackgroundColor:[UIColor redColor]];
        [self.navigationController pushViewController:(UIViewController*)secPlayer animated:YES ];
    }
    [playBoard2 replaceObjectAtIndex:indx withObject:newButton];
    
    //secondPlayer = [[PlayViewController2 alloc] init];
    
    
    //[self presentViewController:firstPlayer animated:YES completion:nil];
}

- (void)viewDidLoad
{
    /*for (int i = 0 ; i < 100; i++){
     NSLog(@"%@", [gameBoard2 objectAtIndex:i]);
     }*/
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"1024x1024.jpeg"]];
    UIImageView *background2 = [[UIImageView alloc] initWithFrame:CGRectMake(184, 77, 400, 400)];
    UIImageView *background22 = [[UIImageView alloc] initWithFrame:CGRectMake(184, 547, 400, 400)];
    [background2 setImage:[UIImage imageNamed:@"ocean-freashwater-aquifiers.jpg"]];
    [background22 setImage:[UIImage imageNamed:@"ocean-freashwater-aquifiers.jpg"]];
    [self.view addSubview:background2];
    [self.view addSubview:background22];
    
    UILabel *pLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(52, 497, 70, 70)];
    [pLabel2 setText:@"Player 2"];
    [pLabel2 setTextColor:[UIColor whiteColor]];
    [self.view addSubview:pLabel2];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"explosion" ofType:@"wav"];
    NSURL *urlString = [NSURL fileURLWithPath:path];
    NSError *err;
    sinkSound3 = [[AVAudioPlayer alloc] initWithContentsOfURL:urlString error:&err];
    [sinkSound3 setVolume:3.5];
    
    NSString *path2 = [[NSBundle mainBundle] pathForResource:@"cheer" ofType:@"wav"];
    NSURL *urlString2 = [NSURL fileURLWithPath:path2];
    NSError *err2;
    winSound3 = [[AVAudioPlayer alloc] initWithContentsOfURL:urlString2 error:&err2];
    [winSound3 setVolume:5.0];
    
    shipsL1 = shipsLeft1;
    
    [super viewDidLoad];
    int debug = 1;
    for (id obj in shipsLeft2){
        for (id objj in obj){
            NSLog(@"%d:  %@", debug,objj);
        }
        debug++;
    }
    justLoaded3 = true;
    [self.navigationController setNavigationBarHidden:YES];
    secPlayer = [self.storyboard instantiateViewControllerWithIdentifier:@"4"];
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
            //UIButton *buttonz = [playBoard objectAtIndex:ind];
            //[button setTitle:@"Hello" forState:UIControlStateNormal];
            UIButton *buttonzs = [UIButton buttonWithType: UIButtonTypeRoundedRect];
            buttonzs.frame = CGRectMake(xCord + (i * 40), yButton - (j * 40), 40, 40);
            buttonzs.tag = ind + 100;
            buttonzs.enabled = NO;
            if ([[gameBoard2 objectAtIndex:ind] isEqualToString:@"0"]){
                //[buttonz setBackgroundColor:[UIColor blueColor]];
            }
            else {
                [buttonzs setBackgroundColor:[UIColor purpleColor]];
            }
            //buttonz.tag = ind;
            //NSLog(@"index: %d  tag: %d", ind, (int)buttonz.tag);
            //[button setTitle:@"Hello" forState:UIControlStateNormal];
            [self.view addSubview:buttonzs];
        }
    }
    
    //UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //firstPlayer = (PlayViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"1"];
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
            UIButton *buttonz = [playBoard2 objectAtIndex:ind];
            //[button setTitle:@"Hello" forState:UIControlStateNormal];
            //UIButton *buttonz = [UIButton buttonWithType: UIButtonTypeRoundedRect];
            //buttonz.frame = CGRectMake(xCord + (i * 40), yButton - (j * 40), 40, 40);
            //buttonz.tag = ind;
            //NSLog(@"index: %d  tag: %d", ind, (int)buttonz.tag);
            //[button setTitle:@"Hello" forState:UIControlStateNormal];
            [buttonz addTarget:self
                        action:@selector(buttonPressedd:)
              forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:buttonz];
        }
    }
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void) viewWillAppear:(BOOL)animated
{
    if (!justLoaded3){
        UIAlertView *alertTurn = [[UIAlertView alloc] initWithTitle:@"Turn"
                                                            message:@"\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nPlayer Two's Turn\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        [alertTurn show];
    int tagIs = vsIndTrack + 100;
    UIButton *button = (UIButton *)[self.view viewWithTag:tagIs];
    if ([[gameBoard2 objectAtIndex:vsIndTrack] isEqualToString:@"0"]){
        [button setBackgroundColor:[UIColor blueColor]];
    }
    else if ([[gameBoard2 objectAtIndex:vsIndTrack] isEqualToString:@"1"]){
        [gameBoard2 replaceObjectAtIndex:vsIndTrack withObject:@"2"];
        [button setBackgroundColor:[UIColor redColor]];
    }
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

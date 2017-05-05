//
//  PlayViewController2.m
//  Lab5-ElliotYun
//
//  Created by Labuser on 11/5/14.
//  Copyright (c) 2014 com. All rights reserved.
//
#import "AppDelegate.h"
#import "PlayViewController2.h"

@interface PlayViewController2 ()
{
    AVAudioPlayer *sinkSound2;
    AVAudioPlayer *winSound2;
}

@end

@implementation PlayViewController2

@synthesize firstPlayer;

bool myFlag2;
int loaded = 0;

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
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)update2:(int)index
{
    NSLog(@"HI2");
    //NSLog(@"%d", (int)[shipsLeft1 count]);
    NSString *sIs = [NSString stringWithFormat:@"%d", index];
    NSMutableArray *curr2;
    for (int i = 0; i < [shipsLeft1 count]; i++){
        curr2 = [shipsLeft1 objectAtIndex:i];
        for (int j = 0; j < [curr2 count]; j++){
            if ([[curr2 objectAtIndex:j] isEqualToString:sIs]){
                [curr2 replaceObjectAtIndex:j withObject:@"-1"];
                if([self isSunk2:i]){
                    myFlag2 = true;
                    [sinkSound2 play];
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

-(BOOL)isSunk2:(int)num
{
    int sinkCheck = 0;
    NSMutableArray *currA = [shipsLeft1 objectAtIndex:num];
    for (int i = 0; i < [currA count]; i++){
        if ([[currA objectAtIndex:i] isEqualToString:@"-1"]){
            sinkCheck++;
        }
    }
    if (sinkCheck == [currA count]){
        return true;
    }
    else {
        return false;
    }
}


- (IBAction)buttonPressedd :(id)sender
{
    loaded = 1;
    myFlag2 = false;
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
            [winSound2 play];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Game Over"
                                                            message:@"Player 2 Wins! \n Please Restart the Application for a New Game"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
        else {
            [self update2:indx];
            if (myFlag2){
                // wait for button push
            }
            else {
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
    }
    else{
        [newButton setBackgroundColor:[UIColor redColor]];
        [self.navigationController popViewControllerAnimated:YES];
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
    
    [super viewDidLoad];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"explosion" ofType:@"wav"];
    NSURL *urlString = [NSURL fileURLWithPath:path];
    NSError *err;
    sinkSound2 = [[AVAudioPlayer alloc] initWithContentsOfURL:urlString error:&err];
    [sinkSound2 setVolume:3.5];
    
    NSString *path2 = [[NSBundle mainBundle] pathForResource:@"cheer" ofType:@"wav"];
    NSURL *urlString2 = [NSURL fileURLWithPath:path2];
    NSError *err2;
    winSound2 = [[AVAudioPlayer alloc] initWithContentsOfURL:urlString2 error:&err2];
    [winSound2 setVolume:5.0];
    [self.navigationController setNavigationBarHidden:YES];
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
    // Do any additional setup after loading the view.
}

-(void) viewWillAppear:(BOOL)animated
{
    /*UIAlertView *alertTurn = [[UIAlertView alloc] initWithTitle:@"Turn"
                                                        message:@"\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nPlayer Two's Turn\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertTurn show];*/

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
//
//  PlayViewController4.m
//  Lab5-ElliotYun
//
//  Created by Labuser on 11/6/14.
//  Copyright (c) 2014 com. All rights reserved.
//

#import "PlayViewController4.h"
#import "AppDelegate.h"

@interface PlayViewController4 (){
    AVAudioPlayer *sinkSound4;
    AVAudioPlayer *winSound4;
}

@end

@implementation PlayViewController4

@synthesize firPlayer;

bool justloaded;
bool myFlag4;

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

- (void)update:(int)index
{
    NSLog(@"HI1");
    //NSLog(@"%d", (int)[shipsLeft2 count]);
    NSString *sIs = [NSString stringWithFormat:@"%d", index];
    NSMutableArray *curr;
    for (int i = 0; i < [shipsLeft2 count]; i++){
        curr = [shipsLeft2 objectAtIndex:i];
        for (int j = 0; j < [curr count]; j++){
            if ([[curr objectAtIndex:j] isEqualToString:sIs]){
                [curr replaceObjectAtIndex:j withObject:@"-1"];
                if([self isSunk:i]){
                    myFlag4 = true;
                    [sinkSound4 play];
                    NSNumber *newValue = [NSNumber numberWithBool:true];
                    [sinkStatus2 replaceObjectAtIndex:i withObject:newValue];
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

-(BOOL)isSunk:(int)num
{
    int sinkCheck = 0;
    NSMutableArray *currA = [shipsLeft2 objectAtIndex:num];
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

- (IBAction)buttonPressed :(id)sender
{
    justloaded = false;
    myFlag4 = false;
    UIButton *newButton = sender;
    int indx = (int)newButton.tag;
    vsIndTrack = indx;
    //NSLog(@"<1> object at %d: %@", indx, [gameBoard2 objectAtIndex:indx]);
    newButton.enabled = NO;
    if ([[gameBoard2 objectAtIndex:indx] isEqualToString:@"1"]){
        [newButton setBackgroundColor:[UIColor greenColor]];
        player2ships--;
        NSLog(@"player2: %d", player2ships);
        if (player2ships==0){
            [winSound4 play];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Game Over"
                                                            message:@"Player 1 Wins! \n Please Restart the Application for a New Game"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
        else {
            [self update:indx];
            if (myFlag4){
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
    [playBoard replaceObjectAtIndex:indx withObject:newButton];
    //[self presentViewController:secondPlayer animated:YES completion:nil];
    
}

- (void)viewDidLoad
{
    /*for (int i = 0 ; i < 100; i++){
     NSLog(@"%@", [gameBoard objectAtIndex:i]);
     }*/
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"1024x1024.jpeg"]];
    UIImageView *background = [[UIImageView alloc] initWithFrame:CGRectMake(184, 77, 400, 400)];
    UIImageView *background12 = [[UIImageView alloc] initWithFrame:CGRectMake(184, 547, 400, 400)];
    [background setImage:[UIImage imageNamed:@"ocean-freashwater-aquifiers.jpg"]];
    [background12 setImage:[UIImage imageNamed:@"ocean-freashwater-aquifiers.jpg"]];
    [self.view addSubview:background];
    [self.view addSubview:background12];
    
    UILabel *pLabel = [[UILabel alloc] initWithFrame:CGRectMake(52, 497, 70, 70)];
    [pLabel setText:@"Player 1"];
    [pLabel setTextColor:[UIColor whiteColor]];
    [self.view addSubview:pLabel];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"explosion" ofType:@"wav"];
    NSURL *urlString = [NSURL fileURLWithPath:path];
    NSError *err;
    sinkSound4 = [[AVAudioPlayer alloc] initWithContentsOfURL:urlString error:&err];
    [sinkSound4 setVolume:3.5];
    
    NSString *path2 = [[NSBundle mainBundle] pathForResource:@"cheer" ofType:@"wav"];
    NSURL *urlString2 = [NSURL fileURLWithPath:path2];
    NSError *err2;
    winSound4 = [[AVAudioPlayer alloc] initWithContentsOfURL:urlString2 error:&err2];
    [winSound4 setVolume:5.0];
    
    int debug = 1;
    for (id obj in shipsLeft1){
        for (id objj in obj){
            NSLog(@"%d:  %@", debug,objj);
        }
        debug++;
    }
    justloaded = true;
    NSLog(@"HI");
    NSLog(@"%d", (int)[sinkStatus1 count]);
    [self.navigationController setNavigationBarHidden:YES];
    //firPlayer = [self.storyboard instantiateViewControllerWithIdentifier:@"3"];
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
            UIButton *buttonzs1 = [UIButton buttonWithType: UIButtonTypeRoundedRect];
            buttonzs1.frame = CGRectMake(xCord + (i * 40), yButton - (j * 40), 40, 40);
            buttonzs1.enabled = NO;
            buttonzs1.tag = ind + 100;
            if ([[gameBoard objectAtIndex:ind] isEqualToString:@"0"]){
                //[buttonz setBackgroundColor:[UIColor blueColor]];
            }
            else {
                [buttonzs1 setBackgroundColor:[UIColor purpleColor]];
            }
            //buttonz.tag = ind;
            //NSLog(@"index: %d  tag: %d", ind, (int)buttonz.tag);
            //[button setTitle:@"Hello" forState:UIControlStateNormal];
            [self.view addSubview:buttonzs1];
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
    // Do any additional setup after loading the view.
}

-(void) viewWillAppear:(BOOL)animated
{
    
        int tagIs = vsIndTrack + 100;
        UIButton *button = (UIButton *)[self.view viewWithTag:tagIs];
        if ([[gameBoard objectAtIndex:vsIndTrack] isEqualToString:@"0"]){
            [button setBackgroundColor:[UIColor blueColor]];
        }
        else if ([[gameBoard objectAtIndex:vsIndTrack] isEqualToString:@"1"]){
            [gameBoard replaceObjectAtIndex:vsIndTrack withObject:@"2"];
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

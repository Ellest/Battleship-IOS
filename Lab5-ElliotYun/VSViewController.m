//
//  VSViewController.m
//  Lab5-ElliotYun
//
//  Created by Labuser on 11/3/14.
//  Copyright (c) 2014 com. All rights reserved.
//

#import "VSViewController.h"
#import "AppDelegate.h"
#import "VSViewController2.h"

@interface VSViewController ()



@end

@implementation VSViewController

UIButton* button1;
int xCo;
CGFloat yCo;
NSArray *ships;
int bWidth;
int bHeight;
const int xBoundS = 184;
const int yBoundS = 312;
const int xBoundE = 584;
const int yBoundE = 712;
int xx = 77;
int yy = 312;

@synthesize Ship5, PlayerLabel, DoneButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    if (playerFlag == 1){
        
    }
    //int x = Ship5.frame.origin.x;
    //NSLog(@"%d", x);
    [self.navigationController setNavigationBarHidden:YES];
    [super viewDidLoad];
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"1024x1024.jpeg"]];
    [DoneButton setHidden:true];
    [PlayerLabel setText:@"Player 1"];
    [PlayerLabel setFont:[UIFont fontWithName:@"Superclarendon" size:20.0]];
    [PlayerLabel setTextColor:[UIColor whiteColor]];
    // initializing the grid
    int xCord = 184;
    int yCord = 312;
    int xEnd = xCord + 400;
    int yEnd = yCord + 400;
    int xLabel = xCord - 40;
    int yLabel = yCord - 40;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)MoveShip:(id)sender withEvent:(UIEvent *) event{
    CGPoint point = [[[event allTouches] anyObject] locationInView:self.view];
    UIControl *control = sender;
    control.center = point;
    button1 = sender;
    [button1 setTranslatesAutoresizingMaskIntoConstraints:YES];
    [self.view bringSubviewToFront:button1];
    yCo = button1.frame.origin.y;
    bWidth = button1.frame.size.width;
    bHeight = button1.frame.size.height;
    [sender addTarget:self action:@selector(touchesEnded:withEvent:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    int checking;
    int topLeftX = button1.frame.origin.x;
    int topRightX = button1.frame.origin.x + button1.frame.size.width;
    int topY = button1.frame.origin.y;
    int bottomY = button1.frame.origin.y + button1.frame.size.height;
    int startX = 77;
    //int startY = yCo;
    CGFloat xCoord = button1.frame.origin.x;
    CGFloat yCoord = button1.frame.origin.y;
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
    
    button1.frame = CGRectMake(xCoord, yCoord, button1.frame.size.width,button1.frame.size.height);
    
    NSLog(@"\n");
    checking = 0;
    if (button1.frame.origin.x != startX) {
        CGRect frame1 = [button1 frame];
        for (UIButton* ship in ships) {
            if (button1.tag != ship.tag) {
                CGRect frame2 = [ship frame];
                if(CGRectIntersectsRect(frame1, frame2)) {
                    /*[UIView animateWithDuration:0.4 delay:0.0 options: UIViewAnimationOptionCurveEaseInOut
                                     animations:^ {
                                         button.frame = CGRectMake(startX, yCo, button.frame.size.width,button.frame.size.height);
                                     }
                                     completion:^(BOOL finished) {}];*/
                    button1.frame = CGRectMake(startX, yCo, button1.frame.size.width,button1.frame.size.height);
                    checking = 1;
                    [DoneButton setHidden:true];
                    break;
                }
            }
        }
    }
    if (button1.frame.origin.x == startX){
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
            if (currX < xBoundS){
                continue;
            }
            int modFactor = 40;
            int compX = currX - xBoundS;
            int compY = yBoundE - currY;
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
            NSString *rs;
            //NSLog(@"horizontalX: %d  verticalY: %d", horizontalX, verticalY);
            if (verticalY == 1){
                for (int i = 0; i < horizontalX; i++){
                    int na = index + i;
                    //NSLog(@"%d", na);
                    rs = [NSString stringWithFormat:@"%d", na];
                    [gameBoard replaceObjectAtIndex:na withObject: @"1"];
                    [[shipsLeft1 objectAtIndex:shipT] replaceObjectAtIndex:i withObject:rs];
                }
            }
            else if (horizontalX == 1){
                for (int i = 0; i < verticalY; i++){
                    int na = index - i * 10 ;
                    //NSLog(@"%d", na);
                    [gameBoard replaceObjectAtIndex:na withObject: @"1"];
                    rs = [NSString stringWithFormat:@"%d", na];
                    [[shipsLeft1 objectAtIndex:shipT] replaceObjectAtIndex:i withObject:rs];
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
        /*int debug = 1;
        for (id obj in shipsLeft1){
            for (id objj in obj){
                NSLog(@"%d:  %@", debug,objj);
            }
            debug++;
        }*/
        /*for (int i = 0; i < 100; i++){
            NSLog(@"%d: %@", i, [gameBoard objectAtIndex:i]);
        }*/
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

- (IBAction)ShipRotate:(id)sender {
    [DoneButton setHidden:true];
    UIButton *butt = sender;
    [butt setTransform:CGAffineTransformRotate(butt.transform, M_PI/2)];
    //butt.frame = CGRectMake(xx, yy, butt.frame.size.width,butt.frame.size.height);
}
- (IBAction)DoneButtonAction:(id)sender {
    VSViewController2 *vs = [self.storyboard instantiateViewControllerWithIdentifier:@"7"];
    [self.navigationController pushViewController:vs animated:YES];
}



@end

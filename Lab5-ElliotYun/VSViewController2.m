//
//  VSViewController2.m
//  Lab5-ElliotYun
//
//  Created by Labuser on 11/4/14.
//  Copyright (c) 2014 com. All rights reserved.
//

#import "VSViewController2.h"
#import "AppDelegate.h"
#import "PlayViewController.h"
#import "PlayViewController2.h"

@interface VSViewController2 ()

@end

@implementation VSViewController2

UIButton *button;
NSArray *ships2;
CGFloat yCo;
int bWidth;
int bHeight;
const int xBoundS2 = 184;
const int yBoundS2 = 312;
const int xBoundE2 = 584;
const int yBoundE2 = 712;
UIButton *dButton;
UIButton *dButton2;

@synthesize PlayerLabel2, DoneButton, navController, DoneButton2;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)play1Segue
{
    
}

- (void)viewDidLoad
{
    if (playerFlag == 1){
        
    }
    //int x = Ship5.frame.origin.x;
    //NSLog(@"%d", x);
    //[super viewDidLoad];
    /*DoneButtons = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [DoneButtons addTarget:self
               action:@selector(Done:)
     forControlEvents:UIControlEventTouchUpInside];
    [DoneButtons setTitle:@"Done" forState:UIControlStateNormal];
    DoneButtons.frame = CGRectMake(653, 487, 46, 30);
    [self.view addSubview:DoneButtons];*/
    whoseTurn = arc4random() % 2 + 1;
    [self.navigationController setNavigationBarHidden:YES];
            self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"1024x1024.jpeg"]];
    [DoneButton setHidden:true];
    [DoneButton2 setHidden:true];
    //DoneButton2.enabled = false;
    [PlayerLabel2 setText:@"Player 2"];
    [PlayerLabel2 setFont:[UIFont fontWithName:@"Superclarendon" size:20.0]];
    [PlayerLabel2 setTextColor:[UIColor whiteColor]];
    // initializing the grid
    int xCord2 = 184;
    int yCord2 = 312;
    int xEnd2 = xCord2 + 400;
    int yEnd2 = yCord2 + 400;
    int xLabel2 = xCord2 - 40;
    int yLabel2 = yCord2 - 40;
    NSArray *na = [[NSArray alloc] initWithObjects:@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", nil];
    int labe = 0;;
    while (xCord2 < xEnd2){
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(xCord2, yLabel2, 40, 40)];
        NSString *element = [na objectAtIndex:labe];
        label.text = element;
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setTextColor:[UIColor whiteColor]];
        [self.view addSubview:label];
        labe++;
        xCord2 += 40;
    }
    labe = 10;
    while (yCord2 < yEnd2){
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(xLabel2, yCord2, 40, 40)];
        NSString *strFromInt = [NSString stringWithFormat:@"%d",labe];
        label.text = strFromInt;
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setTextColor:[UIColor whiteColor]];
        [self.view addSubview:label];
        labe--;
        yCord2 += 40;
    }
    // resetting draw cords
    xCord2 = 184;
    yCord2 = 312;
    while(xCord2 <= xEnd2){
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(xCord2, yCord2, 2, 400)];
        view.backgroundColor = [UIColor blueColor];
        [self.view addSubview:view];
        xCord2 += 40.4;
    }
    // resetting draw cords
    xCord2 = 184;
    yCord2 = 312;
    while(yCord2 <= yEnd2){
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(xCord2, yCord2, 400, 2)];
        view.backgroundColor = [UIColor blueColor];
        [self.view addSubview:view];
        yCord2 += 40.4;
    }
    
    xCord2 = 184;
    yCord2 = 547;
    yEnd2 = yCord2 + 400;
    int x = 10;
    int y = 10;
    int yButton2 = yEnd2 - 40;
    int ind;
    for (int j = 0; j < y; j++) {
        for (int i = 0; i < x; i++) {
            ind = x * j + i;
            //UIView *viewIs = [[UIView alloc] initWithFrame:CGRectMake(xValue, yValue, 40, 40)];
            //[self.view addSubview:viewIs];
            UIButton *buttonz = [UIButton buttonWithType: UIButtonTypeRoundedRect];
            buttonz.frame = CGRectMake(xCord2 + (i * 40) + 1, yButton2 - (j * 40) + 1, 40, 40);
            buttonz.tag = ind;
            //[button setTitle:@"Hello" forState:UIControlStateNormal];
            [playBoard2 addObject:buttonz];
            //[self.view addSubview:buttonz];
        }
    }
    ships2 = [[NSArray alloc] initWithObjects:self.Ship5, self.Ship4, self.Ship3, self.Ship2, self.Ship1, nil];
    
    
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

- (IBAction)MoveShip2:(id)sender withEvent:(UIEvent *) event{
    
    CGPoint point = [[[event allTouches] anyObject] locationInView:self.view];
    UIControl *control = sender;
    control.center = point;
    button = sender;
    [button setTranslatesAutoresizingMaskIntoConstraints:YES];
    [self.view bringSubviewToFront:button];
    yCo = button.frame.origin.y;
    bWidth = button.frame.size.width;
    bHeight = button.frame.size.height;
    [sender addTarget:self action:@selector(touchesEnded2:withEvent:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)touchesEnded2:(NSSet *)touches withEvent:(UIEvent *)event {
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
    int checking = 0;
    if (xCoord != startX) {
        CGRect frame1 = [button frame];
        for (UIButton* ship in ships2) {
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
                    [DoneButton2 setHidden:true];
                    break;
                }
            }
        }
    }
    if (xCoord == startX){
        checking = 1;
    }
    if (checking != 1){
        for (int i = 0; i < 100; i ++){
            [gameBoard2 replaceObjectAtIndex:i withObject: @"0"];
        }
        [DoneButton setHidden:true];
        [DoneButton2 setHidden:true];
        for (UIButton* ship in ships2) {
            int shipT = (int)ship.tag;
            shipT--;
            int currX = ship.frame.origin.x;
            int currY = ship.frame.origin.y;
            if (currX < xBoundS2){
                continue;
            }
            int modFactor = 40;
            int compX = currX - xBoundS2;
            int compY = yBoundE2 - currY;
            int modX = compX % modFactor;
            int modY = compY % modFactor;
            compX -= modX;
            compY -= modY;
            int resultX = compX / modFactor;
            int resultY = compY / modFactor;
            NSLog(@"resultX: %d  resultY: %d", resultX, resultY);
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
            NSLog(@"horizontalX: %d  verticalY: %d", horizontalX, verticalY);
            NSString *rs;
            if (verticalY == 1){
                for (int i = 0; i < horizontalX; i++){
                    int na = index + i;
                    NSLog(@"%d", na);
                    rs = [NSString stringWithFormat:@"%d", na];
                    [gameBoard2 replaceObjectAtIndex:na withObject: @"1"];
                    [[shipsLeft2 objectAtIndex:shipT] replaceObjectAtIndex:i withObject:rs];
                }
            }
            else if (horizontalX == 1){
                for (int i = 0; i < verticalY; i++){
                    int na = index - i * 10 ;
                    NSLog(@"%d", na);
                    [gameBoard2 replaceObjectAtIndex:na withObject: @"1"];
                    rs = [NSString stringWithFormat:@"%d", na];
                    [[shipsLeft2 objectAtIndex:shipT] replaceObjectAtIndex:i withObject:rs];
                }
            }
            int counter = 0;
            for (NSObject *object in gameBoard2) {
                if ([object isEqual:@"1"])
                    counter++;
            }
            NSLog(@"%d", counter);
            if (counter == 17){
                if (whoseTurn == 1){
                    [DoneButton setHidden:false];
                }
                else {
                    [DoneButton2 setHidden:false];
                }
            }
        }
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

- (IBAction)ShipRotate2:(id)sender {
    [DoneButton setHidden:true];
    UIButton *butt = sender;
    [butt setTransform:CGAffineTransformRotate(butt.transform, M_PI/2)];
    //butt.frame = CGRectMake(77, 312, butt.frame.size.width,butt.frame.size.height);
}

/*- (void)Done:(UIButton*)button
{
    NSLog(@"Button  clicked.");
    PlayViewController *pv = [[PlayViewController alloc ]init];
    PlayViewController2 *pv2 = [[PlayViewController2 alloc] init];
    NSArray *ns = [[NSArray alloc] initWithObjects:pv, pv2, nil];
    UITabBarController *tabC = [[UITabBarController alloc] init];
    [tabC setViewControllers:ns];
    [tabC setSelectedIndex:0];
    [self.navController pushViewController:tabC animated:YES];
}
- (IBAction)Done2:(id)sender {
    NSLog(@"Hi");

   
}*/
- (IBAction)db:(id)sender {
}




@end

//
//  CanvasViewController.m
//  canvas
//
//  Created by Dhanya R on 9/17/15.
//  Copyright © 2015 Dhanya R. All rights reserved.
//

#import "CanvasViewController.h"

@interface CanvasViewController ()
@property (weak, nonatomic) IBOutlet UIView *trayView;
@property CGPoint trayOriginalCenter;
@property CGPoint trayUp;
@property CGPoint trayDown;
@property CGPoint imageOriginalCenter;
@property (strong, nonatomic) UIImageView *newlyCreatedFace;
@end

@implementation CanvasViewController
- (IBAction)onSmileyPanGesture:(UIPanGestureRecognizer *)sender {
    
    CGPoint translation = [sender translationInView:sender.view];
    self.imageOriginalCenter =  [sender locationInView:self.view];
    UIImageView *imageView = (UIImageView *)sender.view;
    switch (sender.state) {
        case (UIGestureRecognizerStateBegan): {
            NSLog(@"began");
            self.newlyCreatedFace = [[UIImageView alloc] initWithImage:imageView.image];
            };
            break;
        case (UIGestureRecognizerStateChanged):{
            NSLog(@"changed");
            [self.view addSubview:self.newlyCreatedFace];
            self.newlyCreatedFace.center = CGPointMake(imageView.center.x + self.trayView.frame.origin.x + translation.x, imageView.center.y + self.trayView.frame.origin.y + translation.y);
            };
            break;
        case (UIGestureRecognizerStateEnded):{
            NSLog(@"ended");
            self.newlyCreatedFace.center = CGPointMake(imageView.center.x + self.trayView.frame.origin.x + translation.x, imageView.center.y + self.trayView.frame.origin.y + translation.y);
            };
            break;
        default:
            break;
    };

}

- (IBAction)onTrayPanGesture:(UIPanGestureRecognizer *)sender {
    // CGPoint translation = [sender translationInView:sender.view];
    
    // self.trayOriginalCenter =  [sender locationInView:self.view];
    //self.trayDown =  [sender locationInView:self.view];
    
    // self.trayUp = [sender locationInView:self.view];
    

    // NSLog(@" trayOriginalCenter x %f", self.trayOriginalCenter.x);
    CGPoint velocity = [sender velocityInView:sender.view];
   
    switch (sender.state) {
        case (UIGestureRecognizerStateBegan): {
                self.trayOriginalCenter = self.trayView.center;
                NSLog(@"began");
            };
            break;
        case (UIGestureRecognizerStateChanged): {
                NSLog(@"changed");
            };
            
            //self.trayView.center = CGPointMake(self.trayOriginalCenter.x, self.trayOriginalCenter.y + translation.y);
            self.trayView.center = self.trayUp;
            break;
        case (UIGestureRecognizerStateEnded):{
                NSLog(@"ended");
            
            [UIView animateWithDuration:0.5
                                  delay:0.5
                 usingSpringWithDamping:0.5
                  initialSpringVelocity:0.5
                                options:0 animations:^{
                                    //Animations
                                    if (velocity.y > 0) {
                                        self.trayView.center = self.trayDown;
                                        NSLog(@"Did pan - moving down ");
                                    } else {
                                        NSLog(@"Did pan - moving up ");
                                        self.trayView.center = self.trayUp;
                                    }
                                }
                             completion:^(BOOL finished) {
                                 //Completion Block
                             }];

            }
            break;
        default:
            break;
    };
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onTrayPanGesture:)];
    [self.view addGestureRecognizer:panRecognizer];
    self.trayOriginalCenter = self.trayView.center;
    self.trayDown = CGPointMake(self.trayView.center.x, self.trayView.center.y + 170);
    self.trayUp = CGPointMake(self.trayView.center.x, self.trayView.center.y);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

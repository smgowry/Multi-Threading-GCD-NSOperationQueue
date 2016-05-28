//
//  ViewController.h
//  MultiThreading
//
//  Created by Gowri Sammandhamoorthy on 1/27/16.
//  Copyright © 2016 Gowri Sammandhamoorthy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MultiThreadingViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *imgVw;

- (IBAction)queueWithBlockOperation:(id)sender;
- (IBAction)queueWithInvocationOperation:(id)sender;
- (IBAction)gcdQueue:(id)sender;
- (IBAction)exitButtonPressed:(id)sender;

@end


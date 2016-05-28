//
//  ViewController.m
//  MultiThreading
//
//  Created by Gowri Sammandhamoorthy on 1/27/16.
//  Copyright © 2016 Gowri Sammandhamoorthy. All rights reserved.
//

#import "MultiThreadingViewController.h"

@interface MultiThreadingViewController ()

@end

@implementation MultiThreadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - NSOperationQueue with Block Operation.

-(void)creatingOperationQueueWithNSBlockOperation{
    NSOperationQueue* queue = [NSOperationQueue new];
    
    NSBlockOperation* operation1 = [NSBlockOperation blockOperationWithBlock:^{
        NSURL* url = [NSURL URLWithString:@"https://splashbase.s3.amazonaws.com/unsplash/regular/tumblr_mnh0n9pHJW1st5lhmo1_1280.jpg"];
        
        NSData* data = [NSData dataWithContentsOfURL:url];
        UIImage* image = [UIImage imageWithData:data];
        
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
            _imageView.image = image;
        }];
    }];
    
    NSBlockOperation* operation2 = [NSBlockOperation blockOperationWithBlock:^{
        NSURL* url = [NSURL URLWithString:@"https://splashbase.s3.amazonaws.com/unsplash/regular/tumblr_mnh121HEWa1st5lhmo1_1280.jpg"];
        
        NSData* data = [NSData dataWithContentsOfURL:url];
        UIImage* image = [UIImage imageWithData:data];
        
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
            _imgVw.image = image;
        }];
    }];

  //Adding Dependency
    [operation1 addDependency:operation2];
 
    [queue addOperation:operation1];
    [queue addOperation:operation2];
}

#pragma mark - NSOperationQueue with NSInvocationOperation - for existing methods.

-(void)creatingOperationQueueWithNSInvocationOperation{
    NSOperationQueue* queue = [NSOperationQueue new];
    NSInvocationOperation* operation1 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(loadImageWithUrl1:) object:nil];
    
    NSInvocationOperation* operation2 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(loadImageWithUrl2:) object:nil];
    
    //Adding Dependancy.
    [operation1 addDependency:operation2];
    [queue addOperation:operation1];
    [queue addOperation:operation2];
}

-(void)loadImageWithUrl1:(NSString*)urlString{
    NSURL* url = [NSURL URLWithString:@"https://splashbase.s3.amazonaws.com/unsplash/regular/tumblr_msue8xI39X1st5lhmo1_1280.jpg"];
    NSData* data = [NSData dataWithContentsOfURL:url];
    [[NSOperationQueue mainQueue]addOperationWithBlock:^{
        _imgVw.image = [UIImage imageWithData:data];
    }];
    }

-(void)loadImageWithUrl2:(NSString*)urlString{
    NSURL* url = [NSURL URLWithString:@"https://splashbase.s3.amazonaws.com/unsplash/regular/tumblr_msue6ubSHn1st5lhmo1_1280.jpg"];
    NSData* data = [NSData dataWithContentsOfURL:url];
    [[NSOperationQueue mainQueue]addOperationWithBlock:^{
        _imageView.image = [UIImage imageWithData:data];
    }];
}


#pragma mark - NSOperationQueue with Block Operation.

-(void)creatingGCDQueue{
    dispatch_queue_t queue = dispatch_queue_create("imageLoadingQueue", nil);
    
    dispatch_async(queue, ^{
        NSURL* url1 = [NSURL URLWithString:@"https://splashbase.s3.amazonaws.com/getrefe/regular/tumblr_n6ni6khmfG1slhhf0o2_1280.jpg"];
        
        NSURL* url2 = [NSURL URLWithString:@"https://splashbase.s3.amazonaws.com/unsplash/regular/tumblr_mwhd4eXiB51st5lhmo1_1280.jpg"];
        
        NSData* data1 = [NSData dataWithContentsOfURL:url1];
        NSData* data2 = [NSData dataWithContentsOfURL:url2];
      
        dispatch_async(dispatch_get_main_queue(),^{
            _imgVw.image = [UIImage imageWithData:data1];
            _imageView.image = [UIImage imageWithData:data2];
        });
        
    });
}

#pragma mark - Action Buttons.

- (IBAction)queueWithBlockOperation:(id)sender {
       [self creatingOperationQueueWithNSBlockOperation];
}

- (IBAction)queueWithInvocationOperation:(id)sender {
    [self creatingOperationQueueWithNSInvocationOperation];
}

- (IBAction)gcdQueue:(id)sender {
     [self creatingGCDQueue];
}

- (IBAction)exitButtonPressed:(id)sender {
    exit(0);
}
@end

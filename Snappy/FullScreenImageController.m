//
//  FullScreenImageController.m
//  Snappy
//
//  Created by Pär Majholm on 12/09/16.
//  Copyright © 2016 Pär Majholm. All rights reserved.
//

#import "FullScreenImageController.h"

@interface FullScreenImageController ()

@property (retain, nonatomic) UIImage * image;
@property (assign, nonatomic) IBOutlet UIImageView * imageView;

@end

@implementation FullScreenImageController

- (instancetype)initWithImage:(UIImage *)image
{
    self = [super initWithNibName:nil bundle:nil];
    if (self == nil) return nil;
    self.image = image;
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.imageView.image = self.image;
    UITapGestureRecognizer * tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissSelf)];
    [self.imageView addGestureRecognizer:tapRecognizer];
}

- (void)dismissSelf
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end

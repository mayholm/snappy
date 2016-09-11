//
//  PostController.m
//  Snappy
//
//  Created by Pär Majholm on 11/09/16.
//  Copyright © 2016 Pär Majholm. All rights reserved.
//

#import "PostController.h"
#import "UIColor+SnappyColors.h"
#import "CachedFetchOperation.h"
#import "FullScreenImageController.h"

@interface PostController ()

@property (retain, nonatomic) IBOutlet UILabel *name;
@property (retain, nonatomic) IBOutlet UILabel *description_;
@property (retain, nonatomic) IBOutlet UILabel *tags;
@property (retain, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation PostController

- (void)dealloc
{
    [_imageView release];
    [_name release];
    [_description_ release];
    [_tags release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = self.post.name;
    
    self.name.text = self.post.name;
    self.description_.text = self.post.description_;
    
    NSMutableString * tagsString = [NSMutableString string];
    for (NSString * tag in self.post.tags)
    {
        NSString * formattedTag = [NSString stringWithFormat:@"#%@ ", tag.lowercaseString];
        [tagsString appendString:formattedTag];
    }
    self.tags.text = tagsString;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *urlString = self.post.url;
        CachedFetchOperation * fetchOperation = [[[CachedFetchOperation alloc] initWithURLString:urlString] autorelease];
        [fetchOperation main];
        UIImage * image = [UIImage imageWithData:fetchOperation.data];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image = image;
            CGFloat aspect = image.size.width / image.size.height;
            [self.imageView addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.imageView attribute:NSLayoutAttributeHeight multiplier:aspect constant:0]];
        });
    });
    
    UITapGestureRecognizer * tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showImageFullscreen)];
    [self.imageView addGestureRecognizer:tapRecognizer];
    self.imageView.userInteractionEnabled = YES;

}

- (void)showImageFullscreen
{
    FullScreenImageController * vc = [[[FullScreenImageController alloc] initWithImage:self.imageView.image] autorelease];
    [self presentViewController:vc animated:YES completion:nil];
}

@end

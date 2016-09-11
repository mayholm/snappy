//
//  PostTableViewCell.h
//  Snappy
//
//  Created by Pär Majholm on 11/09/16.
//  Copyright © 2016 Pär Majholm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"

@interface PostTableViewCell : UITableViewCell

@property (assign, nonatomic) IBOutlet UIImageView *photoImageView;
@property (assign, nonatomic) IBOutlet UILabel *name;
@property (retain, nonatomic) IBOutlet UILabel *tags;
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

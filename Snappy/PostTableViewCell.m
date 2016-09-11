//
//  PostTableViewCell.m
//  Snappy
//
//  Created by Pär Majholm on 11/09/16.
//  Copyright © 2016 Pär Majholm. All rights reserved.
//

#import "PostTableViewCell.h"

@implementation PostTableViewCell

- (void)dealloc
{
    [_photoImageView release];
    [_name release];
    [_activityIndicator release];
    [_tags release];
    [super dealloc];
}

@end

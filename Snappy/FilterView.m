//
//  FilterView.m
//  Snappy
//
//  Created by Pär Majholm on 11/09/16.
//  Copyright © 2016 Pär Majholm. All rights reserved.
//

#import "FilterView.h"

@implementation FilterView

- (void)dealloc
{
    [_textField release];
    [super dealloc];
}

+ (FilterView *)instanceFromNib
{
    FilterView * filterView = [[NSBundle mainBundle] loadNibNamed:@"FilterView" owner:self options:nil][0];
    return filterView;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.textField.layer.cornerRadius = self.textField.bounds.size.height / 2;
    self.textField.layer.borderWidth = 1;
    self.textField.layer.borderColor = [UIColor whiteColor].CGColor;
}

@end

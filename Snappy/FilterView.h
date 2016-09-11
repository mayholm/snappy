//
//  FilterView.h
//  Snappy
//
//  Created by Pär Majholm on 11/09/16.
//  Copyright © 2016 Pär Majholm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FilterView : UIView

@property (retain, nonatomic) IBOutlet UITextField *textField;

+ (FilterView *)instanceFromNib;

@end

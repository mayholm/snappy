//
//  UIColor+colorWithInt.m
//  Snappy
//
//  Created by Pär Majholm on 11/09/16.
//  Copyright © 2016 Pär Majholm. All rights reserved.
//

#import "UIColor+colorWithInt.h"

@implementation UIColor (colorWithInt)

+ (UIColor *)colorWithInt:(uint32_t)rgbaInteger
{
    CGFloat red =   (CGFloat)(rgbaInteger >> 24) / 0xff;
    CGFloat green = (CGFloat)((rgbaInteger >> 16) & 0x000000ff) / 0xff;
    CGFloat blue =  (CGFloat)((rgbaInteger >> 8) & 0x000000ff) / 0xff;;
    CGFloat alpha = (CGFloat)(rgbaInteger & 0x000000ff) / 0xff;;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

@end

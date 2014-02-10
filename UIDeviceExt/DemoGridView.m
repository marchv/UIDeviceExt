//
//  DemoGridView.m
//  UIDeviceExt
//
//  Created by Jens Schwarzer on 28/01/14.
//  Copyright (c) 2014 marchv. All rights reserved.
//

#import "DemoGridView.h"
#import "UIDeviceExt.h"

@implementation DemoGridView

- (void)drawRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor); // background color
    CGContextFillRect(context, self.bounds);
    
    float pointsPerMillimeter = [UIDeviceExt pointsPerCentimeter] * 0.1f;
    float gridDistanceInPoints = pointsPerMillimeter; // 1 mm space between grid lines
    
    int nbrOfHorizontalGridLines = self.bounds.size.height / pointsPerMillimeter;
    int nbrOfVerticalGridLines   = self.bounds.size.width  / pointsPerMillimeter;
    
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor); // grid color
    
    // draw thin 1 mm lines
    CGContextBeginPath(context);
    CGContextSetLineWidth(context, 0.5f);
    // horizontal lines
    for (int i = 0; i <= nbrOfHorizontalGridLines; i++) {
        CGContextMoveToPoint(   context,                   0.0f, gridDistanceInPoints * i);
        CGContextAddLineToPoint(context, self.bounds.size.width, gridDistanceInPoints * i);
    }
    // vertical lines
    for (int i = 0; i <= nbrOfVerticalGridLines; i++) {
        CGContextMoveToPoint(   context, gridDistanceInPoints * i,                    0.0f);
        CGContextAddLineToPoint(context, gridDistanceInPoints * i, self.bounds.size.height);
    }
    CGContextStrokePath(context);
    
    // draw thick 5 mm lines
    CGContextBeginPath(context);
    CGContextSetLineWidth(context, 1.0f);
    // horizontal lines
    for (int i = 0; i <= nbrOfHorizontalGridLines; i += 5) {
        CGContextMoveToPoint(   context,                   0.0f, gridDistanceInPoints * i);
        CGContextAddLineToPoint(context, self.bounds.size.width, gridDistanceInPoints * i);
    }
    // vertical lines
    for (int i = 0; i <= nbrOfVerticalGridLines; i += 5) {
        CGContextMoveToPoint(   context, gridDistanceInPoints * i,                    0.0f);
        CGContextAddLineToPoint(context, gridDistanceInPoints * i, self.bounds.size.height);
    }
    CGContextStrokePath(context);
    
    
    // draw texts
    float fontSize = pointsPerMillimeter * 4.0f;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = NSLineBreakByClipping;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    UIFont *font = [UIFont fontWithName:@"Helvetica Neue" size:fontSize];
    NSDictionary *dictionary = @{NSFontAttributeName: font,
                                 NSForegroundColorAttributeName: [UIColor blackColor],
                                 NSParagraphStyleAttributeName: paragraphStyle};
    
    NSString *strMarchv = @"UIDeviceExt\n\u00A9 2014 marchv";
    NSString *strPointsCentimeter = [NSString stringWithFormat:@"%.0f points per centimeter", [UIDeviceExt pointsPerCentimeter]];
    NSString *strPixelsCentimeter = [NSString stringWithFormat:@"%.0f pixels per centimeter", [UIDeviceExt pixelsPerCentimeter]];
    NSString *strPointsInch       = [NSString stringWithFormat:@"%.0f points per inch", [UIDeviceExt pointsPerInch]];
    NSString *strPixelsInch       = [NSString stringWithFormat:@"%.0f pixels per inch", [UIDeviceExt pixelsPerInch]];
    
    [strMarchv drawInRect:CGRectMake(0.0f,  5.0f * pointsPerMillimeter, self.bounds.size.width, self.bounds.size.height) withAttributes:dictionary];
    [strPixelsCentimeter drawInRect:CGRectMake(0.0f, 15.0f * pointsPerMillimeter, self.bounds.size.width, self.bounds.size.height) withAttributes:dictionary];
    [strPointsCentimeter drawInRect:CGRectMake(0.0f, 20.0f * pointsPerMillimeter, self.bounds.size.width, self.bounds.size.height) withAttributes:dictionary];
    [strPixelsInch drawInRect:CGRectMake(0.0f, 25.0f * pointsPerMillimeter, self.bounds.size.width, self.bounds.size.height) withAttributes:dictionary];
    [strPointsInch drawInRect:CGRectMake(0.0f, 30.0f * pointsPerMillimeter, self.bounds.size.width, self.bounds.size.height) withAttributes:dictionary];
}

@end

//
//  UIDeviceExt.h
//  UIDeviceExt
//
//  Created by Jens Schwarzer on 28/01/14.
//  Copyright (c) 2014 marchv. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIDeviceExt : NSObject

+ (float)pointsPerCentimeter;
+ (float)pixelsPerCentimeter;

+ (float)pointsPerInch;
+ (float)pixelsPerInch;

@end

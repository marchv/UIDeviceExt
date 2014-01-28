//
//  UIDeviceExt.m
//  UIDeviceExt
//
//  Created by Jens Schwarzer on 28/01/14.
//  Copyright (c) 2014 marchv. All rights reserved.
//

//
//  References:
//    * pixels-per-centimeter is based on http://en.wikipedia.org/wiki/List_of_displays_by_pixel_density#Apple
//    * device identifiers is based on http://theiphonewiki.com/wiki/Models
//

//
//  WARNING: This code must be updated whenever new iDevices are released
//

#import "UIDeviceExt.h"
#include <sys/utsname.h>

static float _pixelsPerCentimeter;
static float _pointsPerCentimeter;

@implementation UIDeviceExt

+(void)initialize {
#if TARGET_CPU_ARM == 0
    // simulator
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        _pointsPerCentimeter = 64.0f; // assume simulation of iPhone
    }
    else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        _pointsPerCentimeter = 52.0f; // assume simulation of iPad
    }
    
    _pixelsPerCentimeter = _pointsPerCentimeter * [[UIScreen mainScreen] scale]; // adjust for Retina
#else
    struct utsname sysinfo;
    
    if (uname(&sysinfo) == 0) {
        NSString *identifier = [NSString stringWithUTF8String:sysinfo.machine];
        
        // group devices with same number of pixels-per-centimeter
        NSArray *iDevices = @[@{@"identifiers": @[@"iPad1,1",                                      // iPad
                                                  @"iPad2,1", @"iPad2,2", @"iPad2,3", @"iPad2,4"], // iPad 2
                                @"pixelsPerCentimeter": @52},
                              
                              @{@"identifiers": @[@"iPad3,1", @"iPad3,2", @"iPad3,3",              // iPad 3
                                                  @"iPad3,4", @"iPad3,5", @"iPad3,6",              // iPad 4
                                                  @"iPad4,1", @"iPad4,2"],                         // iPad Air
                                @"pixelsPerCentimeter": @104},
                              
                              @{@"identifiers": @[@"iPhone1,1",                                    // iPhone 2G
                                                  @"iPhone1,2",                                    // iPhone 3G
                                                  @"iPhone2,1",                                    // iPhone 3GS
                                                  @"iPad2,5", @"iPad2,5", @"iPad2,7"],             // iPad Mini
                                @"pixelsPerCentimeter": @64},
                              
                              @{@"identifiers": @[@"iPod5,1",                                      // iPod Touch 5th generation
                                                  @"iPhone3,1", @"iPhone3,2", @"iPhone3,3",        // iPhone 4
                                                  @"iPhone4,1",                                    // iPhone 4S
                                                  @"iPhone5,1", @"iPhone5,2",                      // iPhone 5
                                                  @"iPhone5,3", @"iPhone5,4",                      // iPhone 5C
                                                  @"iPhone6,1", @"iPhone6,2",                      // iPhone 5S
                                                  @"iPad4,4", @"iPad4,5"],                         // iPad Mini Retina
                                @"pixelsPerCentimeter": @128}];
        
        for (id deviceClass in iDevices)
            for (NSString *deviceId in [deviceClass objectForKey:@"identifiers"])
                if ([identifier isEqualToString:deviceId]) {
                    _pixelsPerCentimeter = [[deviceClass objectForKey:@"pixelsPerCentimeter"] integerValue];
                    break;
                }
    }
    
    // map from PIXELS per centimeter into POINTS per centimeter
    _pointsPerCentimeter = _pixelsPerCentimeter / [[UIScreen mainScreen] scale];
#endif
    
    NSAssert(_pixelsPerCentimeter > 0.0f, @"Unknown device");
}

+ (float)pixelsPerCentimeter { return _pixelsPerCentimeter; }

+ (float)pointsPerCentimeter { return _pointsPerCentimeter; }

@end

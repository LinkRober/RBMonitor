//
//  XYMotionOrientation.h
//
//  Created by Sangwon Park on 5/3/12.
//  Copyright (c) 2012 tastyone@gmail.com. All rights reserved.
//

#import <CoreMotion/CoreMotion.h>
#import <CoreGraphics/CoreGraphics.h>

extern NSString* const XYMotionOrientationChangedNotification;
extern NSString* const XYMotionOrientationInterfaceOrientationChangedNotification;

extern NSString* const kXYMotionOrientationKey;

@interface XYMotionOrientation : NSObject

@property (readonly) UIInterfaceOrientation interfaceOrientation;
@property (readonly) UIDeviceOrientation deviceOrientation;
@property (readonly) CGAffineTransform affineTransform;

@property (assign) BOOL showDebugLog;

+ (void)initialize;
+ (XYMotionOrientation *)sharedInstance;
- (void)startAccelerometerUpdates;
- (void)stopAccelerometerUpdates;
@end

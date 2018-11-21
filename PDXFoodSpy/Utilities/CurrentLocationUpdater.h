#import <Foundation/Foundation.h>
#import <CoreLocation/CLLocation.h>
#import <CoreLocation/CLLocationManager.h>
#import <CoreLocation/CLLocationManagerDelegate.h>
#import "CurrentLocationUpdaterDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@protocol CurrentLocationUpdaterDelegate;

@interface CurrentLocationUpdater : NSObject <CLLocationManagerDelegate>

@property (weak) id <CurrentLocationUpdaterDelegate> delegate;

- (void)start;

- (void)stop;

@end

NS_ASSUME_NONNULL_END

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "CurrentLocationUpdaterDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@protocol CurrentLocationUpdaterDelegate;

@interface CurrentLocationUpdater : NSObject <CLLocationManagerDelegate>

@property (weak) id <CurrentLocationUpdaterDelegate> delegate;

- (void)start;

- (void)stop;

@end

NS_ASSUME_NONNULL_END

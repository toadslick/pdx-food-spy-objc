#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


NS_ASSUME_NONNULL_BEGIN

@interface CurrentLocationUpdater : NSObject <CLLocationManagerDelegate>

- (void)start;

- (void)stop;

@end

NS_ASSUME_NONNULL_END

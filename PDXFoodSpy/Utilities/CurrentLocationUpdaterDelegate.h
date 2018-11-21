#import <Foundation/Foundation.h>
#import "CurrentLocationUpdater.h"

NS_ASSUME_NONNULL_BEGIN

@class CurrentLocationUpdater;

@protocol CurrentLocationUpdaterDelegate <NSObject>

- (void)currentLocationUpdater:(CurrentLocationUpdater *)updater didUpdateCoordinate:(CLLocationCoordinate2D)coordinate;

- (void)currentLocationUpdater:(CurrentLocationUpdater *)updater didFailWithError:(NSError *)error;

@end

NS_ASSUME_NONNULL_END

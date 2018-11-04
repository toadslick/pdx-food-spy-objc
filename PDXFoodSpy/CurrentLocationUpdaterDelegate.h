#import <Foundation/Foundation.h>
#import "CurrentLocationUpdater.h"

NS_ASSUME_NONNULL_BEGIN

@class CurrentLocationUpdater;

@protocol CurrentLocationUpdaterDelegate <NSObject>

- (void)currentLocationUpdater:(CurrentLocationUpdater *)updater didUpdateLocation:(CLLocation *)location;

@end

NS_ASSUME_NONNULL_END

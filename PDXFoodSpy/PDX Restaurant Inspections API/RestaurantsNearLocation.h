#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "DataFetcher.h"

NS_ASSUME_NONNULL_BEGIN

@interface RestaurantsNearLocation : NSObject <DataFetcherDelegate>

- (void) fetch:(CLLocationCoordinate2D)coordinate;

@end

NS_ASSUME_NONNULL_END

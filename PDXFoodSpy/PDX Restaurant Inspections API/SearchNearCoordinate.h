#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "JSONFetcher.h"

NS_ASSUME_NONNULL_BEGIN

@interface SearchNearCoordinate : NSObject <JSONFetcherDelegate>

- (void) fetch:(CLLocationCoordinate2D)coordinate;

@end

NS_ASSUME_NONNULL_END

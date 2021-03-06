#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "JSONFetcher.h"
#import "RequestDelegate.h"
#import "SearchResult.h"

NS_ASSUME_NONNULL_BEGIN

@interface SearchCoordinateRequest : NSObject <JSONFetcherDelegate>

@property (weak) id <RequestDelegate> delegate;

- (void) fetch:(CLLocationCoordinate2D)coordinate;

@end

NS_ASSUME_NONNULL_END

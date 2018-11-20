#import <Foundation/Foundation.h>
#import "RequestDelegate.h"
#import "JSONFetcher.h"

NS_ASSUME_NONNULL_BEGIN

@interface RestaurantHistoryRequest : NSObject <JSONFetcherDelegate>

@property (weak) id <RequestDelegate> delegate;

- (void) fetch:(NSString *)restaurantID;

@end

NS_ASSUME_NONNULL_END

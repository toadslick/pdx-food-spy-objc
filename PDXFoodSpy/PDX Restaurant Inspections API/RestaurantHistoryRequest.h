#import <Foundation/Foundation.h>
#import "RestaurantHistoryRequestDelegate.h"
#import "JSONFetcher.h"
#import "SearchResult.h"

NS_ASSUME_NONNULL_BEGIN

@interface RestaurantHistoryRequest : NSObject <JSONFetcherDelegate>

@property (weak) id <RestaurantHistoryRequestDelegate> delegate;

- (void)fetch:(NSString *)inspectionID;

@end

NS_ASSUME_NONNULL_END

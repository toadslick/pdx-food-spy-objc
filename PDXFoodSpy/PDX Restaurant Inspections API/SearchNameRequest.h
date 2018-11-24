#import <Foundation/Foundation.h>
#import "RequestDelegate.h"
#import "JSONFetcher.h"
#import "SearchResult.h"

NS_ASSUME_NONNULL_BEGIN

@interface SearchNameRequest : NSObject <JSONFetcherDelegate>

@property (weak) id <RequestDelegate> delegate;

- (void)fetch:(NSString *)restaurantName;

@end

NS_ASSUME_NONNULL_END

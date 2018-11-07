#import <Foundation/Foundation.h>
#import "JSONFetcher.h"

NS_ASSUME_NONNULL_BEGIN

@class JSONFetcher;

@protocol JSONFetcherDelegate <NSObject>

- (void)jsonFetcher:(JSONFetcher *)fetcher didReceiveJSON:(NSDictionary *)json;

- (void)jsonFetcher:(JSONFetcher *)fetcher didFailWithError:(NSError *)error;

@end

NS_ASSUME_NONNULL_END

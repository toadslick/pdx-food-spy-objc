#import <Foundation/Foundation.h>
#import "JSONFetcher.h"

NS_ASSUME_NONNULL_BEGIN

@class JSONFetcher;

@protocol JSONFetcherDelegate <NSObject>

- (void)jsonFetcher:(JSONFetcher *)fetcher didReceiveDictionary:(NSDictionary *)json;

- (void)jsonFetcher:(JSONFetcher *)fetcher didReceiveArray:(NSArray *)json;

- (void)jsonFetcher:(JSONFetcher *)fetcher didFailWithError:(NSError *)error;

@end

NS_ASSUME_NONNULL_END

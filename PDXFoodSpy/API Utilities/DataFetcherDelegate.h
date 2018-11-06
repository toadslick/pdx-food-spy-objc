#import <Foundation/Foundation.h>
#import "DataFetcher.h"

NS_ASSUME_NONNULL_BEGIN

@class DataFetcher;

@protocol DataFetcherDelegate <NSObject>

- (void)dataFetcher:(DataFetcher *)fetcher didReceiveData:(NSData *)data;

- (void)dataFetcher:(DataFetcher *)fetcher didFailWithError:(NSError *)error;

@end

NS_ASSUME_NONNULL_END

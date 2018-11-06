#import <Foundation/Foundation.h>
#import "DataFetcherDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DataFetcherDelegate;

@interface DataFetcher : NSObject

@property (weak) id <DataFetcherDelegate> delegate;

- (void)fetch:(NSString *)urlString;

@end

NS_ASSUME_NONNULL_END

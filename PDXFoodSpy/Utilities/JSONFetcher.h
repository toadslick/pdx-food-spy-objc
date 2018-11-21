#import <Foundation/Foundation.h>
#import "JSONFetcherDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@protocol JSONFetcherDelegate;

@interface JSONFetcher : NSObject

@property (weak) id <JSONFetcherDelegate> delegate;

- (void)fetch:(NSString *)urlString;

@end

NS_ASSUME_NONNULL_END

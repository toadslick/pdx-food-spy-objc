#import <Foundation/Foundation.h>
#import "SearchResult.h"

NS_ASSUME_NONNULL_BEGIN

@protocol RequestDelegate <NSObject>

- (void)requestDidFailWithError:(NSError *)error;

- (void)requestDidSucceedWithResults:(NSArray<NSObject *> *)results;

- (void)requestDidSucceedWithEmptyResults;

@end

NS_ASSUME_NONNULL_END

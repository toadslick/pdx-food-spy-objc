#import <Foundation/Foundation.h>
#import "SearchResult.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SearchCoordinateRequestDelegate <NSObject>

- (void)searchDidFailWithError:(NSError *)error;

- (void)searchDidSucceedWithResults:(NSArray<SearchResult *> *)results;

- (void)searchDidSucceedWithEmptyResults;

@end

NS_ASSUME_NONNULL_END

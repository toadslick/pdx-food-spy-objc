#import <UIKit/UIKit.h>
#import "SearchResult.h"

NS_ASSUME_NONNULL_BEGIN

@interface SearchResultsTabBarController : UITabBarController

@property NSArray<SearchResult *> *results;

- (void)fetchRestaurantHistory:(SearchResult *)result;

@end

NS_ASSUME_NONNULL_END

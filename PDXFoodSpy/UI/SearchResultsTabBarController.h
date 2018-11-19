#import <UIKit/UIKit.h>
#import "SearchResult.h"
#import "RestaurantHistoryRequest.h"
#import "RestaurantHistoryRequestDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface SearchResultsTabBarController : UITabBarController <RestaurantHistoryRequestDelegate>

@property NSArray<SearchResult *> *results;

- (void)fetchRestaurantHistory:(SearchResult *)result;

@end

NS_ASSUME_NONNULL_END

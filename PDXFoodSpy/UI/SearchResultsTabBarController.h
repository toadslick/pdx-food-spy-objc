#import <UIKit/UIKit.h>
#import "SearchResult.h"
#import "InspectionDetailRequest.h"
#import "RequestDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface SearchResultsTabBarController : UITabBarController <RequestDelegate>

@property NSArray<SearchResult *> *results;

- (void)fetchRestaurantHistory:(SearchResult *)result;

@end

NS_ASSUME_NONNULL_END

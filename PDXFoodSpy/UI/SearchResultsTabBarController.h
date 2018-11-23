#import <UIKit/UIKit.h>
#import "SearchResult.h"
#import "RestaurantHistoryRequest.h"
#import "RequestDelegate.h"
#import "InspectionHistoryViewController.h"
#import "SearchResultTabBarDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface SearchResultsTabBarController : UITabBarController <RequestDelegate>

@property NSArray<SearchResult *> *results;

@property (weak) id <SearchResultTabBarDelegate> tabBarDelegate;

- (void)fetchRestaurantHistory:(SearchResult *)result;

@end

NS_ASSUME_NONNULL_END

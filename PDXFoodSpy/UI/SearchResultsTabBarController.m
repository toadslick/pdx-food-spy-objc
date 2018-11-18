#import "SearchResultsTabBarController.h"

@interface SearchResultsTabBarController ()
@end

@implementation SearchResultsTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)fetchRestaurantHistory:(SearchResult *)result {
    NSLog(@"RESTAURANT NAME:%@, ID: %@", result.name, result.restaurantID);
}


@end

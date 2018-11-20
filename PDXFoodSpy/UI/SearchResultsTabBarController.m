#import "SearchResultsTabBarController.h"

@interface SearchResultsTabBarController ()
@end

@implementation SearchResultsTabBarController {
    RestaurantHistoryRequest *request;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    request = [RestaurantHistoryRequest new];
    request.delegate = self;
}

- (void)fetchRestaurantHistory:(SearchResult *)result {
    [request fetch:result.restaurantID];
}

- (void)requestDidSucceedWithResults:(NSArray<SearchResult *> *)results {
    NSLog(@"RESULTS: %@", results);
}

- (void)requestDidSucceedWithEmptyResults {
    NSLog(@"RESULTS: EMPTY");
}

- (void)requestDidFailWithError:(NSError *)error {
    NSLog(@"ERROR: %@", [error localizedDescription]);
}


@end

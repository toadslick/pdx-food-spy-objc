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
    [request fetch:result.inspectionID];
}

- (void)requestDidSucceedWithResults:(NSArray<InspectionViolation *> *)violations {
    NSLog(@"VIOLATIONS: %@", violations);
}

- (void)requestDidFailWithError:(NSError *)error {
    NSLog(@"ERROR: %@", [error localizedDescription]);
}


@end

#import "SearchResultsTabBarController.h"

@interface SearchResultsTabBarController ()
@end

@implementation SearchResultsTabBarController {
    InspectionDetailRequest *request;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    request = [InspectionDetailRequest new];
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

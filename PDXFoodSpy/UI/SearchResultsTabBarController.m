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
    [self performSegueWithIdentifier:@"historySegue" sender:results];
}

- (void)requestDidSucceedWithEmptyResults {
    NSLog(@"RESULTS: EMPTY");
}

- (void)requestDidFailWithError:(NSError *)error {
    NSLog(@"ERROR: %@", [error localizedDescription]);
}

// Pass the search results to the next view.
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    InspectionHistoryViewController *destination = [segue destinationViewController];
    destination.results = (NSArray<SearchResult *> *)sender;
}



@end

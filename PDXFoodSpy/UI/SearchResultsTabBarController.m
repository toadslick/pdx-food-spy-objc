#import "SearchResultsTabBarController.h"

@interface SearchResultsTabBarController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sortResetButton;
@end

@implementation SearchResultsTabBarController {
    RestaurantHistoryRequest *request;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    request = [RestaurantHistoryRequest new];
    request.delegate = self;
    
    [self updateSortResetButton:0];
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

- (void)updateSortResetButton:(NSInteger)selectedTabIndex {
    switch (selectedTabIndex) {
        case 0:
            self.sortResetButton.title = @"Sort";
            self.sortResetButton.enabled = YES;
            break;
        case 1:
            self.sortResetButton.title = @"Reset";
            self.sortResetButton.enabled = YES;
            break;
        default:
            self.sortResetButton.title = @"";
            self.sortResetButton.enabled = NO;
            break;
    }
}

- (IBAction)sortResetButtonTapped:(UIBarButtonItem *)sender {
    if (self.tabBarDelegate) {
        [self.tabBarDelegate rightBarButtonWasTapped];
    }
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    NSInteger index = [tabBar.items indexOfObject:item];
    [self updateSortResetButton:index];
}

@end

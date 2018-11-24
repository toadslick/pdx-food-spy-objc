#import "SearchResultsTableViewController.h"

@interface SearchResultsTableViewController ()
@end

@implementation SearchResultsTableViewController {
    NSArray<SearchResult *> *results;
    Boolean allowProximitySorting;
}

- (void)viewDidLoad {
    // Get the search results from the parent controller.
    SearchResultsTabBarController *parent = (SearchResultsTabBarController *)[self parentViewController];
    results = parent.results;
    allowProximitySorting = parent.allowProximitySorting;
}

- (void)viewWillAppear:(BOOL)animated {
    // Become the delegate of the parent controller to know when the right nav button item is tapped.
    SearchResultsTabBarController *parent = (SearchResultsTabBarController *)[self parentViewController];
    parent.tabBarDelegate = self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (results) {
        return results.count;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchResultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"searchResultCell"];
    SearchResult *result = [results objectAtIndex:[indexPath row]];
    cell.searchResult = result;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchResultsTabBarController *parent = (SearchResultsTabBarController *)[self parentViewController];
    SearchResult *result = [results objectAtIndex:[indexPath row]];
    [parent fetchRestaurantHistory:result];
}

- (void)rightBarButtonWasTapped {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NULL message:NULL preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *sortByNameAction = [UIAlertAction actionWithTitle:@"Sort by Name" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        [self sortResults:[self nameComparator]];
    }];
    [alert addAction:sortByNameAction];

    UIAlertAction *sortByScoreAction = [UIAlertAction actionWithTitle:@"Sort by Score" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        [self sortResults:[self scoreComparator]];
    }];
    [alert addAction:sortByScoreAction];

    // Only allow proximity sorting if search was done by coordinate.
    if (allowProximitySorting) {
        UIAlertAction *sortByProximityAction = [UIAlertAction actionWithTitle:@"Sort by Distance" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            [self sortResults:[self distanceComparator]];
        }];
        [alert addAction:sortByProximityAction];
    }

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {}];
    [alert addAction:cancelAction];

    [self presentViewController:alert animated:YES completion:nil];
}

- (void)sortResults:(NSComparator)comparator {
    results = [results sortedArrayUsingComparator:comparator];
    [self.tableView reloadData];
}

- (NSComparator)distanceComparator {
    return ^NSComparisonResult(SearchResult *r1, SearchResult *r2) {
        if (r1.distance > r2.distance) { return NSOrderedDescending; }
        if (r1.distance < r2.distance) { return NSOrderedAscending; }
        return NSOrderedSame;
    };
}

- (NSComparator)nameComparator {
    return ^NSComparisonResult(SearchResult *r1, SearchResult *r2) {
        return [r1.name compare:r2.name options:NSCaseInsensitiveSearch];
    };
}

- (NSComparator)scoreComparator {
    return ^NSComparisonResult(SearchResult *r1, SearchResult *r2) {
        if (r1.score > r2.score) { return NSOrderedDescending; }
        if (r1.score < r2.score) { return NSOrderedAscending; }
        return NSOrderedSame;
    };
}

@end

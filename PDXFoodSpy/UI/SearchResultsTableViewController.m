#import "SearchResultsTableViewController.h"

@interface SearchResultsTableViewController ()
@end

@implementation SearchResultsTableViewController {
    NSArray<SearchResult *> *results;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Get the search results from the parent controller.
    SearchResultsTabBarController *parent = (SearchResultsTabBarController *)[self parentViewController];
    results = parent.results;
}

// Become the delegate of the parent controller to know when the right nav button item is tapped.
- (void)viewDidAppear:(BOOL)animated {
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
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:NULL message:NULL preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* sortByProximityAction = [UIAlertAction actionWithTitle:@"Sort by Proximity" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
    UIAlertAction* sortByNameAction = [UIAlertAction actionWithTitle:@"Sort by Name" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
    UIAlertAction* sortByScoreAction = [UIAlertAction actionWithTitle:@"Sort by Score" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {}];

    [alert addAction:sortByNameAction];
    [alert addAction:sortByScoreAction];
    [alert addAction:sortByProximityAction];
    [alert addAction:cancelAction];

    [self presentViewController:alert animated:YES completion:nil];}

@end

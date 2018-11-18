#import "SearchResultsTableViewController.h"

@interface SearchResultsTableViewController ()
@end

@implementation SearchResultsTableViewController {
    NSArray<SearchResult *> *results;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    SearchResultsTabBarController *parent = (SearchResultsTabBarController *)[self parentViewController];
    results = parent.results;
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

@end

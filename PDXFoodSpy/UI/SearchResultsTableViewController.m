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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"searchResultCell" forIndexPath:indexPath];
    SearchResult *result = [results objectAtIndex:[indexPath row]];
    [cell textLabel].text = result.name;
    [cell detailTextLabel].text = result.address;
    return cell;
}

@end

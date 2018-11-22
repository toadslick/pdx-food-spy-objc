#import "InspectionHistoryTableViewController.h"

@implementation InspectionHistoryTableViewController {
    SearchResult *selectedResult;
    InspectionDetailRequest *request;
}

- (SearchResult *)selectedResult {
    return selectedResult;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    request = [InspectionDetailRequest new];
    request.delegate = self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.results) {
        return self.results.count;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    InspectionHistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"inspectionHistoryCell" forIndexPath:indexPath];
    SearchResult *result = [self.results objectAtIndex:[indexPath row]];
    cell.searchResult = result;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    selectedResult = [self.results objectAtIndex:[indexPath row]];
    [request fetch:selectedResult.inspectionID];
}

- (void)requestDidSucceedWithResults:(NSArray<InspectionViolation *> *)results {
    Inspection *inspection = [Inspection new];
    inspection.searchResult = selectedResult;
    inspection.violations = results;
    [self.parentViewController performSegueWithIdentifier:@"detailSegue" sender:inspection];
}

- (void)requestDidSucceedWithEmptyResults {
    
}

- (void)requestDidFailWithError:(NSError *)error {
    NSLog(@"ERROR: %@", [error localizedDescription]);
}

@end

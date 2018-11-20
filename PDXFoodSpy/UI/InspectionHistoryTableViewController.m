#import "InspectionHistoryTableViewController.h"

@interface InspectionHistoryTableViewController ()

@end

@implementation InspectionHistoryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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

@end

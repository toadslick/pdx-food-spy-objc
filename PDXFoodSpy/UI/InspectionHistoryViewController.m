#import "InspectionHistoryViewController.h"

@interface InspectionHistoryViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation InspectionHistoryViewController {
    SearchResult *selectedResult;
    InspectionDetailRequest *request;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Decorate the restaurant labels.
    SearchResult *firstResult = [self.results objectAtIndex:0];
    self.nameLabel.text = firstResult.name;
    self.addressLabel.text = firstResult.address;
    
    // Required to manage a table view.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // Yet another request delegate.
    request = [InspectionDetailRequest new];
    request.delegate = self;
}

// Since not using a TableViewController, have to manually
// deselect the previous selected row when the table appears.
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSIndexPath *path = self.tableView.indexPathForSelectedRow;
    if (path) {
        [self.tableView deselectRowAtIndexPath:path animated:YES];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(NSArray<InspectionViolation *> *)sender {
    InspectionDetailViewController *vc = segue.destinationViewController;
    vc.searchResult = selectedResult;
    vc.violations = sender;
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
    [self performSegueWithIdentifier:@"detailSegue" sender:results];
}

- (void)requestDidSucceedWithEmptyResults {}

- (void)requestDidFailWithError:(NSError *)error {
    [AlertPresenter presentAlert:nil withMessage:[error localizedDescription] forController:(UIViewController *)self];
}

@end

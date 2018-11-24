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

- (void)viewWillAppear:(BOOL)animated {
    NSIndexPath *path = self.tableView.indexPathForSelectedRow;
    if (path) {
        [self.tableView deselectRowAtIndexPath:path animated:NO];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    Inspection *inspection = sender;
    InspectionDetailViewController *vc = segue.destinationViewController;
    vc.inspection = inspection;
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
    [self performSegueWithIdentifier:@"detailSegue" sender:inspection];
}

- (void)requestDidSucceedWithEmptyResults {}

- (void)requestDidFailWithError:(NSError *)error {
    [AlertPresenter presentAlert:nil withMessage:[error localizedDescription] forController:(UIViewController *)self];
}

@end

#import "InspectionHistoryViewController.h"

@interface InspectionHistoryViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@end

@implementation InspectionHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SearchResult *firstResult = [self.results objectAtIndex:0];
    self.nameLabel.text = firstResult.name;
    self.addressLabel.text = firstResult.address;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"embedHistorySegue"]) {
        InspectionHistoryTableViewController *vc = segue.destinationViewController;
        vc.results = self.results;
    } else if ([segue.identifier isEqualToString:@"detailSegue"]) {
        Inspection *inspection = sender;
        InspectionDetailViewController *vc = segue.destinationViewController;
        vc.inspection = inspection;
    }
}

@end

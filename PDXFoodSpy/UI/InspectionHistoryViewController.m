#import "InspectionHistoryViewController.h"

@interface InspectionHistoryViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIView *containerView;
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
    }
}

@end

#import "InspectionDetailViewController.h"

@interface InspectionDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@end

@implementation InspectionDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SearchResult *result = self.inspection.searchResult;
    self.nameLabel.text = result.name;
    self.dateLabel.text = [result dateString];
    self.scoreLabel.text = [result scoreString];
    self.scoreLabel.textColor = [result scoreColor];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"embedDetailSegue"]) {
        InspectionDetailTableViewController *vc = segue.destinationViewController;
        vc.violations = self.inspection.violations;
    }
}

@end

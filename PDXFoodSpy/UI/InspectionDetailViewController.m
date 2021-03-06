#import "InspectionDetailViewController.h"

@interface InspectionDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation InspectionDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Decorate the labels above the table view.
    self.nameLabel.text = self.searchResult.name;
    self.dateLabel.text = [self.searchResult dateString];
    self.scoreLabel.text = [self.searchResult scoreString];
    self.scoreLabel.textColor = [self.searchResult scoreColor];
    
    // Required table view delegate setup.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.violations) {
        return self.violations.count;
    } else {
        return 0;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    InspectionViolation *violation = [self.violations objectAtIndex:section];
    NSInteger rows = 1;
    if ([self isNotBlank:violation.violationComments]) { rows += 1; }
    // if ([self isNotBlank:violation.correctiveText]) { rows += 1; }
    // if ([self isNotBlank:violation.correctiveComments]) { rows += 1; }
    return rows;
}

- (Boolean)isNotBlank:(NSString *)string {
    return string && ![string isEqualToString:@""];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    InspectionViolation *violation = [self.violations objectAtIndex:section];
    return violation.lawCode;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    InspectionViolation *violation = [self.violations objectAtIndex:indexPath.section];
    
    // For an inspection with no violations, the API returns a single violation where all the strings are empty.
    // If this table includes only a single empty violation, display an empty set message instead.
    if (self.violations.count == 1 && [violation.violationText isEqualToString:@""]) {
        return [tableView dequeueReusableCellWithIdentifier:@"emptySetCell"];
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detailCell"];
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = violation.violationText;
            break;
        case 1:
            cell.textLabel.text = violation.violationComments;
            break;
        case 2:
            cell.textLabel.text = violation.correctiveText;
            break;
        case 3:
            cell.textLabel.text = violation.correctiveComments;
            break;
    }
    return cell;
}
@end

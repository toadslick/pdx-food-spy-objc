#import "InspectionDetailTableViewController.h"

@interface InspectionDetailTableViewController ()

@end

@implementation InspectionDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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

#import <UIKit/UIKit.h>
#import "InspectionViolation.h"

NS_ASSUME_NONNULL_BEGIN

@interface InspectionDetailTableViewController : UITableViewController

@property NSArray<InspectionViolation *> *violations;

@end

NS_ASSUME_NONNULL_END
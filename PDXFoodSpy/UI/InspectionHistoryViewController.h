#import <UIKit/UIKit.h>
#import "Inspection.h"
#import "InspectionHistoryTableViewController.h"
#import "InspectionDetailViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface InspectionHistoryViewController : UIViewController

@property NSArray<SearchResult *> *results;

@end

NS_ASSUME_NONNULL_END

#import <UIKit/UIKit.h>
#import "SearchResult.h"
#import "InspectionHistoryTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface InspectionHistoryViewController : UIViewController

@property NSArray<SearchResult *> *results;

@end

NS_ASSUME_NONNULL_END

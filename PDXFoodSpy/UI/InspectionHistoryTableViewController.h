#import <UIKit/UIKit.h>
#import "InspectionHistoryTableViewCell.h"
#import "RequestDelegate.h"
#import "InspectionDetailRequest.h"
#import "InspectionHistoryViewController.h"
#import "Inspection.h"


NS_ASSUME_NONNULL_BEGIN

@interface InspectionHistoryTableViewController : UITableViewController <RequestDelegate>

@property NSArray<SearchResult *> *results;

- (SearchResult *)selectedResult;

@end

NS_ASSUME_NONNULL_END

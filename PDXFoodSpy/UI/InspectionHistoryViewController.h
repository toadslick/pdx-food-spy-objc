#import <UIKit/UIKit.h>
#import "Inspection.h"
#import "InspectionDetailViewController.h"
#import "RequestDelegate.h"
#import "InspectionDetailRequest.h"
#import "InspectionHistoryTableViewCell.h"
#import "AlertPresenter.h"

NS_ASSUME_NONNULL_BEGIN

@interface InspectionHistoryViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, RequestDelegate>

@property NSArray<SearchResult *> *results;

@end

NS_ASSUME_NONNULL_END

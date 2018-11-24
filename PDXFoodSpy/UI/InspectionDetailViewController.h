#import <UIKit/UIKit.h>
#import "SearchResult.h"
#import "InspectionViolation.h"

NS_ASSUME_NONNULL_BEGIN

@interface InspectionDetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property SearchResult *searchResult;

@property NSArray<InspectionViolation *> *violations;

@end

NS_ASSUME_NONNULL_END

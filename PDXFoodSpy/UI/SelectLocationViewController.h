#import <UIKit/UIKit.h>
#import "CurrentLocationUpdater.h"
#import "CurrentLocationUpdaterDelegate.h"
#import "AddressGeocoderDelegate.h"
#import "SearchDelegate.h"
#import "SearchCoordinateRequest.h"
#import "SearchResultsTabBarController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SelectLocationViewController : UIViewController <CurrentLocationUpdaterDelegate, AddressGeocoderDelegate, SearchDelegate, UISearchBarDelegate>

@property (nonatomic) Boolean isBusy;

@end

NS_ASSUME_NONNULL_END

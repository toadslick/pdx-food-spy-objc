#import <UIKit/UIKit.h>
#import "CurrentLocationUpdater.h"
#import "CurrentLocationUpdaterDelegate.h"
#import "AddressGeocoderDelegate.h"
#import "RequestDelegate.h"
#import "SearchCoordinateRequest.h"
#import "SearchNameRequest.h"
#import "SearchResultsTabBarController.h"
#import "AlertPresenter.h"

NS_ASSUME_NONNULL_BEGIN

@interface SelectLocationViewController : UIViewController <CurrentLocationUpdaterDelegate, AddressGeocoderDelegate, RequestDelegate, UISearchBarDelegate>

@property (nonatomic) Boolean isBusy;

@end

NS_ASSUME_NONNULL_END

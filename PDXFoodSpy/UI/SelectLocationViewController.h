#import <UIKit/UIKit.h>
#import "CurrentLocationUpdaterDelegate.h"
#import "AddressGeocoderDelegate.h"
#import "SearchDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface SelectLocationViewController : UIViewController <CurrentLocationUpdaterDelegate, AddressGeocoderDelegate, SearchDelegate>

@end

NS_ASSUME_NONNULL_END

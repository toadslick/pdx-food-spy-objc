#import <UIKit/UIKit.h>
#import "CurrentLocationUpdaterDelegate.h"
#import "AddressGeocoderDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface SelectLocationViewController : UIViewController <CurrentLocationUpdaterDelegate, AddressGeocoderDelegate>

@end

NS_ASSUME_NONNULL_END

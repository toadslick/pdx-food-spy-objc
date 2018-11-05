#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "AddressGeocoderDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@protocol AddressGeocoderDelegate;

@interface AddressGeocoder : NSObject

@property (weak) id <AddressGeocoderDelegate> delegate;

- (void)geocode:(NSString *)address;

@end

NS_ASSUME_NONNULL_END

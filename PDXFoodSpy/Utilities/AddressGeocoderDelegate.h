#import <Foundation/Foundation.h>
#import "AddressGeocoder.h"

NS_ASSUME_NONNULL_BEGIN

@class AddressGeocoder;

@protocol AddressGeocoderDelegate <NSObject>

- (void)addressGeocoder:(AddressGeocoder *)geocoder foundCoordinate:(CLLocationCoordinate2D)coordinate forAddress:(NSString *)address;

- (void)addressGeocoder:(AddressGeocoder *)geocoder didFailWithError:(NSError *)error forAddress:(NSString *)address;

@end

NS_ASSUME_NONNULL_END

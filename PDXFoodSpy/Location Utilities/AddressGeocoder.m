#import "AddressGeocoder.h"

@implementation AddressGeocoder {
    CLGeocoder *geocoder;
    CLCircularRegion* region;
}

- (id)init {
    self = [super init];
    geocoder = [CLGeocoder new];
    region = [[CLCircularRegion alloc] initWithCenter:CLLocationCoordinate2DMake(45.51223, -122.65871) radius:16000 identifier:@"Portland"];
    return self;
}

- (void)geocode:(NSString *)address {
    [geocoder geocodeAddressString:address inRegion:region completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (self.delegate) {
            if (error) {
                [self.delegate addressGeocoder:self didFailWithError:error forAddress:address];
            } else {
                CLPlacemark *place = [placemarks firstObject];
                [self.delegate addressGeocoder:self foundCoordinate:place.location.coordinate forAddress:address];
            }
        }
    }];
}

@end

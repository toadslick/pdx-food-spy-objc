#import "CurrentLocationUpdater.h"

@implementation CurrentLocationUpdater {
    CLLocationManager *manager;
    Boolean shouldRequestLocation;
}

- (id)init {
    self = [super init];
    shouldRequestLocation = NO;
    manager = [CLLocationManager new];
    manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    manager.distanceFilter  = kCLDistanceFilterNone;
    manager.delegate = self;
    return self;
}

- (void)start {
    shouldRequestLocation = YES;
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [manager startUpdatingLocation];
    } else {
        [manager requestWhenInUseAuthorization];
    }
}

- (void)stop {
    shouldRequestLocation = NO;
    [manager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *location = [locations lastObject];
    if (self.delegate) {
        [self.delegate currentLocationUpdater:self didUpdateCoordinate:location.coordinate];
    }
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (shouldRequestLocation && status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [manager startUpdatingLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if (self.delegate) {
        [self.delegate currentLocationUpdater:self didFailWithError:error];
    }
}

@end

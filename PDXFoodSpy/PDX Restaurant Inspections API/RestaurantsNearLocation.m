#import "RestaurantsNearLocation.h"

@implementation RestaurantsNearLocation

- (NSString *)buildURLString:(CLLocationCoordinate2D)coordinate {
    NSString *formatString = @"http://api.civicapps.org/restaurant-inspections/near/%f,%f";
    return [[NSString alloc] initWithFormat:formatString, coordinate.latitude, coordinate.longitude];
}

@end

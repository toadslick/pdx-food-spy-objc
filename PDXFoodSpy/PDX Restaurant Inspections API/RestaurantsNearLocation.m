#import "RestaurantsNearLocation.h"

@implementation RestaurantsNearLocation {
    DataFetcher *dataFetcher;
}

- (id)init {
    self = [super init];
    dataFetcher = [DataFetcher new];
    dataFetcher.delegate = self;
    return self;
}

- (void)fetch:(CLLocationCoordinate2D)coordinate {
    [dataFetcher fetch:[self buildURLString:coordinate]];
}

- (NSString *)buildURLString:(CLLocationCoordinate2D)coordinate {
    NSString *formatString = @"http://api.civicapps.org/restaurant-inspections/near/%f,%f";
    return [[NSString alloc] initWithFormat:formatString, coordinate.latitude, coordinate.longitude];
}


- (void)dataFetcher:(DataFetcher *)fetcher didReceiveData:(NSData *)data {
    NSLog(@"RESTAURANT SEARCH SUCCESS: %@", data);
}

- (void)dataFetcher:(DataFetcher *)fetcher didFailWithError:(NSError *)error {
    NSLog(@"RESTAURANT SEARCH ERROR: %@, %@", [error localizedFailureReason], [error localizedDescription]);
}


@end

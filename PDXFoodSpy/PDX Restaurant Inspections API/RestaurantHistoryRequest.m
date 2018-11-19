#import "RestaurantHistoryRequest.h"

@implementation RestaurantHistoryRequest {
    JSONFetcher *jsonFetcher;
}

- (id)init {
    self = [super init];
    jsonFetcher = [JSONFetcher new];
    jsonFetcher.delegate = self;
    return self;
}

- (void)fetch:(NSString *)inspectionID {
    NSString *format = @"http://api.civicapps.org/restaurant-inspections/inspection/%@";
    NSString *url = [[NSString alloc] initWithFormat:format, inspectionID];
    NSLog(@"REQUEST: %@", url);
    [jsonFetcher fetch:url];
}

- (void)jsonFetcher:(JSONFetcher *)fetcher didReceiveArray:(NSArray *)json {
    NSLog(@"JSON ARRAY: %@", json);
}

- (void)jsonFetcher:(JSONFetcher *)fetcher didReceiveDictionary:(NSDictionary *)json {
    NSLog(@"JSON DICT: %@", json);
}

- (void)jsonFetcher:(JSONFetcher *)fetcher didFailWithError:(NSError *)error {
    if (self.delegate) {
        [self.delegate requestDidFailWithError:error];
    }
}

@end

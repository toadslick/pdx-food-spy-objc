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

// This should never occur for this endpoint. TODO: raise a custom error?
- (void)jsonFetcher:(JSONFetcher *)fetcher didReceiveArray:(NSArray *)json {
}

- (void)jsonFetcher:(JSONFetcher *)fetcher didReceiveDictionary:(NSDictionary *)json {
    NSArray<InspectionViolation *> *violations = [self deserializeResults:json];
    [self.delegate requestDidSucceedWithResults:violations];
}

- (void)jsonFetcher:(JSONFetcher *)fetcher didFailWithError:(NSError *)error {
    if (self.delegate) {
        [self.delegate requestDidFailWithError:error];
    }
}

- (NSArray<InspectionViolation *> *)deserializeResults:(NSDictionary *)json {
    NSDictionary *results = [json objectForKey:@"results"];
    NSArray<NSDictionary *> *dicts = [results objectForKey:@"violations"];
    NSMutableArray<InspectionViolation *> *violations = [NSMutableArray new];
    [dicts enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull dict, NSUInteger idx, BOOL * _Nonnull stop) {
        InspectionViolation *violation = [InspectionViolation initFromJSONDictionary:dict];
        [violations addObject:violation];
    }];
    return violations;
}

@end

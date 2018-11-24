#import "JSONFetcher.h"

@implementation JSONFetcher

- (void)fetch:(NSString *)urlString {
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (self.delegate) {
            if (error) {
                // Return to the main thread before notifying any delegates.
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.delegate jsonFetcher:self didFailWithError:error];
                });
            } else {
                [self parseJSON:data];
            }
        }
    }];
    [task resume];
}

- (void)parseJSON:(NSData *)data {
    NSError *error = nil;
    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    
    // Return to the main thread before notifying any delegates.
    dispatch_async(dispatch_get_main_queue(), ^{
        if (error) {
            [self.delegate jsonFetcher:self didFailWithError:error];
        } else {
            if ([json isKindOfClass:[NSDictionary class]]) {
                [self.delegate jsonFetcher:self didReceiveDictionary:json];
            } else if ([json isKindOfClass:[NSArray class]]) {
                [self.delegate jsonFetcher:self didReceiveArray:json];
            }
        }
    });
}

@end

#import "JSONFetcher.h"

@implementation JSONFetcher

- (void)fetch:(NSString *)urlString {
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (self.delegate) {
            if (error) {
                [self.delegate jsonFetcher:self didFailWithError:error];
            } else {
                [self parseJSON:data];
            }
        }
    }];
    [task resume];
}

- (void)parseJSON:(NSData *)data {
    // TODO: move to dispatch queue
    NSError *error = nil;
    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    if (error) {
        [self.delegate jsonFetcher:self didFailWithError:error];
    } else {
        [self.delegate jsonFetcher:self didReceiveJSON:json];
    }
}

@end

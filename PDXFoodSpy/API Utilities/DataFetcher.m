#import "DataFetcher.h"

@implementation DataFetcher

- (void)fetch:(NSString *)urlString {
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (self.delegate) {
            if (error) {
                [self.delegate dataFetcher:self didFailWithError:error];
            } else {
                [self.delegate dataFetcher:self didReceiveData:data];
            }
        }
    }];
    [task resume];
}

@end

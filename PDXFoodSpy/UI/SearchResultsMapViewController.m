#import "SearchResultsMapViewController.h"

@interface SearchResultsMapViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@end

@implementation SearchResultsMapViewController {
    NSArray<SearchResult *> *results;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    SearchResultsTabBarController *parent = (SearchResultsTabBarController *)[self parentViewController];
    results = parent.results;
    
    // Add pins to the map view.
    [self.mapView removeAnnotations:[self.mapView annotations]];
    [results enumerateObjectsUsingBlock:^(SearchResult * _Nonnull result, NSUInteger idx, BOOL * _Nonnull stop) {
        MKPointAnnotation *point = [MKPointAnnotation new];
        point.coordinate = result.coordinate;
        [self.mapView addAnnotation:point];
    }];
}

@end

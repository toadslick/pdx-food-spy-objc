#import "SearchResultsMapViewController.h"

@interface SearchResultsMapViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@end

@implementation SearchResultsMapViewController {
    NSArray<SearchResult *> *results;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Get the search results from the parent controller.
    SearchResultsTabBarController *parent = (SearchResultsTabBarController *)self.parentViewController;
    results = [self filteredResults:parent.results];
    
    // Add pins to the map view.
    self.mapView.delegate = self;
    [self.mapView removeAnnotations:[self.mapView annotations]];
    [self.mapView addAnnotations:results];
    
    [self resetMapBounds:NO];
}

// Become the delegate of the parent controller to know when the right nav button item is tapped.
- (void)viewDidAppear:(BOOL)animated {
    SearchResultsTabBarController *parent = (SearchResultsTabBarController *)[self parentViewController];
    parent.tabBarDelegate = self;
}

// Render the map marker for each search result.
// Use the inspection score as the reuse identifier because the marker's customization,
// such as tintColor and glyphText, are determined by the score.
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    SearchResult *result = (SearchResult *)annotation;
    MKMarkerAnnotationView *marker = (MKMarkerAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:[result scoreString]];
    if (marker) {
        return marker;
    } else {
        marker = [[MKMarkerAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:[result scoreString]];
        marker.markerTintColor = [result scoreColor];
        marker.glyphText = [result scoreString];
        marker.canShowCallout = YES;
        marker.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    }
    return marker;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    SearchResultsTabBarController *parent = (SearchResultsTabBarController *)[self parentViewController];
    [parent fetchRestaurantHistory:(SearchResult *)view.annotation];
}

- (void)rightBarButtonWasTapped {
    [self resetMapBounds:YES];
}

// Adjust the map's visible region to fit the added pins.
- (void)resetMapBounds:(Boolean)shouldAnimate {
    [self.mapView showAnnotations:results animated:shouldAnimate];
}

- (NSArray<SearchResult *> *)filteredResults:(NSArray<SearchResult *> *)allResults {
    return [allResults filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(SearchResult *result, NSDictionary<NSString *,id> * _Nullable bindings) {
        return (result.coordinate.latitude != 0 && result.coordinate.longitude != 0);
    }]];
}
@end

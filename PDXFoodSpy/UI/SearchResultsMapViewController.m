#import "SearchResultsMapViewController.h"
#import "SearchResultTableViewCell.h"

@interface SearchResultsMapViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@end

@implementation SearchResultsMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray<SearchResult *> *results = ((SearchResultsTabBarController *)[self parentViewController]).results;
    self.mapView.delegate = self;

    // Add pins to the map view.
    [self.mapView removeAnnotations:[self.mapView annotations]];
    [self.mapView addAnnotations:results];
    
    // Adjust the map's visible region to fit the added pins.
    [self.mapView showAnnotations:results animated:false];
}

// Render the map marker for each search result.
// Use the inspection score as the reuse identifier because the marker's customization,
// such as tintColor and glyphText, are determined by the score.
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    SearchResult *result = (SearchResult *)annotation;
    MKAnnotationView *reuseMarker = [mapView dequeueReusableAnnotationViewWithIdentifier:[result scoreString]];
    if (reuseMarker) {
        return reuseMarker;
    } else {
        MKMarkerAnnotationView *marker = [[MKMarkerAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:[result scoreString]];
        marker.markerTintColor = [result scoreColor];
        marker.glyphText = [result scoreString];
        marker.canShowCallout = YES;
        marker.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        return marker;
    }
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    SearchResultsTabBarController *parent = (SearchResultsTabBarController *)[self parentViewController];
    [parent fetchRestaurantHistory:(SearchResult *)view.annotation];
}

@end

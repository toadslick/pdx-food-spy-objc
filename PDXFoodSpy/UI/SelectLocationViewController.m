#import "SelectLocationViewController.h"

@interface SelectLocationViewController ()
@property (weak, nonatomic) IBOutlet UIButton *currentLocationButton;
@property (weak, nonatomic) IBOutlet UISearchBar *addressSearchField;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *busySpinner;
@property (weak, nonatomic) IBOutlet UISegmentedControl *searchTypeControl;
@end

@implementation SelectLocationViewController {
    CurrentLocationUpdater *clu;
    AddressGeocoder *geocoder;
    CLLocationCoordinate2D currentCoordinate;
    SearchCoordinateRequest *search;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Disable this button until the curent location is detected.
    self.currentLocationButton.enabled = NO;
    
    // Begin detecting the current location.
    clu = [CurrentLocationUpdater new];
    clu.delegate = self;
    [clu start];
    
    // Initialize the address search classes and their delegates.
    geocoder = [AddressGeocoder new];
    geocoder.delegate = self;
    search = [SearchCoordinateRequest new];
    search.delegate = self;
    self.addressSearchField.delegate = self;
    
    // Style the current location button.
    self.currentLocationButton.layer.cornerRadius = self.currentLocationButton.layer.frame.size.height / 3;
}

- (IBAction)currentLocationButtonTapped:(id)sender {
    self.isBusy = YES;
    [search fetch:currentCoordinate];
}

- (IBAction)searchTypeSelected:(UISegmentedControl *)sender {
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    if (self.isBusy) {
        return;
    } else {
        self.isBusy = YES;
        NSString *address = searchBar.text;
        if (address) {
            [geocoder geocode:address];
        }
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    // Pass the search results to the next view.
    SearchResultsTabBarController *destination = [segue destinationViewController];
    destination.results = (NSArray<SearchResult *> *)sender;

    // Stop updating the current location.
    [clu stop];
}

- (void)currentLocationUpdater:(CurrentLocationUpdater *)updater didUpdateCoordinate:(CLLocationCoordinate2D)coordinate {
    self.currentLocationButton.enabled = YES;
    currentCoordinate = coordinate;
}

- (void)currentLocationUpdater:(CurrentLocationUpdater *)updater didFailWithError:(NSError *)error {
    NSLog(@"ERROR: %@", [error localizedDescription]);
}

- (void)addressGeocoder:(AddressGeocoder *)geocoder foundCoordinate:(CLLocationCoordinate2D)coordinate forAddress:(NSString *)address {
    [search fetch:coordinate];
}

- (void)addressGeocoder:(AddressGeocoder *)geocoder didFailWithError:(NSError *)error forAddress:(NSString *)address {
    self.isBusy = NO;
    NSLog(@"ERROR: %@", [error localizedDescription]);
}

- (void)requestDidSucceedWithResults:(NSArray<SearchResult *> *)results {
    self.isBusy = NO;
    [self performSegueWithIdentifier:@"searchSuccessSegue" sender:results];
}

- (void)requestDidSucceedWithEmptyResults {
    self.isBusy = NO;
    NSLog(@"RESULTS: EMPTY");
}

- (void)requestDidFailWithError:(NSError *)error {
    self.isBusy = NO;
    NSLog(@"ERROR: %@", [error localizedDescription]);
}

- (void)setIsBusy:(Boolean)isBusy {
    _isBusy = isBusy;
    self.currentLocationButton.enabled = !isBusy;
 
    // "Hides when stopped" property is set on the spinner in the storyboard,
    // so there is no need to show and hide the spinner from the code.
    if (isBusy) {
        [self.busySpinner startAnimating];
    } else {
        [self.busySpinner stopAnimating];
    }
}

@end

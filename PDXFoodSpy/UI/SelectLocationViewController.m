#import "SelectLocationViewController.h"

@interface SelectLocationViewController ()
@property (weak, nonatomic) IBOutlet UIButton *currentLocationButton;
@property (weak, nonatomic) IBOutlet UISearchBar *searchField;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *busySpinner;
@property (weak, nonatomic) IBOutlet UISegmentedControl *searchTypeControl;
@end

@implementation SelectLocationViewController {
    CurrentLocationUpdater *clu;
    AddressGeocoder *geocoder;
    CLLocationCoordinate2D currentCoordinate;
    SearchCoordinateRequest *coordinateSearch;
    SearchNameRequest *nameSearch;
    Boolean searchIncludesProximity;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Disable this button until the curent location is detected.
    self.currentLocationButton.enabled = NO;
    
    // Initialize all the things with delegates.
    geocoder = [AddressGeocoder new];
    geocoder.delegate = self;
    clu = [CurrentLocationUpdater new];
    clu.delegate = self;
    coordinateSearch = [SearchCoordinateRequest new];
    coordinateSearch.delegate = self;
    nameSearch = [SearchNameRequest new];
    nameSearch.delegate = self;
    self.searchField.delegate = self;

    // Begin detecting the current location.
    [clu start];
    
    // Set the initial placeholder of the search field.
    [self updateSearchPlaceholder];
    
    // Disable proximity searching until the user searches by address or current location.
    searchIncludesProximity = NO;
}

- (IBAction)currentLocationButtonTapped:(id)sender {
    self.isBusy = YES;
    searchIncludesProximity = YES;
    [coordinateSearch fetch:currentCoordinate];
}

- (IBAction)searchTypeSelected:(UISegmentedControl *)sender {
    [self updateSearchPlaceholder];
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    if (self.isBusy) {
        return;
    } else {
        self.isBusy = YES;
        if (searchBar.text) {
            // Trim excess whitespace from the search query.
            NSString *query = [searchBar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            // Perform either a name or address search depending on the selected option.
            switch (self.searchTypeControl.selectedSegmentIndex) {
                case 0:
                    searchIncludesProximity = YES;
                    [geocoder geocode:query];
                    break;
                case 1:
                    searchIncludesProximity = NO;
                    [nameSearch fetch:query];
                    break;
            }
        }
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    // Pass the search results to the next view.
    SearchResultsTabBarController *destination = [segue destinationViewController];
    destination.results = (NSArray<SearchResult *> *)sender;
    destination.allowProximitySorting = searchIncludesProximity;
    
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
    [coordinateSearch fetch:coordinate];
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
    self.searchTypeControl.enabled = !isBusy;
    self.searchField.userInteractionEnabled = !isBusy;
 
    // "Hides when stopped" property is set on the spinner in the storyboard,
    // so there is no need to show and hide the spinner from the code.
    if (isBusy) {
        [self.busySpinner startAnimating];
    } else {
        [self.busySpinner stopAnimating];
    }
}

- (void)updateSearchPlaceholder {
    switch (self.searchTypeControl.selectedSegmentIndex) {
        case 0:
            self.searchField.placeholder = @"Enter a Street Address";
            break;
        case 1:
            self.searchField.placeholder = @"Enter a Restaurant Name";
            break;
    }
}

@end

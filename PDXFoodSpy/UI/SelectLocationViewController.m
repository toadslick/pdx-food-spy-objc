#import "SelectLocationViewController.h"
#import "CurrentLocationUpdater.h"

@interface SelectLocationViewController ()
@property (weak, nonatomic) IBOutlet UIButton *currentLocationButton;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@end

@implementation SelectLocationViewController {
    CurrentLocationUpdater *clu;
    CLLocationCoordinate2D currentCoordinate;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Disable this button until the curent location is detected.
    self.currentLocationButton.enabled = false;
    
    // Begin detecting the current location.
    clu = [CurrentLocationUpdater new];
    clu.delegate = self;
    [clu start];
}

- (IBAction)currentLocationButtonTapped:(id)sender {
    NSLog(@"CURRENT LOCATION: %f, %f", currentCoordinate.latitude, currentCoordinate.longitude);
}
- (IBAction)addressTextFieldSubmitted:(id)sender {
    NSLog(@"ADDRESS ENTERED: %@", self.addressTextField.text);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    // Stop updating the current location.
    [clu stop];
}

- (void)currentLocationUpdater:(CurrentLocationUpdater *)updater didUpdateCoordinate:(CLLocationCoordinate2D)coordinate {
    self.currentLocationButton.enabled = true;
    currentCoordinate = coordinate;
}

- (void)currentLocationUpdater:(CurrentLocationUpdater *)updater didFailWithError:(NSError *)error {
    NSLog(@"CURRENT LOCATION ERROR: %@, %@", [error localizedFailureReason], [error localizedDescription]);
}

@end

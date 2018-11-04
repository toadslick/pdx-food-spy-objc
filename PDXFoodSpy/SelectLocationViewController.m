#import "SelectLocationViewController.h"
#import "CurrentLocationUpdater.h"

@interface SelectLocationViewController ()
@property (weak, nonatomic) IBOutlet UIButton *currentLocationButton;
@end

@implementation SelectLocationViewController {
    CurrentLocationUpdater *clu;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Disable this button until the curent location is detected.
    self.currentLocationButton.enabled = false;
    
    // Begin detecting the current location.
    clu = [CurrentLocationUpdater new];
    [clu start];
}

- (IBAction)currentLocationButtonTapped:(id)sender {
    NSLog(@"button tapped!");
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    // Stop updating the current location.
    [clu stop];
}

@end

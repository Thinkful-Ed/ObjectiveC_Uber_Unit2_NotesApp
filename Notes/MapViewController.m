//
//  MapViewController.m
//  Notes
//
//  Created by Craig on 23/07/2015.
//  Copyright (c) 2015 Thinkful. All rights reserved.
//

#import "MapViewController.h"
#import "Masonry.h"
#import "ViewController.h"
#import "Model.h"
#import "Notes.h"
#import "Note.h"

@interface MapViewController ()

@end

@implementation MapViewController

-(id)init {
    self = [super init];
    if (!self) {
        return nil; //something went wrong!
    }
    self.title = @"Maps";
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Map" image:[UIImage imageNamed:@"Map"] tag:1];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    CGRect fullScreenBounds = [[UIScreen mainScreen] bounds];
    self.mapView = [[MKMapView alloc] init];
    [self.view addSubview:self.mapView];
    self.mapView.delegate=self;
    
    //Set up Masonry constraints
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}
-(void)viewDidAppear:(BOOL)animated {
    self.annotationArray = [self createArrayOfNotePins];
    [self.mapView addAnnotations:self.annotationArray];
    [self.mapView showAnnotations:self.mapView.annotations animated:YES];
}
-(void)viewDidDisappear:(BOOL)animated {
    [self.mapView removeAnnotations:self.mapView.annotations];
}
- (NSArray *)createArrayOfNotePins {
    NSMutableArray *pointAnnotations = [@[] mutableCopy];
    
    for (int i=0; i<[[Model sharedModel].notes count]; i++) {
        Note *note = [[Model sharedModel].notes getNoteAtIndex:i];
        MKPointAnnotation *pointAnnotation = [[MKPointAnnotation alloc] init];
        pointAnnotation.title = note.title;
        pointAnnotation.subtitle = note.detail;
        pointAnnotation.coordinate = note.coordinate;
        [pointAnnotations addObject:pointAnnotation];
    }
    return [pointAnnotations copy];
}
#pragma mark MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    // If it's the user location, just return nil.
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    // Handle any custom annotations.
    if ([annotation isKindOfClass:[MKPointAnnotation class]])
    {
        // Try to dequeue an existing pin view first.
        MKPinAnnotationView *pinView = (MKPinAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier:@"CustomPinAnnotationView"];
        if (!pinView)
        {
            // If an existing pin view was not available, create one.
            pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CustomPinAnnotationView"];
            // 4. Customize the pin!
            pinView.pinColor = MKPinAnnotationColorPurple;
            pinView.canShowCallout = YES;
            //Customize the callout
            UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            pinView.rightCalloutAccessoryView = rightButton;
        } else {
            pinView.annotation = annotation;
        }
        return pinView;
    }
    return nil;
}
-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    id <MKAnnotation> annotation = [view annotation];
    if ([annotation isKindOfClass:[MKPointAnnotation class]]) {
        NSUInteger index = [self.annotationArray indexOfObject:annotation];
        if (index == NSNotFound) {
            NSLog(@"Not found");
            return;
        }
        Note *note = [[Model sharedModel].notes getNoteAtIndex:index];
        
        ViewController *detailViewController = [[ViewController alloc] initWithNote:note];
        [self.navigationController pushViewController:detailViewController animated:YES];
        
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

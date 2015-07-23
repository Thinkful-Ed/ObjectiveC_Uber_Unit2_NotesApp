//
//  MapViewController.h
//  Notes
//
//  Created by Craig on 23/07/2015.
//  Copyright (c) 2015 Thinkful. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController<MKMapViewDelegate>
@property (strong, nonatomic) MKMapView *mapView;
@property (strong, nonatomic) NSArray *annotationArray;
@end

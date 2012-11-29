//
//  ViewController.h
//  GoogleChallenge
//
//  Created by Vladimir Gogunsky on 10/26/12.
//  Copyright (c) 2012 Vladimir Gogunsky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ViewController : UIViewController <UISearchBarDelegate, UISearchDisplayDelegate, MKMapViewDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@end

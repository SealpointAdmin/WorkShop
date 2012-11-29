//
//  ViewController.m
//  GoogleChallenge
//
//  Created by Vladimir Gogunsky on 10/26/12.
//  Copyright (c) 2012 Vladimir Gogunsky. All rights reserved.
//

#import "ViewController.h"
#import "GCPlaceDetail.h"
#import "ObjectCreator.h"

@interface ViewController ()
{
    NSMutableArray *placeItems;
    
}
- (void)showAllPinOnMap;
- (void)getDataFromServer;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mapView.showsUserLocation = YES;
    [self getDataFromServer];
}

- (void) success:(id)data {
    placeItems = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in [[data objectAtIndex:0] objectForKey:@"results"]) {
        GCPlaceDetail *place = [GCPlaceDetail placeFromSearchDictionary:dict];
        [placeItems addObject:place];
    }
}

- (void) error:(id)data {
    
}

- (void)getDataFromServer {
    
    [DATA_MANAGER setDefaultHostName:@"maps.googleapis.com"];
    [DATA_MANAGER setup];
    
    [DATA_MANAGER fetchDataWithTarget:self
                   completionCallback:@selector(success:)
                        errorCallback:@selector(error:)
                                  url:@"maps/api/place/textsearch/json"
                               params:(NSMutableDictionary *)@{@"query":@"restaurants+in+Sydney",@"sensor":@"true",@"key":@"AIzaSyCRgRvwdOGdy2DzBOGJVu4mAPO5ek-qcGs"}
                           httpMethod:@"GET"
                             useCache:FALSE
                  useLoadingIndicator:FALSE];
    

}

- (void)showAllPinOnMap {
    
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    static NSString *identifier = @"MyLocation";

        
        MKAnnotationView *annotationView = (MKAnnotationView *) [_mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView == nil) {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
            annotationView.enabled = YES;
            annotationView.canShowCallout = YES;
           
        } else {
            annotationView.annotation = annotation;
        }
        
        return annotationView;
}


@end

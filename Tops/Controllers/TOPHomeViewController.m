//
//  TOPHomeViewController.m
//  Tops
//
//  Created by Никита Ярмолюк on 6/29/15.
//  Copyright (c) 2015 Nikita & Co. All rights reserved.
//

#import "TOPHomeViewController.h"
#import <MapKit/MapKit.h>
#import "NMRangeSlider.h"
#import <Parse/Parse.h>
#import "TOPSearchRangeTableViewController.h"
#import "TOPPlace.h"
#import "TOPPlaceDescriptionViewController.h"

#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define METERS_PER_MILE 1609.344

@interface TOPHomeViewController ()

@property (nonatomic) MKMapView *mapView;
@property (nonatomic) UIButton *searchDistance;
@property (nonatomic) UIButton *serviceType;
@property (nonatomic) UILabel *priceRange;
@property (nonatomic) NMRangeSlider *priceSlider;
@property (nonatomic) UIButton *findButton;
@property (nonatomic, copy) PFGeoPoint *userLocation;
@property (nonatomic) NSMutableArray *places;
@property (nonatomic, retain) CLLocationManager *locationManager;

@end

@implementation TOPHomeViewController

@synthesize mapView = _mapView;
@synthesize serviceType = _serviceType;
@synthesize searchDistance = _searchDistance;
@synthesize priceRange = _priceRange;
@synthesize priceSlider = _priceSlider;
@synthesize findButton = _findButton;
@synthesize userLocation = _userLocation;
@synthesize places = _places;
@synthesize locationManager = _locationManager;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //_mapView = [[MKMapView alloc] initWithFrame:self.view.frame];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    _places = [NSMutableArray new];
    
    _mapView = [MKMapView new];
    _mapView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:_mapView];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_mapView]-0-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(_mapView)]];
    
    _serviceType = [UIButton new];
    _serviceType.translatesAutoresizingMaskIntoConstraints = NO;
    _serviceType.backgroundColor = [UIColor clearColor];
    [_serviceType setTitle:@"Стрижка"
                  forState:UIControlStateNormal];
    [_serviceType setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //_serviceType.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    _serviceType.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    [self.view addSubview:_serviceType];
    
    _searchDistance = [UIButton new];
    _searchDistance.translatesAutoresizingMaskIntoConstraints = NO;
    _searchDistance.backgroundColor = [UIColor clearColor];
    [_searchDistance setTitle:@"3 км"
                  forState:UIControlStateNormal];
    [_searchDistance setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.view addSubview:_searchDistance];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_serviceType(245)]-10-[_searchDistance(40)]-10-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(_serviceType, _searchDistance)]];
    
    _priceRange = [UILabel new];
    _priceRange.translatesAutoresizingMaskIntoConstraints = NO;
    _priceRange.backgroundColor = [UIColor clearColor];
    _priceRange.text = [NSString stringWithFormat:@"500 - 15000 KZT"];
    _priceRange.textColor = [UIColor whiteColor];
    
    [self.view addSubview:_priceRange];
    
    _priceSlider = [NMRangeSlider new];
    _priceSlider.translatesAutoresizingMaskIntoConstraints = NO;
    _priceSlider.backgroundColor = [UIColor clearColor];

    [self.view addSubview:_priceSlider];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_priceRange(150)]-5-[_priceSlider(140)]-10-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(_priceRange, _priceSlider)]];
    _findButton = [UIButton new];
    _findButton.translatesAutoresizingMaskIntoConstraints = NO;
    _findButton.backgroundColor = [UIColor blueColor];
    [_findButton setTitle:@"Найти"
                  forState:UIControlStateNormal];
    [_findButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.view addSubview:_findButton];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-110-[_findButton(100)]-110-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(_findButton)]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_mapView]-20-[_serviceType(20)]-20-[_priceRange(20)]-15-[_findButton(20)]-10-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(_mapView, _serviceType, _priceRange, _findButton)]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_mapView]-20-[_searchDistance(20)]-20-[_priceSlider(20)]-15-[_findButton(20)]-10-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(_mapView, _searchDistance, _priceSlider, _findButton)]];
    
    
    [self configureLabelSlider];
    [self updateSliderLabels];
    [self configureMetalThemeForSlider:_priceSlider];
    [_priceSlider addTarget:self action:@selector(labelSliderChanged:) forControlEvents:UIControlEventValueChanged];

    
    __weak TOPHomeViewController *safeSelf = self;
    
    [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geoPoint, NSError *error) {
        if (!error) {
            safeSelf.userLocation = geoPoint;
            PFQuery *query = [PFQuery queryWithClassName:@"Services"];
            [query whereKey:@"location" nearGeoPoint:geoPoint withinKilometers:1];
            query.limit = 1000;
            NSLog(@"location catched");
            
            
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *qerror){
                [safeSelf.mapView addAnnotations:objects];
            }];
            
            
        }
        else{
            NSLog(@"Error");
        }
    }];
    
    _mapView.delegate = self;
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
#ifdef __IPHONE_8_0
    if(IS_OS_8_OR_LATER) {
        // Use one or the other, not both. Depending on what you put in info.plist
        [self.locationManager requestWhenInUseAuthorization];
        [self.locationManager requestAlwaysAuthorization];
    }
#endif
    [self.locationManager startUpdatingLocation];
    
    _mapView.showsUserLocation = YES;
    [_mapView setMapType:MKMapTypeStandard];
    [_mapView setZoomEnabled:YES];
    [_mapView setScrollEnabled:YES];

    [_searchDistance addTarget:self action:@selector(searchByDistance:) forControlEvents:UIControlEventTouchUpInside];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receivetNotification:)
                                                 name:@"RefreshDataWithFilters"
                                               object:nil];
    
}

#pragma - mark MKMapView Delegate

- (void) mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    NSLog(@"%s", __FUNCTION__);
    
    TOPPlace *place = (TOPPlace *) view.annotation;
    
    TOPPlaceDescriptionViewController *placeDescriptionController = [TOPPlaceDescriptionViewController new];
    placeDescriptionController.place = place;
    
    
    [self presentViewController:placeDescriptionController
                       animated:YES
                     completion:nil];
    
    
}
- (void) mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
    NSLog(@"%s", __FUNCTION__);
}

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>) annotation
{
    MKPinAnnotationView *newAnnotation = [[MKPinAnnotationView alloc]     initWithAnnotation:annotation reuseIdentifier:@"pinLocation"];
    
    newAnnotation.canShowCallout = YES;
    newAnnotation.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    
    return newAnnotation;
}

- (void) receivetNotification:(NSNotification *) notification
{
    if ([[notification name] isEqualToString:@"RefreshDataWithFilters"]){
        NSLog (@"Successfully received the test notification!");
        //NSString *temp = ([[notification userInfo] objectForKey:@"rangeFilter"]);
        
        [_searchDistance setTitle:@"313 км"
                         forState:UIControlStateNormal];
    }
}

-(IBAction)searchByDistance:(id)sender{
    [self presentViewController:[TOPSearchRangeTableViewController new]
                       animated:YES
                     completion:nil];
    NSLog(@"Successfully came to distance choose");
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager startUpdatingLocation];
    //NSLog(@"%@", [self deviceLocation]);
    
    //View Area
    MKCoordinateRegion region = { { 0.0, 0.0 }, { 0.0, 0.0 } };
    region.center.latitude = self.locationManager.location.coordinate.latitude;
    region.center.longitude = self.locationManager.location.coordinate.longitude;
    region.span.longitudeDelta = 0.005f;
    region.span.latitudeDelta = 0.005f;
    [_mapView setRegion:region animated:YES];
    
    // Add an annotation
    CLLocationCoordinate2D location = _mapView.userLocation.coordinate;
    //PFGeoPoint *pointP = [PFGeoPoint geoPointWithLatitude:mapView.userLocation.coordinate.latitude longitude:mapView.userLocation.coordinate.longitude];
    
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = location;
    point.title = @"Where am I?";
    point.subtitle = @"I'm here!!!";
    
    [_mapView addAnnotation:point];
}

#pragma slider

- (void) configureLabelSlider {
    _priceSlider.minimumValue = 500;
    _priceSlider.maximumValue = 15000;
    
    _priceSlider.lowerValue = 500;
    _priceSlider.upperValue = 15000;
    
    _priceSlider.minimumRange = 0;
}

- (void) updateSliderLabels {
    _priceRange.text = [NSString stringWithFormat:@"%.f - %.f KZT", round((int)_priceSlider.lowerValue/100.0)*100.0, round((int)_priceSlider.upperValue/100.0)*100.0];
}

// Handle control value changed events just like a normal slider
- (IBAction)labelSliderChanged:(NMRangeSlider*)sender {
    [self updateSliderLabels];
}

#pragma mark - Metal Theme Slider

- (void) configureMetalThemeForSlider:(NMRangeSlider*) slider {
    UIImage* image = nil;
    
    image = [UIImage imageNamed:@"sliderBack.png"];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 5.0, 0.0, 5.0)];
    slider.trackBackgroundImage = image;
    
    image = [UIImage imageNamed:@"sliderDef.png"];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 7.0, 0.0, 7.0)];
    slider.trackImage = image;
    
    image = [UIImage imageNamed:@"sliderCircle.png"];
    image = [image imageWithAlignmentRectInsets:UIEdgeInsetsMake(-1, 2, 1, 2)];
    slider.lowerHandleImageNormal = image;
    slider.upperHandleImageNormal = image;
    
}

// ------------------------------------------------------------------------------------------------------

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

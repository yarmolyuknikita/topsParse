//
//  TOPPlaceDescriptionViewController.m
//  Tops
//
//  Created by Никита Ярмолюк on 7/15/15.
//  Copyright (c) 2015 Nikita. All rights reserved.
//

#import "TOPPlaceDescriptionViewController.h"

@interface TOPPlaceDescriptionViewController ()

@property (nonatomic) UILabel *placeName;
@property (nonatomic) UIImageView *placeImage;
@property (nonatomic) UILabel *placeIsAvailable;
@property (nonatomic) UILabel *placeAddress;

@end

@implementation TOPPlaceDescriptionViewController

@synthesize placeName = _placeName;
@synthesize placeImage = _placeImage;
@synthesize placeIsAvailable = _placeIsAvailable;
@synthesize placeAddress =_placeAddress;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    _placeName = [UILabel new];
    _placeName.translatesAutoresizingMaskIntoConstraints = NO;
    _placeName.text = _place.name;
    _placeName.textAlignment = NSTextAlignmentCenter;
    _placeName.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_placeName];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-100-[_placeName]-100-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(_placeName)]];
    
    _placeImage = [UIImageView new];
    _placeImage.translatesAutoresizingMaskIntoConstraints = NO;
    _placeImage.image = [UIImage imageWithContentsOfFile:[_place.photos objectAtIndex:0]];
    [self.view addSubview:_placeImage];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_placeImage]-0-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(_placeImage)]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_placeImage(180)]-20-[_placeName]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(_placeImage, _placeName)]];
    

//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_mapView]-20-[_searchDistance(20)]-20-[_priceSlider(20)]-15-[_findButton(20)]-10-|"
//                                                                      options:0
//                                                                      metrics:nil
//                                                                        views:NSDictionaryOfVariableBindings(_mapView, _searchDistance, _priceSlider, _findButton)]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

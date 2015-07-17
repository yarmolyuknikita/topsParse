//
//  TOPPlaceDescriptionViewController.m
//  Tops
//
//  Created by Никита Ярмолюк on 7/15/15.
//  Copyright (c) 2015 Nikita. All rights reserved.
//

#import "TOPPlaceDescriptionViewController.h"
#import "TOPHomeViewController.h"

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
    UINavigationBar *navigationBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, 320, 65)];
    //do something like background color, title, etc you self
    UINavigationItem *item = [[UINavigationItem alloc] initWithTitle:_place.name];
    navigationBar.items = [NSArray arrayWithObject:item];
    navigationBar.topItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"<" style:UIBarButtonItemStyleDone target:self action:@selector(backButtonPressed)];
    [self.view addSubview:navigationBar];
    
    _placeName = [UILabel new];
    _placeName.translatesAutoresizingMaskIntoConstraints = NO;
    _placeName.text = _place.category;
    _placeName.textAlignment = NSTextAlignmentCenter;
    _placeName.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_placeName];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_placeName]-0-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(_placeName)]];
    
    _placeImage = [UIImageView new];
    _placeImage.translatesAutoresizingMaskIntoConstraints = NO;
    if(_place.photos.count > 0){
        _placeImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[_place.photos objectAtIndex:0]
                                                                              ]]];
    }
    else{
        _placeImage.backgroundColor = [UIColor grayColor];
    }
    [self.view addSubview:_placeImage];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_placeImage]-0-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(_placeImage)]];
    
    _placeIsAvailable = [UILabel new];
    _placeIsAvailable.translatesAutoresizingMaskIntoConstraints = NO;
    if(!_place.available){
        _placeIsAvailable.text = [NSString stringWithFormat:@"Извините но в даный момент нет свободных мастеров"];
    }
    else{
        _placeIsAvailable.text = [NSString stringWithFormat:@"Есть сободные мастера в данный момент"];
    }
    _placeIsAvailable.textAlignment = NSTextAlignmentCenter;
    _placeIsAvailable.lineBreakMode = NSLineBreakByWordWrapping;
    _placeIsAvailable.numberOfLines = 2;
    [self.view addSubview:_placeIsAvailable];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_placeIsAvailable]-0-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(_placeIsAvailable)]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-65-[_placeImage(180)]-20-[_placeName(20)]-20-[_placeIsAvailable(50)]"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(_placeImage, _placeName,_placeIsAvailable)]];
    

//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_mapView]-20-[_searchDistance(20)]-20-[_priceSlider(20)]-15-[_findButton(20)]-10-|"
//                                                                      options:0
//                                                                      metrics:nil
//                                                                        views:NSDictionaryOfVariableBindings(_mapView, _searchDistance, _priceSlider, _findButton)]];
    
}

-(void)backButtonPressed{
    [self presentViewController:[TOPHomeViewController new]
                       animated:YES
                     completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

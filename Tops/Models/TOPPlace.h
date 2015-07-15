//
//  TOPPlace.h
//  Tops
//
//  Created by Никита Ярмолюк on 7/15/15.
//  Copyright (c) 2015 Nikita. All rights reserved.
//

#import <Parse/Parse.h>
#import <MapKit/MapKit.h>

@interface TOPPlace : PFObject <PFSubclassing, MKAnnotation>

@property (nonatomic) NSString *address;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *category;
@property (nonatomic) NSString *time;

@property (nonatomic) NSArray *phones;
@property (nonatomic) NSArray *photos;
@property (nonatomic) NSString *logo;
@property (nonatomic) NSNumber *rating;
@property (nonatomic) PFGeoPoint *location;
@property (nonatomic) BOOL available;

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, readonly, copy) NSString *title;
@property (nonatomic, readonly, copy) NSString *subtitle;

+ (NSString *) parseClassName;

@end

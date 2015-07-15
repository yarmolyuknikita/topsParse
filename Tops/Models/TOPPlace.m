//
//  TOPPlace.m
//  Tops
//
//  Created by Никита Ярмолюк on 7/15/15.
//  Copyright (c) 2015 Nikita. All rights reserved.
//

#import "TOPPlace.h"

static NSString *kTOPPlaceClassName = @"Services";

@implementation TOPPlace

@dynamic name;
@dynamic location;
@dynamic address;
@dynamic time;
@dynamic phones;
@dynamic photos;
@dynamic rating;
@dynamic logo;
@dynamic available;
@dynamic category;

@synthesize coordinate = _coordinate;
@synthesize title = _title;
@synthesize subtitle = _subtitle;

+ (void) load{
    [self registerSubclass];
}

+ (NSString *) parseClassName{
    return kTOPPlaceClassName;
}

- (NSString *) title{
    _title = self.name;
    return _title;
}

- (NSString *) subtitle{
    _subtitle = self.category;
    return _subtitle;
}

- (CLLocationCoordinate2D) coordinate{
    _coordinate = CLLocationCoordinate2DMake(self.location.latitude, self.location.longitude);
    return _coordinate;
}


@end

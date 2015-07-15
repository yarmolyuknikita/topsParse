//
//  TOPTextFieldTableViewCell.m
//  Tops
//
//  Created by Никита Ярмолюк on 7/4/15.
//  Copyright (c) 2015 Nikita. All rights reserved.
//

#import "TOPTextFieldTableViewCell.h"

@implementation TOPTextFieldTableViewCell
@synthesize textField = _textField;

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self){
        _textField = [UITextField new];
        _textField.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self.contentView addSubview:_textField];
    }
    
    return self;
}

- (void) layoutSubviews{
    [super layoutSubviews];
    
    
}
@end

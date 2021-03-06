//
//  PKGeometryPaster.m
//  Sketch
//
//  Created by    on 12-3-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PKGeometryPaster.h"

@implementation PKGeometryPaster

@synthesize geoPasterImageView;
@synthesize geoPasterColor;
@synthesize geoPasterType;
@synthesize isModified;

//-(id)initWithGeometryPasterTemplate:(PKGeometryPasterTemplate *)geometryPasterTemplate Color:(UIColor *)color {
//    self = [super init];
//    if (self && color) 
//    {
//        geoPasterImageView = [[PKGeometryImageView alloc]initWithImage:geometryPasterTemplate.geoTemplateImageView.image];
//        self.geoPasterColor = color;
//        self.geoPasterType  = geometryPasterTemplate.geoTemplateType;
//    } 
//    return self;
//}
//
-(id)initWithGeometryImageView:(PKGeometryImageView *)imageView {
    self = [super init];
    if(self && imageView)
    {
        self.geoPasterImageView = imageView;
    }
    return self;
}

-(id)initWithGeometryPasterTemplate:(PKGeometryPasterTemplate *)geometryPasterTemplate {
    self = [super init];
    if (self) {
        self.geoPasterImageView = [[[PKGeometryImageView alloc] initWithImage:[geometryPasterTemplate.geoTemplateImageView image]] autorelease];
        self.geoPasterImageView.frame = geometryPasterTemplate.geoTemplateImageView.frame;
        self.geoPasterType = geometryPasterTemplate.geoTemplateType;
        self.geoPasterColor = geometryPasterTemplate.geoTemplateColor;
    }
    return self;
}


//使用NSCoder对几何贴纸进行归档
-(id)initWithCoder:(NSCoder *)aDecoder 
{
    if (self = [super init]) 
    {
        self.geoPasterImageView = [aDecoder decodeObjectForKey:@"geoPasterImageView"];
        self.geoPasterColor = [aDecoder decodeObjectForKey:@"geoPasterColor"];
        self.geoPasterType = [aDecoder decodeIntForKey:@"geoPasterType"];
        self.isModified = [aDecoder decodeBoolForKey:@"isModified"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder 
{
    [aCoder encodeObject:geoPasterImageView forKey:@"geoPasterImageView"];
    [aCoder encodeObject:geoPasterColor forKey:@"geoPasterColor"];
    [aCoder encodeInt:geoPasterType forKey:@"geoPasterType"];
    [aCoder encodeBool:isModified forKey:@"isModified"];
}

-(id)copyWithZone:(NSZone *)zone {
    PKGeometryPaster *copy = [[PKGeometryPaster allocWithZone:zone] init];
    copy.geoPasterImageView = [self.geoPasterImageView deepCopy];
    copy.geoPasterColor = [self.geoPasterColor deepCopy];
    copy.geoPasterType = self.geoPasterType;
    copy.isModified = self.isModified;
    return copy;
}

@end

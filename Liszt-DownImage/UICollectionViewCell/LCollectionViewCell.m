//
//  LCollectionViewCell.m
//  Liszt-DownImage
//
//  Created by Liszt on 16/11/17.
//  Copyright © 2016年 https://github.com/LisztGitHub. All rights reserved.
//

#import "LCollectionViewCell.h"
#import "LisztNetworking.h"

@implementation LCollectionViewCell

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        self.layer.cornerRadius = 6;
        self.clipsToBounds = YES;
        
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)]];
    }
    return self;
}

- (void)tap:(id)sender {
    [LisztNetworking downImageUrl:self.url downProgress:^(float progress) {
        self.progressView.progress = progress;
        NSLog(@"progress:%.2f",progress);
    } success:^(id result) {
        NSLog(@"path:%@",result);
        self.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL fileURLWithPath:result]]];
    }];
}


@end

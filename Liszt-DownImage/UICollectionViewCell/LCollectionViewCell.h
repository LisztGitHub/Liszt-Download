//
//  LCollectionViewCell.h
//  Liszt-DownImage
//
//  Created by Liszt on 16/11/17.
//  Copyright © 2016年 https://github.com/LisztGitHub. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (copy, nonatomic) NSString *url;
@end

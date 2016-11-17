//
//  ViewController.m
//  Liszt-DownImage
//
//  Created by Liszt on 16/11/17.
//  Copyright © 2016年 https://github.com/LisztGitHub. All rights reserved.
//

#import "ViewController.h"
#import "LCollectionViewCell.h"
#import "LisztNetworking.h"

#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr, "%s:%zd\t%s\n", [[[NSString stringWithUTF8String: __FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat: FORMAT, ## __VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong, nonatomic) UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIProgressView *progressBar;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.view addSubview:self.collectionView];
}

- (IBAction)buttonAction:(UIBarButtonItem *)sender {
    [LisztNetworking downImageUrl:@"http://baobab.wdjcdn.com/1455782903700jy.mp4" downProgress:^(float progress) {
        NSLog(@"pro:%.2f",progress);
        self.progressBar.progress = progress;
    } success:^(id result) {
        [[[UIAlertView alloc]initWithTitle:@"mp4下载成功!" message:nil delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil] show];
    }];
}

- (NSArray *)dataLists{
    NSString *url1 = @"http://sjbz.fd.zol-img.com.cn/t_s320x510c/g5/M00/07/0D/ChMkJlgaonSIRhzuAAmyr_8dUHwAAXccQOjkM0ACbLH277.jpg";
    NSString *url2 = @"http://sjbz.fd.zol-img.com.cn/t_s320x510c/g5/M00/07/0D/ChMkJlgaonSIFMMaAAcbXUeBpU8AAXccQO0mZoABxt1531.jpg";
    NSString *url3 = @"http://sjbz.fd.zol-img.com.cn/t_s320x510c/g5/M00/07/0D/ChMkJ1gaonSIJ4hgAAYfjrqpC-AAAXccQO7tQ8ABh-m745.jpg";
    NSString *url4 = @"http://sjbz.fd.zol-img.com.cn/t_s320x510c/g5/M00/07/0D/ChMkJ1gaonSIdKrgAAtvbtzEm2oAAXccQPB1LUAC2-G928.jpg";
    NSString *url5 = @"http://sjbz.fd.zol-img.com.cn/t_s320x510c/g5/M00/07/0D/ChMkJ1gaonWIY2TBAAiyHrS5i9UAAXccQPNRDsACLI2227.jpg";
    NSString *url6 = @"http://sjbz.fd.zol-img.com.cn/t_s320x510c/g5/M00/00/03/ChMkJ1fJV12IGWoNAASSdmxar8EAAU-DQPUrRcABJKO457.jpg";
    NSString *url7 = @"http://sjbz.fd.zol-img.com.cn/t_s320x510c/g5/M00/00/03/ChMkJ1fJV16IfVpZAAvsBmUG2ZcAAU-DgBJ5SYAC-we167.jpg";
    NSString *url8 = @"http://sjbz.fd.zol-img.com.cn/t_s320x510c/g5/M00/00/03/ChMkJ1fJV16IWhpdAAqgwxQ-ZVMAAU-DgArMq0ACqDb154.jpg";
    NSString *url9 = @"http://sjbz.fd.zol-img.com.cn/t_s320x510c/g5/M00/00/03/ChMkJ1fJV16IHkUkABJQzT_hdu4AAU-DgAY4cgAElDl287.jpg";
    return @[url1,url2,url3,url4,url5,url6,url7,url8,url9];
}

#pragma mark - 懒加载
- (UICollectionView *)collectionView{
    if(!_collectionView){
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        layout.itemSize = CGSizeMake((CGRectGetWidth(self.view.frame) - 30) / 3, (CGRectGetWidth(self.view.frame) - 15) / 3 + 30);
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 10, self.view.bounds.size.width, self.view.bounds.size.height - 10) collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [_collectionView registerNib:[UINib nibWithNibName:@"LCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"Liszt_lz@163.com"];
    }
    return _collectionView;
}

#pragma mark - <UICollectionViewDelegate,UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataLists.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LCollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"Liszt_lz@163.com" forIndexPath:indexPath];
    cell.url = self.dataLists[indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

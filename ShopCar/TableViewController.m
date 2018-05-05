//
//  TableViewController.m
//  ShopCar
//
//  Created by songfei on 2018/5/5.
//  Copyright © 2018年 songfei. All rights reserved.
//

#import "TableViewController.h"
#import "SuspensionBtn.h"
@interface TableViewController ()
@property (nonatomic ,strong) SuspensionBtn *suspensionBtn;
@end

@implementation TableViewController{
    NSInteger proNub;
}
- (SuspensionBtn *)suspensionBtn{
    if (!_suspensionBtn) {
        _suspensionBtn = [[SuspensionBtn alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 80, [UIScreen mainScreen].bounds.size.height - 200, 60, 60)];
        [_suspensionBtn setImage:[UIImage imageNamed:@"shopCar"] forState:UIControlStateNormal];
        [_suspensionBtn setBackgroundColor:[UIColor grayColor]];
        _suspensionBtn.alpha = 0.7;
        
    }
    return _suspensionBtn;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    proNub = 0;
    [self.view addSubview:self.suspensionBtn];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CGRect cellFrame = [SuspensionBtn getCellFrameWithIndexPath:indexPath tableView:self.tableView relativeView:self.view];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UIImageView* imageView = cell.contentView.subviews.firstObject;
    
    CGRect startFrame = CGRectMake(cellFrame.origin.x, cellFrame.origin.y, imageView.frame.size.width, imageView.frame.size.height);
    
    __weak typeof (self)weakSelf = self;
    proNub = proNub + 1;
    [SuspensionBtn animationWithImage:imageView.image startFrame:startFrame endFrame:self.suspensionBtn.frame completion:^(BOOL completion) {
        [weakSelf.suspensionBtn setNub:self->proNub];
    }];
}


@end

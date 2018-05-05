//
//  ViewController.m
//  ShopCar
//
//  Created by songfei on 2018/5/5.
//  Copyright © 2018年 songfei. All rights reserved.
//

#import "ViewController.h"

#import "TableViewController.h"
@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)click:(id)sender {
    UIStoryboard *board = [UIStoryboard storyboardWithName: @"Main" bundle: nil];

    TableViewController *vc =  [board instantiateViewControllerWithIdentifier: @"TableViewController"];
    
    [self presentViewController:vc animated:true completion:nil];
}


@end

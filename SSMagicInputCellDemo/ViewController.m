//
//  ViewController.m
//  SSMagicInputCellDemo
//
//  Created by RockXeng on 2018/8/29.
//  Copyright © 2018年 ShuSheng. All rights reserved.
//

#import "ViewController.h"
#import "SSMagicInputCell.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, SSMagicInputCellDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"InputCellDemo";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerClass:[SSMagicInputCell class] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:self.tableView];
}

- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
        
        [self.dataArray addObject:[[NSMutableDictionary alloc] initWithDictionary:@{@"left":@"企业名称：",@"right":@"",@"placeHolder": @"请输入企业名称",@"maxLength":@"0"}]];
        [self.dataArray addObject:[[NSMutableDictionary alloc] initWithDictionary:@{@"left":@"联系电话：",@"right":@"",@"placeHolder":@"请输入联系电话",@"maxLength":@"20"}]];
        
        [self.dataArray addObject:[[NSMutableDictionary alloc] initWithDictionary:@{@"left":@"企业地址：",@"right":@"",@"placeHolder":@"请输入企业地址",@"maxLength":@"0"}]];
    }
    
    return _dataArray;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SSMagicInputCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.delegate = self;
    NSDictionary *cellModel = self.dataArray[indexPath.row];
    
    [cell updateCellWithLeft:cellModel[@"left"] right:cellModel[@"right"] placeholder:cellModel[@"placeHolder"] maxLength:[cellModel[@"maxLength"] integerValue]];
    
    return cell;
}

#pragma mark - BDInputViewCellDelegate
- (void)ss_textViewDidChange:(SSTextView *)textView {
    
}

- (void)ss_textViewCell:(SSMagicInputCell *)cell textHeightChange:(NSString *)text {
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
}

@end

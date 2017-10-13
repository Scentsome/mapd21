//
//  ViewController.m
//  CollectionViewDemo
//
//  Created by Michael on 13/10/2017.
//  Copyright © 2017 Zencher. All rights reserved.
//

#import "ViewController.h"
#import "CellItem.h"
@interface ViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ViewController{
    NSMutableArray * items ;
}

- (IBAction)remove:(id)sender {
    [items removeLastObject];
    [self.collectionView reloadData];
//    [self.collectionView reloadSections:<#(nonnull NSIndexSet *)#>];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    items = [@[] mutableCopy ];
    
    for(NSInteger index = 0 ; index < 20 ; index++){
        CellItem * item = [CellItem new];
        item.name = [NSString stringWithFormat:@"%ld",(long)index];
        item.selected = NO;
        
        [items addObject:item];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionCell" forIndexPath:indexPath];
    
    
    
    UILabel * label = [cell viewWithTag:11];
    label.text = [NSString stringWithFormat:@"%@",[ items[indexPath.row] name]];
    if([items[indexPath.item] selected]){
        cell.backgroundColor = UIColor.greenColor;
    }else{
        cell.backgroundColor = UIColor.yellowColor;
    }
    
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return items.count ;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@",indexPath);
    
    UICollectionViewCell * selectedCell = [collectionView cellForItemAtIndexPath:indexPath];
    
    selectedCell.backgroundColor = UIColor.greenColor;
    
    [items[indexPath.row] setSelected:YES];
}
- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(20, 20, 20, 20);
}


@end

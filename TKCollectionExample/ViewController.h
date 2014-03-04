//
//  ViewController.h
//  TKCollectionExample
//
//  Created by Toseefhusen on 04/03/14.
//  Copyright (c) 2014 Toseef Khilji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKCollectionView.h"
#import "AsyncImageView.h"
@interface ViewController : UIViewController<TKCollectionViewDataSource,TKCollectionViewDelegate,UIScrollViewDelegate,AsyncImageViewDelegate>

@end

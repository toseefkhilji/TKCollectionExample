TKCollectionExample
===================

TKCollectionExample is a dynamic CollectionView , It's a Pinterest style scroll view designed to be used similar to a UITableView.


![logo](http://i.imgur.com/3sqnJkc.png)

## Requirements ##

1) Xcode 5 and above versions.
2) ARC


## Usage ##

Here's an example of creating an instance of PSCollectionView

    self.collectionView = [[TKCollectionView alloc] initWithFrame:CGRectZero];
    self.collectionView.delegate = self; // This is for UIScrollViewDelegate
    self.collectionView.collectionViewDelegate = self;
    self.collectionView.collectionViewDataSource = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.autoresizingMask = ~UIViewAutoresizingNone;

**Setting number of columns**

    // Specify number of columns for both iPhone and iPad
    
        self.collectionView.numColsPortrait = 3;
        self.collectionView.numColsLandscape = 4;
   

**Add a header view**

    UIView *headerView = ...
    self.collectionView.headerView = headerView;

**Add a footer view**

    UIView *footerView = ...
    self.collectionView.footerView = footerView;
    
**Reloading Data**
    [self.collectionView reloadData];

**Delegate and DataSource**

    - (Class)collectionView:(TKCollectionView *)collectionView cellClassForRowAtIndex:(NSInteger)index {
        return [TKCollectionViewCell class];
    }

    - (NSInteger)numberOfRowsInCollectionView:(TKCollectionView *)collectionView {
        return 0;
    }

    - (UIView *)collectionView:(TKCollectionView *)collectionView cellForRowAtIndex:(NSInteger)index {
        return nil;
    }

    - (CGFloat)collectionView:(TKCollectionView *)collectionView heightForRowAtIndex:(NSInteger)index {
        return 0.0;
    }

License
---
TKCollectionExample is available under the MIT license. See the LICENSE file for more info.

//
//  ViewController.m
//  PSCollectionExample
//
//  Created by Toseefhusen on 04/03/14.
//  Copyright (c) 2014 Toseef Khilji. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()
{
    NSMutableArray *arrayData;
    TKCollectionView *psView;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    arrayData=[self loadImagesUrl:[NSURL URLWithString:@"http://itunes.apple.com/search?term=bob&country=us&entity=movie"]];
    psView=[[TKCollectionView alloc]initWithFrame:self.view.bounds];
    psView.delegate = self; // This is for UIScrollViewDelegate
    psView.collectionViewDelegate = self;
    psView.collectionViewDataSource = self;
    psView.backgroundColor = [UIColor clearColor];
    psView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:psView];
    psView.numColsPortrait=3;
    psView.numColsLandscape=5;
    
    
    
}

-(NSInteger)numberOfRowsInCollectionView:(TKCollectionView *)collectionView{
    return arrayData.count;
}

- (Class)collectionView:(TKCollectionView *)collectionView cellClassForRowAtIndex:(NSInteger)index {
    return [AsyncImageView class];
}
- (AsyncImageView *)collectionView:(TKCollectionView *)collectionView cellForRowAtIndex:(NSInteger)index {
    
    AsyncImageView *cell = (AsyncImageView *)[psView dequeueReusableViewForClass:[AsyncImageView class]];
    if (!cell) {
        cell = [[AsyncImageView alloc]initWithFrame:CGRectMake(0, 0, 100 , 100)];
        [cell loadImageFromURL:arrayData[index]];
        //  cell.delegate=self;
        [cell setBackgroundColor:[UIColor grayColor]];
    }
    return cell;
}

- (CGFloat)collectionView:(TKCollectionView *)collectionView heightForRowAtIndex:(NSInteger)index {
    
    int r1=(arc4random() % 200);
    int r2= arc4random_uniform(200) ;
    
    NSLog(@"R1:%d  R2:%d",r1,r2);
    
    return r2+50;
}

-(void)collectionView:(TKCollectionView *)collectionView didSelectCell:(TKCollectionViewCell *)cell atIndex:(NSInteger)index{
    NSLog(@"i:%d",index);
}
-(NSMutableArray *)loadImagesUrl:(NSURL*)url{
    NSError *error;
    NSMutableArray *ary=[NSMutableArray array];
    NSURLRequest *rq=[NSURLRequest requestWithURL: url];
    NSData *response = [NSURLConnection sendSynchronousRequest:rq returningResponse:nil error:&error];
    NSDictionary *dict= [NSJSONSerialization JSONObjectWithData:response  options:NSJSONReadingMutableContainers error:nil];
    for (NSDictionary *dicts in [dict objectForKey:@"results"]){
        [ary addObject:[NSURL URLWithString:[dicts objectForKey:@"artworkUrl100"]]];
    }
    return ary;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

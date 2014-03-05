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
- (UIView *)collectionView:(TKCollectionView *)collectionView cellForRowAtIndex:(NSInteger)index {
    
    UIView *cell = (UIView *)[psView dequeueReusableViewForClass:[UIView class]];
    if (!cell) {
        cell=[[UIView alloc]init];
        //cell.translatesAutoresizingMaskIntoConstraints=NO;
        AsyncImageView *image = [[AsyncImageView alloc]initWithFrame:CGRectMake(0, 0, 60 , 60)];
        [image loadImageFromURL:arrayData[index]];
        //  cell.delegate=self;
        image.translatesAutoresizingMaskIntoConstraints=NO;
        
        UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 62, 40)];
        lbl.text=@"The UIView class defines a rectangular area on the screen and the interfaces for managing the content in that area. At runtime, a view object handles the rendering of any content in its area and also handles any interactions with that content. The UIView class itself provides basic behavior for filling its rectangular area with a background color.";
        lbl.backgroundColor=[UIColor clearColor];
        lbl.font=[UIFont systemFontOfSize:12];
        lbl.numberOfLines=0;
        lbl.textColor=[UIColor whiteColor];
        lbl.backgroundColor=[UIColor colorWithRed:20/255.0 green:20/255.0 blue:20/255.0 alpha:0.50];
        [cell setBackgroundColor:[UIColor grayColor]];
        
        lbl.translatesAutoresizingMaskIntoConstraints=NO;
        
        [cell addSubview:image];
        [cell addSubview:lbl];
        
        
        NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(image,lbl);
        NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[image]-5-|" options:0 metrics:nil views:viewsDictionary];
        [cell addConstraints:constraints];
        constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[lbl]-5-|" options:0 metrics:nil views:viewsDictionary];
        [cell addConstraints:constraints];
        
        constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[image]-5-|"
                                                              options: NSLayoutFormatAlignAllRight
                                                              metrics:nil
                                                                views:viewsDictionary];
        [cell addConstraints:constraints];
        constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[lbl(30)]|"
                                                              options: NSLayoutFormatAlignAllRight
                                                              metrics:nil
                                                                views:viewsDictionary];
        [cell addConstraints:constraints];
        
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

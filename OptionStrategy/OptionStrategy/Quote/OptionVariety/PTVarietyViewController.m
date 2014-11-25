//
//  PTVarietyViewController.m
//  OptionStrategy
//
//  Created by user01 on 11/25/14.
//  Copyright (c) 2014年 Polaris Technology. All rights reserved.
//

#import "PTVarietyViewController.h"
#import "PTVarietyTableViewCell.h"
#import "ColorConstant.h"
#import "PTStrategyService.h"
#import "VarietyViewModel.h"

@interface PTVarietyViewController ()

@property (weak, nonatomic) IBOutlet UITableView *varietyTableView;
@property NSArray *varieties ;  //[VarietyInfoViewModel]?
@property UIRefreshControl *refreshControl ;

@end

@implementation PTVarietyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.varietyTableView.delegate = self;
    self.varietyTableView.dataSource = self;
    NSArray *array = [PTStrategyService getOptionInstruments:@"SR"];
    // refresh control
    if(_refreshControl == nil) {
        _refreshControl = [[UIRefreshControl alloc] init];
        [_refreshControl addTarget:self  action: @selector(reloadData:) forControlEvents: UIControlEventValueChanged];
        [self.varietyTableView addSubview:_refreshControl];
    }
    [_refreshControl beginRefreshing];
    self.varietyTableView.contentOffset = CGPointMake(0, -_refreshControl.frame.size.height);
    [_refreshControl sendActionsForControlEvents:UIControlEventValueChanged];  // star
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// MARK: - Table view data source

-(int) numberOfSectionsInTableView:(UITableView*)tableView {
    // #warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

-(int) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // #warning Incomplete method implementation.
    // Return the number of rows in the section.
    
    return [_varieties count];
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PTVarietyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VarietyCell" forIndexPath: indexPath];
    
    // Configure the cell...
    VarietyViewModel *model = [_varieties objectAtIndex:indexPath.row];
    
    cell.varietyCodeLabel.text = model.Code;
    cell.varietyNameLabel.text = model.Name;
//    cell.exchangeNameLabel.text = [model ExchangeName];
//    
//    NSString *code = model.ExchangeCode;
//    cell.varietyMainView.backgroundColor = [self getMainBackground:code];
//    cell.exchangeNameLabel.backgroundColor = [self getSlaveBackground:code];
    
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"showUpDown"]){
        // select a row.
//        AddOptionUpDownViewController *controller = segue.destinationViewController;
//        NSIndexPath *indexPath = [self.varietyTableView indexPathForCell:sender];
//        id variety = [_varieties objectAtIndex:indexPath.row];
//        controller.variety = variety;
    }
}


-(UIColor*) getMainBackground:(NSString*)code {
    
    if([code isEqualToString: @"CFFE"])
        return COLOR_CONSTANT.shared.EXCHANGE_CFFE_MAIN_BACKGROUND;
    else if([code isEqualToString: @"SFE"])
        return COLOR_CONSTANT.shared.EXCHANGE_SFE_MAIN_BACKGROUND;
    else if([code isEqualToString: @"DCE"])
        return COLOR_CONSTANT.shared.EXCHANGE_DCE_MAIN_BACKGROUND;
    else if([code isEqualToString: @"CZCE"])
        return COLOR_CONSTANT.shared.EXCHANGE_CZCE_MAIN_BACKGROUND;
    
    return COLOR_CONSTANT.shared.EXCHANGE_CFFE_MAIN_BACKGROUND;
}


-(UIColor*) getSlaveBackground:(NSString*)code {
    
    if([code isEqualToString: @"CFFE"])
        return COLOR_CONSTANT.shared.EXCHANGE_CFFE_SLAVE_BACKGROUND;
    else if([code isEqualToString: @"SFE"])
        return COLOR_CONSTANT.shared.EXCHANGE_SFE_SLAVE_BACKGROUND;
    else if([code isEqualToString: @"DCE"])
        return COLOR_CONSTANT.shared.EXCHANGE_DCE_SLAVE_BACKGROUND;
    else if([code isEqualToString: @"CZCE"])
        return COLOR_CONSTANT.shared.EXCHANGE_CZCE_SLAVE_BACKGROUND;
    
    return COLOR_CONSTANT.shared.EXCHANGE_CFFE_SLAVE_BACKGROUND;
}


// refresh control
-(void) reloadData:(id)sender {
    [self loadVarieties];
}

-(void) loadVarieties {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^(){
        //NSThread.sleepForTimeInterval(10)
        NSArray *array = [PTStrategyService getOptionVarieties];
        dispatch_async(dispatch_get_main_queue(), ^(){
            _varieties = array;
            [self.varietyTableView reloadData];
            
            [_refreshControl endRefreshing];
        });
    });
}

@end

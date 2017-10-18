//
//  ChannelListViewController.m
//  FireChat
//
//  Created by Michael on 18/10/2017.
//  Copyright © 2017 Zencher. All rights reserved.
//

#import "ChannelListViewController.h"
#import "ChatViewController.h"
@import FirebaseAuth;
@import FirebaseDatabase;


@interface ChannelListViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *addChannelTextField;
@property NSMutableArray<NSDictionary *> * channels;
@property (weak, nonatomic) IBOutlet UITableView *tableView;




@end

@implementation ChannelListViewController{
    FIRDatabaseReference * channelRef;
    FIRDatabaseHandle channelRefHandle;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.channels = [@[] mutableCopy];
    channelRef = [[[FIRDatabase database] reference] child:@"channels"];
    

}

-(void) viewWillAppear:(BOOL)animated{
    [self observeChannels];
}
- (IBAction)createChannel:(id)sender {
    
    NSString * inputName = self.addChannelTextField.text;
    
    if (![inputName isEqualToString:@""]) {
        
        FIRDatabaseReference * addChannelRef = [channelRef childByAutoId];
        NSDictionary * channelItem = [NSDictionary dictionaryWithObject:inputName forKey:@"name"];
        [addChannelRef setValue:channelItem];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.channels.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellID"];
        
        
    }
    
    NSDictionary * channel = self.channels[indexPath.row];
    cell.textLabel.text = channel[@"name"];
    return cell;
}

-(void) observeChannels {
    
    channelRefHandle =
    [channelRef observeEventType:FIRDataEventTypeChildAdded withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        NSDictionary * channelData = snapshot.value;
        NSLog(@"channelData = %@", channelData);
        NSString * mKey = snapshot.key;
        NSString * name = [channelData objectForKey:@"name"];
        
        if (name != nil) {
            if (![name isEqualToString:@""]) {
               
                [self.channels addObject:@{@"name":name,@"id":mKey}];
                [self.tableView reloadData];
            } else {
                NSLog(@"Error");
            }
        } else {
            NSLog(@"Error");
        }
    }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ChatViewController * chatVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ChatVC"];
    
    
    NSDictionary * channel = self.channels[indexPath.row];
    chatVC.channelRef = [channelRef child:channel[@"id"]];
    chatVC.senderDisplayName = channel[@"name"];
    
    [self.navigationController pushViewController:chatVC animated:YES];
    
}

@end

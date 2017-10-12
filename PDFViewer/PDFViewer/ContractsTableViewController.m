//
//  ContractsTableViewController.m
//  PDFViewer
//
//  Created by Michael on 12/10/2017.
//  Copyright © 2017 Zencher. All rights reserved.
//

#import "ContractsTableViewController.h"
#import "DocumentViewController.h"
@interface ContractsTableViewController ()
@property NSArray * documents;

@end

@implementation ContractsTableViewController


-(void) loadDocuments {
    NSError * error;
    
    self.documents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[self contractsDirectory] error:&error];
    if(error) {
        NSLog(@"%@",error);
    }
    NSLog(@"%@",self.documents);
    [self.tableView reloadData];
}

-(NSString *) contractsDirectory {
    
    NSURL * contractsURL = [[NSURL fileURLWithPath:NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,   NSUserDomainMask, YES)[0]] URLByAppendingPathComponent:@"contracts"];
    
    NSString * contractsPath = [NSString stringWithFormat:@"%@", contractsURL.path];
    NSLog(@"%@",contractsURL.path);
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:contractsPath]) {
        
        NSError * error;
        [[NSFileManager defaultManager] createDirectoryAtPath:contractsPath withIntermediateDirectories:YES attributes:nil error:&error];
        if(error) {
            NSLog(@"Creating dir error %@",error);
        }
    }
    return contractsPath;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDocuments];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.documents.count;
}


 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PDFCell" forIndexPath:indexPath];
 
     cell.textLabel.text = self.documents[indexPath.row];
 return cell;
 }


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"NewContractSegue"]) {
        DocumentViewController * vc = segue.destinationViewController;
        NSString * pdfPath = [[NSBundle mainBundle] pathForResource: @"contractTemplate" ofType: @"pdf"];
        vc.document = [[PDFDocument new] initWithURL:[NSURL fileURLWithPath:pdfPath]];
        vc.title = @"New Contract";
        vc.addAnnotations = YES;
        vc.delegate = self;
        
    }
    if ([segue.identifier isEqualToString:@"CurrentContractSegue"]) {
        DocumentViewController * vc = segue.destinationViewController;
        NSString * document = self.documents[[self.tableView indexPathForCell:(UITableViewCell *)sender].row];
        vc.addAnnotations = NO;
        vc.title = document;
        
        NSURL * url = [[NSURL fileURLWithPath:[self contractsDirectory]] URLByAppendingPathComponent:document];
        NSData * data = [NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@", url.path]];
        
        vc.document = [[PDFDocument alloc] initWithData:data];
        vc.delegate = self;
        
    }
}

@end

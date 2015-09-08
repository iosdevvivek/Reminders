//
//  ViewController.m
//  Reminders
//
//  Created by XCube Inc. on 08/09/15.
//  Copyright (c) 2015 XCube Inc. All rights reserved.
//

#import "ViewController.h"
#import "DSNewEntryVC.h"
#import "DBManager.h"


@interface ViewController ()
{
    NSInteger dataCount;
}
@property (nonatomic, strong) DBManager *dbManager;

@property (nonatomic, strong) NSArray *arrPeopleInfo;

@end

@implementation ViewController

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"sampledb.sql"];
    
    [self loadData];
    
    [self.navigationController setNavigationBarHidden:NO];
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)loadData{
    // Form the query.
    NSString *query = @"select * from peopleInfo";
    
    // Get the results.
    if (self.arrPeopleInfo != nil) {
        self.arrPeopleInfo = nil;
    }
    self.arrPeopleInfo = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    dataCount = self.arrPeopleInfo.count;
    
     NSLog(@" %@",self.arrPeopleInfo );
    
    
    // [[NSUserDefaults standardUserDefaults] setValue:dataArray forKey:USERDEFAULT];
    
    NSLog(@" %@",self.arrPeopleInfo);
    
}

- (void)insertNewObject:(id)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DSNewEntryVC *myVC = (DSNewEntryVC *)[storyboard instantiateViewControllerWithIdentifier:@"DSNewEntryVC"];
    
    [self.navigationController pushViewController:myVC animated:YES];
    
    [self insertQuery];
 }

-(void)insertQuery
{
    dataCount++;
   NSString  *query = [NSString stringWithFormat:@"insert into peopleInfo (peopleInfoID,name,email,password,age,SocialID,docnumber,emergencynumber,emergencytext,medicinename,puffname) VALUES (%ld,\"%@\",\"%@\",\"%@\",%ld,\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")", (long)dataCount,@"test",@"test",@"test",5,@"test",@"test",@"test",@"test",@"test",@"test"];
    
    // Execute the query.
    [self.dbManager executeQuery:query];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

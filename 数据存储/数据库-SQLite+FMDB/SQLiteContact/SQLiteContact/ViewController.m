//
//  ViewController.m
//  SQLiteContact
//
//  Created by Lucky on 15/9/1.
//  Copyright © 2015年 Lucky. All rights reserved.
//

#import "ViewController.h"
#import "Contact.h"
#import "ContactTool.h"

@interface ViewController ()<UISearchBarDelegate>

@property (nonatomic, strong) NSMutableArray *contacts;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStyleDone target:self action:@selector(addContact)];
    
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    self.navigationItem.titleView = searchBar;
    searchBar.delegate = self;
}

- (NSMutableArray *)contacts
{
    if (!_contacts) {
        _contacts = (NSMutableArray *)[ContactTool getAllContactsSuccess:^{
            
        } failure:^(NSError *error) {
            NSLog(@"%@", error);
        }];
        if (!_contacts) {
            _contacts = [NSMutableArray array];
        }
    }
    return _contacts;
}

- (void)addContact
{
    Contact *contact = [Contact contactWithName:[NSString stringWithFormat:@"%c%c%c%c%c", 'A' + arc4random() % 26, 'A' + arc4random() % 26, 'A' + arc4random() % 26, 'A' + arc4random() % 26, 'A' + arc4random() % 26] phone:[NSString stringWithFormat:@"%c%c%c%c%c%c%c%c", '0' + arc4random() % 10, '0' + arc4random() % 10, '0' + arc4random() % 10, '0' + arc4random() % 10, '0' + arc4random() % 10, '0' + arc4random() % 10, '0' + arc4random() % 10, '0' + arc4random() % 10]];
    
    NSIndexPath *path = [NSIndexPath indexPathForRow:self.contacts.count inSection:0];
    [self.contacts addObject:contact];
    [self.tableView insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationAutomatic];
    [ContactTool saveContact:contact success:^{
        
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (void)searchBar:(nonnull UISearchBar *)searchBar textDidChange:(nonnull NSString *)searchText
{
    self.contacts = (NSMutableArray *)[ContactTool getContactsWithString:searchText success:^{

    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
    
    [self.tableView reloadData];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.contacts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *CM = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CM];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CM];
    }
    
    Contact *contact = self.contacts[indexPath.row];
    
    cell.textLabel.text = contact.name;
    cell.detailTextLabel.text = contact.phone;
    
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

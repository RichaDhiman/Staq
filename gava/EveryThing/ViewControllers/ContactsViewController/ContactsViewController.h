//
//  ContactsViewController.h
//  gava
//
//  Created by RICHA on 10/19/15.
//  Copyright (c) 2015 Richa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Phonebook.h"
#import "UserContactsModal.h"
#import "ContactsTableCell.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import <MessageUI/MessageUI.h>
#import "UserProfile.h"
#import "ContactsHeaderView.h"
#import "AppDelegate.h"
#import "AlertView.h"
#import <Foundation/Foundation.h>
#import <CoreFoundation/CoreFoundation.h>

@interface ContactsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,MFMailComposeViewControllerDelegate,MFMessageComposeViewControllerDelegate,UIAlertViewDelegate,UITextFieldDelegate,UISearchBarDelegate>
@property (strong, nonatomic) IBOutlet UIButton *btn_back;

- (IBAction)btn_back_pressed:(id)sender;

@property (strong, nonatomic) IBOutlet UISearchBar *Search_contacts;
@property (strong, nonatomic) IBOutlet UIButton *btn_close;

- (IBAction)btn_close_pressed:(id)sender;

@property (strong, nonatomic) IBOutlet UITableView *tbl_contacts;
@property (strong, nonatomic) IBOutlet UIButton *btn_send;
- (IBAction)btn_send_pressed:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *lbl_noResults;
@property (strong, nonatomic) IBOutlet UILabel *lbl_addPeople;



@end

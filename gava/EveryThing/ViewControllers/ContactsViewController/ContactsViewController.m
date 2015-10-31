//
//  ContactsViewController.m
//  gava
//
//  Created by RICHA on 10/19/15.
//  Copyright (c) 2015 Richa. All rights reserved.
//

#import "ContactsViewController.h"
#import <AddressBookUI/AddressBookUI.h>
#import <Foundation/Foundation.h>
#import <CoreFoundation/CoreFoundation.h>
#import <AddressBook/AddressBook.h>


@interface ContactsViewController ()
@property(nonatomic,retain)NSMutableArray *ContactsArray;
@property(nonatomic,retain)NSMutableArray *FilteredContactsArray;
@property(nonatomic,retain)NSMutableArray *SelectedEmails;
@property(nonatomic,retain)NSMutableArray *SelectedPhoneNo;
@property(nonatomic)BOOL selectAll;
@property(nonatomic)NSInteger HeaderIndex;
@property(nonatomic,retain)AppDelegate *App;
@property(nonatomic,retain)NSMutableArray* is_selected;

@end

@implementation ContactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tbl_contacts.hidden=YES;
    self.lbl_addPeople.hidden=NO;
    self.btn_send.hidden=YES;
    
    self.lbl_noResults.hidden=YES;
    
    self.SelectedEmails =[[NSMutableArray alloc]init];
    self.SelectedPhoneNo=[[NSMutableArray alloc]init];
    self.is_selected=[[NSMutableArray alloc]init];
    
    [self.tbl_contacts setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
    AlertView *alert=[[AlertView alloc]init];
    
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusDenied ||
        ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusRestricted){
        //1
        NSLog(@"Denied");
        [alert showStaticAlertWithTitle:@"" AndMessage:@"Go to Settings app and allow Contacts access"];
    } else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized){
        //2
        NSLog(@"Authorized");
        [self GetContactsList];
            } else{
        //3
        NSLog(@"Not determined");
        ABAddressBookRequestAccessWithCompletion(ABAddressBookCreateWithOptions(NULL, nil), ^(bool granted, CFErrorRef error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (!granted){
                    //4
                    
                    [alert showStaticAlertWithTitle:@"" AndMessage:@"Go to Settings app and allow Contacts access"];
                                    }
                
                //5
                [self GetContactsList];
                });
        });
    }

    
   
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tbl_contacts setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self.Search_contacts setImage:[UIImage imageNamed:@"ic_search_white-1"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    [self.Search_contacts setImage:[UIImage imageNamed:@"ic_cross_white"] forSearchBarIcon:UISearchBarIconClear state:UIControlStateNormal];
    [self.Search_contacts setImage:[UIImage imageNamed:@"ic_cross_white"] forSearchBarIcon:UISearchBarIconClear state:UIControlStateSelected];

}

-(void)viewDidAppear:(BOOL)animated
{
//    self.SelectedEmails =[[NSMutableArray alloc]init];
//    self.SelectedPhoneNo=[[NSMutableArray alloc]init];
}


#pragma mark-TableView Delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    NSDictionary *dict=[[NSDictionary alloc]init];
    dict=[self.ContactsArray objectAtIndex:section];

    NSInteger rowCount;
    rowCount=[[dict valueForKey:@"email"] count]+[[dict valueForKey:@"phone"] count];
    
    return rowCount;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.SelectedEmails.count!=0||self.SelectedPhoneNo.count!=0) {
        [self.view resignFirstResponder];
        [self.view endEditing:YES];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContactsTableCell *cell=[tableView dequeueReusableCellWithIdentifier:@"ContactsTableCell" forIndexPath:indexPath];
   //////
    
    
    
    NSDictionary *dict=[[NSDictionary alloc]init];
    dict=[self.ContactsArray objectAtIndex:indexPath.section];
    NSArray *arrEmails=[[NSArray alloc]init];
    NSArray *arrPhones=[[NSArray alloc]init];
    
    arrEmails=[dict valueForKey:@"email"];
    arrPhones=[dict valueForKey:@"phone"];
    
    if (arrEmails.count!=0) {
        
        if (indexPath.row>=arrEmails.count)
        {
            NSInteger integer;
            integer=indexPath.row-arrEmails.count;
           cell.lbl_emailOrPhnNo.text=[NSString stringWithFormat:@"Mobile: %@",[arrPhones objectAtIndex:integer] ];
            if ([self.SelectedPhoneNo containsObject:[arrPhones objectAtIndex:integer]]) {
                
                //btn green state
                [cell.btn_send setBackgroundImage:[UIImage imageNamed:@"ic_add_circle_green"] forState:UIControlStateNormal];
            }
          else
            {
                [cell.btn_send setBackgroundImage:[UIImage imageNamed:@"ic_add_circle_outline"] forState:UIControlStateNormal];
            }
        }
        else
        {
            cell.lbl_emailOrPhnNo.text=[arrEmails objectAtIndex:indexPath.row];
            if ([self.SelectedEmails containsObject:[arrEmails objectAtIndex:indexPath.row]]) {
                //btn green state
                [cell.btn_send setBackgroundImage:[UIImage imageNamed:@"ic_add_circle_green"] forState:UIControlStateNormal];
                
            }
           else
            {
                [cell.btn_send setBackgroundImage:[UIImage imageNamed:@"ic_add_circle_outline"] forState:UIControlStateNormal];
                
            }

        }
        return cell;
    }
    else if(arrPhones.count!=0)
    {
        cell.lbl_emailOrPhnNo.text=[NSString stringWithFormat:@"Mobile: %@",[arrPhones objectAtIndex:indexPath.row] ];
        if ([self.SelectedPhoneNo containsObject:[arrPhones objectAtIndex:indexPath.row]]) {
            
            //btn green state
            [cell.btn_send setBackgroundImage:[UIImage imageNamed:@"ic_add_circle_green"] forState:UIControlStateNormal];
        }
        else
        {
            [cell.btn_send setBackgroundImage:[UIImage imageNamed:@"ic_add_circle_outline"] forState:UIControlStateNormal];
            
        }

        return cell;
    }
    else
    {
        return cell;
    }
  
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return self.ContactsArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 70;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserProfile *up=[[UserProfile alloc]init];
    up=[UserProfile getProfile];
    
    NSDictionary *dict=[[NSDictionary alloc]init];
    dict=[self.ContactsArray objectAtIndex:indexPath.section];
  

    
    NSArray *arrEmails=[[NSArray alloc]init];
    NSArray *arrPhones=[[NSArray alloc]init];
    
    arrEmails=[dict valueForKey:@"email"];
    arrPhones=[dict valueForKey:@"phone"];
    if (arrEmails.count!=0)
    {
        if (indexPath.row>=arrEmails.count)
        {
            NSInteger integer;
            integer=indexPath.row-arrEmails.count;
            
        //message

         
            if ([self.SelectedPhoneNo containsObject:[arrPhones objectAtIndex:integer]]) {
                
                [self.SelectedPhoneNo removeObject:[arrPhones objectAtIndex:integer]];
                if ([self.is_selected containsObject:[NSString stringWithFormat:@"%li",(long)indexPath.section]]) {
                    [self.is_selected removeObject:[NSString stringWithFormat:@"%li",(long)indexPath.section]];

                }
              
            }
           else {
                [self.SelectedPhoneNo addObject:[arrPhones objectAtIndex:integer]];
            }
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [self.tbl_contacts reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
        else
        {
            //mail
            if ([self.SelectedEmails containsObject:[arrEmails objectAtIndex:indexPath.row]]) {
                
                [self.SelectedEmails removeObject:[arrEmails objectAtIndex:indexPath.row]];
                if ([self.is_selected containsObject:[NSString stringWithFormat:@"%li",(long)indexPath.section]]) {
                    
                    [self.is_selected removeObject:[NSString stringWithFormat:@"%li",(long)indexPath.section]];
                }
            }
           else {
                [self.SelectedEmails addObject:[arrEmails objectAtIndex:indexPath.row]];
            }
            
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [self.tbl_contacts reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
            
        }

           }
    else if(arrPhones.count!=0)
    {
          //message
        if ([self.SelectedPhoneNo containsObject:[arrPhones objectAtIndex:indexPath.row]]) {
            
            [self.SelectedPhoneNo removeObject:[arrPhones objectAtIndex:indexPath.row]];
            if ([self.is_selected containsObject:[NSString stringWithFormat:@"%li",(long)indexPath.section]]) {
                [self.is_selected removeObject:[NSString stringWithFormat:@"%li",(long)indexPath.section]];
            }
        }
       else {
            [self.SelectedPhoneNo addObject:[arrPhones objectAtIndex:indexPath.row]];
        }
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tbl_contacts reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSDictionary *dict=[[NSDictionary alloc]init];
    dict=[self.ContactsArray objectAtIndex:section];
    self.HeaderIndex=section;

    
       ContactsHeaderView *HeaderView = [[ContactsHeaderView alloc] init];
    

        NSString *str=[NSString stringWithFormat:@"%li",(long)section];
        
        if ([self.is_selected containsObject:str]) {
            [HeaderView.btn_iconImg setImage:[UIImage imageNamed:@"ic_add_circle_green"] forState:UIControlStateNormal];
            
        }
        else
        {
            [HeaderView.btn_iconImg setImage:[UIImage imageNamed:@"ic_add_circle_outline"] forState:UIControlStateNormal];
            
        }

    
    HeaderView.lbl_user_name.text=[dict valueForKey:@"name"];
    if ([dict valueForKey:@"image"]!=nil) {
  
        HeaderView.img_userPic.image=[dict valueForKey:@"image"];
        HeaderView.lbl_ifNoPIc.hidden=YES;
    }
    else
    {
        HeaderView.lbl_ifNoPIc.hidden=NO;
        NSMutableString * firstCharacters = [NSMutableString string];
        NSArray * words = [[dict valueForKey:@"name"] componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        for (NSString * word in words) {
            if ([word length] > 0) {
                NSString * firstLetter = [word substringToIndex:1];
                [firstCharacters appendString:[firstLetter uppercaseString]];
                
            }
           HeaderView.lbl_ifNoPIc.text=firstCharacters;
        }
        
        
    }
    HeaderView.btn_AllOption.tag=section;
    HeaderView.btn_iconImg.tag=section;
    
    [HeaderView.btn_AllOption addTarget:self action:@selector(MsgToAll:) forControlEvents:UIControlEventTouchUpInside];
    
   
    
    return HeaderView;
    
}// custom view for header. will be adjusted to default or specified header height


-(void)MsgToAll:(UIButton*)sender
{
    NSDictionary *dict=[[NSDictionary alloc]init];
    dict=[self.ContactsArray objectAtIndex:sender.tag];
    
    
    
//    for (int i=0; i<self.ContactsArray.count; i++)
//    {
        NSString *str=[NSString stringWithFormat:@"%li",(long)sender.tag];
        
        if ([self.is_selected containsObject:str]) {
            [self.is_selected removeObject:str];
           
        }
        else
        {
            [self.is_selected addObject:str];
           
        }
//    }
    
    NSArray *arrEmails=[[NSArray alloc]init];
    NSArray *arrPhones=[[NSArray alloc]init];
    
    arrEmails=[dict valueForKey:@"email"];
    arrPhones=[dict valueForKey:@"phone"];
     NSMutableArray* indexes=[[NSMutableArray alloc]init];
    
    NSInteger TotalCount;
    TotalCount=arrEmails.count+arrPhones.count;
    
    if ([self.is_selected containsObject:[NSString stringWithFormat:@"%li",(long)sender.tag]])
    {
     
        //self.HeaderView=(ContactsHeaderView*)[self.tbl_contacts headerViewForSection:sender.tag];
      //  [self.HeaderView.btn_iconImg setImage:[UIImage imageNamed:@"ic_add_circle_green"] forState:UIControlStateNormal];
        
        if (arrEmails.count!=0) {
            
            for (int i=0; i<TotalCount; i++)
            {
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:sender.tag];
                [indexes addObject:indexPath];
                
                if (i >=arrEmails.count)
                {
                    NSInteger integer;
                    integer=i-arrEmails.count;
                    if ([self.SelectedPhoneNo containsObject:[arrPhones objectAtIndex:integer]]) {
                        
                        //[self.SelectedPhoneNo removeObject:[arrPhones objectAtIndex:integer]];
                    }
                    else {
                        [self.SelectedPhoneNo addObject:[arrPhones objectAtIndex:integer]];
                    }
                    
                    
                }
                else{
                    if ([self.SelectedEmails containsObject:[arrEmails objectAtIndex:i]]) {
                        
                        //[self.SelectedEmails removeObject:[arrEmails objectAtIndex:i]];
                    }
                    else {
                        [self.SelectedEmails addObject:[arrEmails objectAtIndex:i]];
                    }
                }
            }
            
            
            [self.tbl_contacts reloadRowsAtIndexPaths:indexes withRowAnimation:UITableViewRowAnimationAutomatic];
            [self.tbl_contacts reloadSections:[NSIndexSet indexSetWithIndex:sender.tag] withRowAnimation:UITableViewRowAnimationAutomatic];

        }
        else
        {
            for (int j=0; j<arrPhones.count; j++)
            {
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:j inSection:sender.tag];
                [indexes addObject:indexPath];
                
                if ([self.SelectedPhoneNo containsObject:[arrPhones objectAtIndex:j]]) {
                    
                    //[self.SelectedPhoneNo removeObject:[arrPhones objectAtIndex:i]];
                }
                else {
                    [self.SelectedPhoneNo addObject:[arrPhones objectAtIndex:j]];
                }
            }
            [self.tbl_contacts reloadRowsAtIndexPaths:indexes withRowAnimation:UITableViewRowAnimationAutomatic];
           [self.tbl_contacts reloadSections:[NSIndexSet indexSetWithIndex:sender.tag] withRowAnimation:UITableViewRowAnimationAutomatic];
        }

    }
    
    else{
        
//        ContactsHeaderView *HeaderView=[[ContactsHeaderView alloc]init] ;
//        HeaderView=(ContactsHeaderView*)[self.tbl_contacts headerViewForSection:sender.tag];
     //   [self.HeaderView.btn_iconImg setImage:[UIImage imageNamed:@"ic_add_circle_outline"] forState:UIControlStateNormal];

        if (arrEmails.count!=0) {
            
            for (int i=0; i<TotalCount; i++)
            {
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:sender.tag];
                [indexes addObject:indexPath];
                
                if (i >=arrEmails.count)
                {
                    NSInteger integer;
                    integer=i-arrEmails.count;
                    if ([self.SelectedPhoneNo containsObject:[arrPhones objectAtIndex:integer]]) {
                        
                        [self.SelectedPhoneNo removeObject:[arrPhones objectAtIndex:integer]];
                    }
                    else {
                      //  [self.SelectedPhoneNo addObject:[arrPhones objectAtIndex:integer]];
                    }
                    
                    
                }
                else{
                    if ([self.SelectedEmails containsObject:[arrEmails objectAtIndex:i]]) {
                        
                        [self.SelectedEmails removeObject:[arrEmails objectAtIndex:i]];
                    }
                    else {
                       // [self.SelectedEmails addObject:[arrEmails objectAtIndex:i]];
                    }
                }
            }
            
            
            [self.tbl_contacts reloadRowsAtIndexPaths:indexes withRowAnimation:UITableViewRowAnimationAutomatic];
             [self.tbl_contacts reloadSections:[NSIndexSet indexSetWithIndex:sender.tag] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
        else
        {
            for (int j=0; j<arrPhones.count; j++)
            {
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:j inSection:sender.tag];
                [indexes addObject:indexPath];
                
                if ([self.SelectedPhoneNo containsObject:[arrPhones objectAtIndex:j]]) {
                    
                    [self.SelectedPhoneNo removeObject:[arrPhones objectAtIndex:j]];
                }
                else {
                  //  [self.SelectedPhoneNo addObject:[arrPhones objectAtIndex:i]];
                }
            }
            [self.tbl_contacts reloadRowsAtIndexPaths:indexes withRowAnimation:UITableViewRowAnimationAutomatic];
          [self.tbl_contacts reloadSections:[NSIndexSet indexSetWithIndex:sender.tag] withRowAnimation:UITableViewRowAnimationAutomatic];
        }

    }
    
}


#pragma mark-Search 
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.view endEditing:YES];
    [self resignFirstResponder];

    
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    self.tbl_contacts.hidden=NO;
    self.lbl_addPeople.hidden=YES;
    

    
    self.Search_contacts.showsCancelButton = YES;
    
    NSPredicate* filter1 = [NSPredicate predicateWithFormat:@"%K CONTAINS[cd] %@",@"name", searchText];
    NSPredicate* filter2 = [NSPredicate predicateWithFormat:@"%K CONTAINS[cd] %@",@"email", searchText];
    NSPredicate* filter3 = [NSPredicate predicateWithFormat:@"%K CONTAINS[cd] %@",@"phone", searchText];

    NSArray *searchFilters=@[filter1,filter2,filter3];
    NSPredicate *compoundPredicate=[NSCompoundPredicate orPredicateWithSubpredicates:searchFilters];
    
 //   NSPredicate* predicate = [NSPredicate predicateWithFormat:filter, @"brandDet.bDet_name", searchText];
    self.ContactsArray=[[NSMutableArray alloc]init];
    self.ContactsArray = [[self.FilteredContactsArray filteredArrayUsingPredicate:compoundPredicate] mutableCopy];
    
    self.SelectedEmails =[[NSMutableArray alloc]init];
    self.SelectedPhoneNo=[[NSMutableArray alloc]init];
    self.is_selected=[[NSMutableArray alloc]init];
    
    [self.tbl_contacts reloadData];
    self.lbl_noResults.hidden=(searchFilters.count==0)? NO:YES;
    
    self.btn_send.hidden=(searchFilters.count==0)? YES:NO;

    
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    self.tbl_contacts.hidden=YES;
    self.lbl_addPeople.hidden=NO;
    self.btn_send.hidden=YES;
    
    self.lbl_noResults.hidden=YES;
    self.SelectedEmails =[[NSMutableArray alloc]init];
    self.SelectedPhoneNo=[[NSMutableArray alloc]init];
    self.is_selected=[[NSMutableArray alloc]init];
    
    self.Search_contacts.showsCancelButton = NO;
    [self.view endEditing:YES];
    
    //    [self.searchBar endEditing:YES];
    self.Search_contacts.text=@"";
    //    [self.searchBar resignFirstResponder];
    
    [self GetContactsList];
    [self.tbl_contacts reloadData];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
   
    return YES;
}
#pragma mark-ContactsArray

-(void)GetContactsList
{
    CFErrorRef error = NULL;
     ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, &error);
//    __block BOOL accessGranted = NO;
//    if (ABAddressBookRequestAccessWithCompletion != NULL) { // we're on iOS 6
//        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
//        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
//            accessGranted = granted;
//            dispatch_semaphore_signal(sema);
//        });
//        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
//        
//    }
//    else { // we're on iOS 5 or older
//        accessGranted = YES;
//    }
//    
//    if (!accessGranted)
//    {
//        
//        return;
//    }

    
    if (addressBook != nil)
    {
    
        CFArrayRef allSources = ABAddressBookCopyArrayOfAllSources(addressBook);
        self.ContactsArray = [[NSMutableArray alloc] init];
        self.FilteredContactsArray=[[NSMutableArray alloc]init];
        
        for (CFIndex i = 0; i < CFArrayGetCount(allSources); i++)
        {
            //2
            ABRecordRef source = (ABRecordRef)CFArrayGetValueAtIndex(allSources, i);
            ABPersonSortOrdering sortOrdering = ABPersonGetSortOrdering();
            CFArrayRef allPeopleInSource = ABAddressBookCopyArrayOfAllPeopleInSourceWithSortOrdering(addressBook, source, sortOrdering );
        

            
            NSLog(@"Count allPeopleInSource: %li", CFArrayGetCount(allPeopleInSource));
            
            //3
            NSUInteger i = 0; for (i = 0; i < CFArrayGetCount(allPeopleInSource); i++)
            {
               NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
                
                ABRecordRef contactPerson = CFArrayGetValueAtIndex(allPeopleInSource, i);
                
                NSString *firstName = (__bridge  NSString *)ABRecordCopyValue(contactPerson,
                                                                              kABPersonFirstNameProperty);
                NSString *lastName = (__bridge  NSString *)ABRecordCopyValue(contactPerson, kABPersonLastNameProperty);
                NSString *fullName = [NSString stringWithFormat:@"%@ %@", firstName?firstName:@"", lastName?lastName:@""];
                
                [dict setValue:[self trimStr:fullName] forKey:@"name"];
                
                
                ABMultiValueRef phones =(__bridge ABMultiValueRef)((__bridge NSString*)ABRecordCopyValue(contactPerson, kABPersonPhoneProperty));
                
                NSMutableArray *phoneNos = [[NSMutableArray alloc] init];
                
                for(CFIndex j = 0; j< ABMultiValueGetCount(phones); j++)
                {
                    if ([(NSString *)(__bridge NSString*)ABMultiValueCopyValueAtIndex(phones, j) length] == 0) {
                        continue;
                    }
                    
                    NSMutableString *result = [NSMutableString stringWithCapacity:[(NSString *)(__bridge NSString*)ABMultiValueCopyValueAtIndex(phones, j) length]];
                    
                    NSScanner *scanner = [NSScanner scannerWithString:(__bridge NSString*)ABMultiValueCopyValueAtIndex(phones, j)];
                    NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
                    
                    while ([scanner isAtEnd] == NO)
                    {
                        NSString *buffer;
                        if ([scanner scanCharactersFromSet:numbers intoString:&buffer])
                        {
                            [result appendString:buffer];
                        }
                        else
                        {
                            [scanner setScanLocation:([scanner scanLocation] + 1)];
                        }
                    }
                    
                    NSString *phone =result;
                    
                    if(phone.length  > 10)
                    {
                        phone = [phone substringFromIndex:MAX((int)[phone length]-10, 0)];
                    }
                    
                    [phoneNos addObject:[self trimStr:phone]];
                    
                }
                
                [dict setValue:phoneNos forKey:@"phone"];
                
                
                
                ABMultiValueRef emails =(__bridge ABMultiValueRef)((__bridge NSString*)ABRecordCopyValue(contactPerson, kABPersonEmailProperty));
                
                NSMutableArray *Person_emails = [[NSMutableArray alloc] init];
                
                for(CFIndex j = 0; j<= ABMultiValueGetCount(emails); j++)
                 {
                    if ([(NSString *)(__bridge NSString*)ABMultiValueCopyValueAtIndex(emails, j) length] == 0) {
                        continue;
                    }
                    
                     NSString *strEmail=[[NSString alloc]init];
                     strEmail=(NSString *)(__bridge NSString*)ABMultiValueCopyValueAtIndex(emails, j);
                     
//                    NSMutableString *result2 = [NSMutableString stringWithCapacity:[(NSString *)(__bridge NSString*)ABMultiValueCopyValueAtIndex(emails, j) length]];
                     
                     //strEmail=result2;
                    if ([[self trimStr:strEmail]isEqualToString:@""]) {
                        
                    }
                    else{
                        [Person_emails addObject:[self trimStr:strEmail]];
                    }
                }
                
                [dict setValue:Person_emails forKey:@"email"];

                
                //Get image data
                
                if (ABPersonHasImageData(contactPerson))
                {
                    NSData *contactImageData = (__bridge NSData *)ABPersonCopyImageDataWithFormat(contactPerson, kABPersonImageFormatThumbnail);
                           //tempContact.contact_image =  [UIImage imageWithData:contactImageData];
                    [dict setValue: [UIImage imageWithData:contactImageData] forKey:@"image"];
                }
                

                if (phoneNos.count > 0) {
                   

                    [self.ContactsArray addObject:dict];
                    [self.FilteredContactsArray addObject:dict];
                    
                }
            
        }
        
            [self.tbl_contacts reloadData];
//        success(contactsArray);
                //8
    
   }
   
    }
    CFRelease(addressBook);

}


-(NSString*)trimStr:(NSString*)str
{
    NSString *str1=[[NSString alloc]init];
    str1=[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return str1;
}

#pragma mark-messageComposer delegate

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    switch (result) {
        case MessageComposeResultCancelled:
            NSLog(@"Message cancelled");
            break;
            
        case MessageComposeResultFailed:
        {
            UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to send SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [warningAlert show];
            break;
        }
            
        case MessageComposeResultSent:
        {
             NSLog(@"Message Sent");
        }
            
        default:
            break;
    }
    
   // [self dismissViewControllerAnimated:YES completion:nil];
    
    [self dismissViewControllerAnimated:YES completion:^{
        [self.App StopAnimating];
        self.tbl_contacts.userInteractionEnabled=YES;
        
        self.SelectedPhoneNo=[[NSMutableArray alloc]init];
        self.SelectedEmails=[[NSMutableArray alloc]init];
        self.is_selected=[[NSMutableArray alloc]init];
        
        [self.tbl_contacts reloadData];
    }];
    
}
#pragma mark-mailComposer delegate

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result) {
        case MFMailComposeResultCancelled:
            NSLog(@"EmailCanceled");
        {
            UserProfile *up=[[UserProfile alloc]init];
            up=[UserProfile getProfile];
            
            if (self.SelectedPhoneNo.count!=0) {
                
                if(![MFMessageComposeViewController canSendText]) {
                    // [cell.btn_send setImage:[UIImage imageNamed:@"ic_add_circle_outline"] forState:UIControlStateNormal];
                    UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your device doesn't support SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [warningAlert show];
                    return;
                }
                else
                {
                    NSMutableArray *recipents =[[NSMutableArray alloc]init];
                    //[recipents addObject:[arrPhones objectAtIndex: integer]];
                    [recipents addObjectsFromArray:self.SelectedPhoneNo];
                    
                    //I’m sharing my gift cards with you.
//
                    
                    NSString *messageBody=[[NSString alloc]init];
                   messageBody=[NSString stringWithFormat:@"Hey,\nI’m sending you this app so we can share my gift cards.\nClick on the Family Share, then the SYNC button, and paste this code:\n%@",up.user_code];

//                    messageBody=up.user_code;
                    MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
                 
                    [messageController setRecipients:recipents];
                    
                    [messageController setBody:messageBody];
                    messageController.messageComposeDelegate = self;
                    // Present message view controller on screen
                    [self presentViewController:messageController animated:YES completion:^{
                        
                        
                    }];
                }
                
            }
        }

            break;
            
        case MFMailComposeResultFailed:
        {
            UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to send email!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            warningAlert.tag=3;
            [warningAlert show];
            break;
        }
            
        case MFMailComposeResultSent:
               NSLog(@"EmailSent");
        {
            UserProfile *up=[[UserProfile alloc]init];
            up=[UserProfile getProfile];

            if (self.SelectedPhoneNo.count!=0) {
                
                if(![MFMessageComposeViewController canSendText]) {
                    // [cell.btn_send setImage:[UIImage imageNamed:@"ic_add_circle_outline"] forState:UIControlStateNormal];
                    UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your device doesn't support SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [warningAlert show];
                    return;
                }
                else
                {
                    NSMutableArray *recipents =[[NSMutableArray alloc]init];
                    //[recipents addObject:[arrPhones objectAtIndex: integer]];
                    [recipents addObjectsFromArray:self.SelectedPhoneNo];
                    
//                    NSString *messageBody=[[NSString alloc]init];
//                    messageBody=up.user_code;
                    NSString *messageBody=[[NSString alloc]init];
                    messageBody=[NSString stringWithFormat:@"Hey,\nI’m sending you this app so we can share my gift cards.\nClick on the Family Share, then the SYNC button,and paste this code:\n%@",up.user_code];
                    
                    MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
                    messageController.messageComposeDelegate = self;
                    [messageController setRecipients:recipents];
                    [messageController setBody:messageBody];
                    
                    // Present message view controller on screen
                    [self presentViewController:messageController animated:YES completion:^{
                   
                    }];
                }

            }
          }
        break;
            
        default:
            break;
    }
    
    //[controller dismissViewControllerAnimated:NO completion:nil];
    [controller dismissViewControllerAnimated:NO completion:^{
        [self.App StopAnimating];
        self.tbl_contacts.userInteractionEnabled=YES;
        
        if (self.SelectedPhoneNo.count!=0) {
            self.SelectedEmails=[[NSMutableArray alloc]init];
           [self.tbl_contacts reloadData];
        }
        else
        {
             self.SelectedEmails=[[NSMutableArray alloc]init];
            self.SelectedPhoneNo=[[NSMutableArray alloc]init];
            self.is_selected=[[NSMutableArray alloc]init];

            [self.tbl_contacts reloadData];
        }
        
    }];
    
}


- (IBAction)btn_back_pressed:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)btn_close_pressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}




- (IBAction)btn_send_pressed:(id)sender
{
//    AppDelegate  *App=(AppDelegate*)[UIApplication sharedApplication].delegate;
//    [App StartAnimating];
    if (self.SelectedPhoneNo.count==0&&self.SelectedEmails.count==0) {
        
    }
    else{
        [self send];
    }
    
}

-(void)send
{
    [self.App StartAnimating];
    UserProfile *up=[[UserProfile alloc]init];
    up=[UserProfile getProfile];

    
    if (self.SelectedEmails.count!=0)
    {
        if(![MFMailComposeViewController canSendMail]) {
            
            UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your device doesn't support Sending Emails!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [warningAlert show];
            
            return;
        }
        else
        {
            NSMutableArray *toRecipents =[[NSMutableArray alloc]init];
            // [toRecipents addObject:[arrEmails objectAtIndex: indexPath.row]];
            [toRecipents addObjectsFromArray:self.SelectedEmails];
            
            MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
            
            mc.mailComposeDelegate = self;
            
            NSString *messageBody=[[NSString alloc]init];
            messageBody=[NSString stringWithFormat:@"Hey,\nI’m sending you this app so we can share my gift cards.\nClick on the Family Share, then the SYNC button, and paste this code:\n%@",up.user_code];
            
            [mc setMessageBody:messageBody isHTML:NO];
             mc.subject=@"I’m sharing my gift cards with you.";
            [mc setToRecipients:toRecipents];
            
            
            // Present mail view controller on screen
            
            [self presentViewController:mc animated:YES completion:^{
                [self.App StopAnimating];
                self.tbl_contacts.userInteractionEnabled=YES;
                
            }];
            
        }
    }
    else if(self.SelectedPhoneNo.count!=0)
    {
        if(![MFMessageComposeViewController canSendText]) {
            // [cell.btn_send setImage:[UIImage imageNamed:@"ic_add_circle_outline"] forState:UIControlStateNormal];
            UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your device doesn't support SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [warningAlert show];
            return;
        }
        else
        {
            NSMutableArray *recipents =[[NSMutableArray alloc]init];
            //[recipents addObject:[arrPhones objectAtIndex: integer]];
            [recipents addObjectsFromArray:self.SelectedPhoneNo];
            
            NSString *messageBody=[[NSString alloc]init];
            messageBody=[NSString stringWithFormat:@"Hey,\nI’m sending you this app so we can share my gift cards.\nClick on the Family Share, then the SYNC button, and paste this code:\n%@",up.user_code];
            
            MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
            messageController.messageComposeDelegate = self;
            [messageController setRecipients:recipents];
            [messageController setBody:messageBody];
            
            // Present message view controller on screen
            [self presentViewController:messageController animated:YES completion:^{
                [self.App StopAnimating];
                self.tbl_contacts.userInteractionEnabled=YES;
            }];
        }
        
    }

}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==3)
    {
        if (buttonIndex==0)
        {
            {
                UserProfile *up=[[UserProfile alloc]init];
                up=[UserProfile getProfile];
                
                if (self.SelectedPhoneNo.count!=0) {
                    
                    if(![MFMessageComposeViewController canSendText]) {
                        // [cell.btn_send setImage:[UIImage imageNamed:@"ic_add_circle_outline"] forState:UIControlStateNormal];
                        UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your device doesn't support SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        [warningAlert show];
                        return;
                    }
                    else
                    {
                        NSMutableArray *recipents =[[NSMutableArray alloc]init];
                        //[recipents addObject:[arrPhones objectAtIndex: integer]];
                        [recipents addObjectsFromArray:self.SelectedPhoneNo];
                        
                        NSString *messageBody=[[NSString alloc]init];
                        messageBody=[NSString stringWithFormat:@"Hey,\nI’m sending you this app so we can share my gift cards.\nClick on the Family Share, then the SYNC button, and paste this code:\n%@",up.user_code];
                        
                        MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
                        messageController.messageComposeDelegate = self;
                        [messageController setRecipients:recipents];
                        [messageController setBody:messageBody];
                        
                        // Present message view controller on screen
                        [self presentViewController:messageController animated:YES completion:^{
                            
                        }];
                    }
                    
                }
            }

        }
    }
}

//  /////////////////////////////////////////
//-(void)MsgToAll:(UIButton*)sender
//{
//    NSDictionary *dict=[[NSDictionary alloc]init];
//    dict=[self.ContactsArray objectAtIndex:sender.tag];
//    
//    
//    NSArray *arrEmails=[[NSArray alloc]init];
//    NSArray *arrPhones=[[NSArray alloc]init];
//    
//    arrEmails=[dict valueForKey:@"email"];
//    arrPhones=[dict valueForKey:@"phone"];
//    NSMutableArray* indexes=[[NSMutableArray alloc]init];
//    
//    NSInteger TotalCount;
//    TotalCount=arrEmails.count+arrPhones.count;
//    
//    if (!arrEmails.count==0) {
//        
//        for (int i=0; i<TotalCount; i++)
//        {
//            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:sender.tag];
//            [indexes addObject:indexPath];
//            
//            if (i >=arrEmails.count)
//            {
//                NSInteger integer;
//                integer=i-arrEmails.count;
//                if ([self.SelectedPhoneNo containsObject:[arrPhones objectAtIndex:integer]]) {
//                    
//                    [self.SelectedPhoneNo removeObject:[arrPhones objectAtIndex:integer]];
//                }
//                else {
//                    [self.SelectedPhoneNo addObject:[arrPhones objectAtIndex:integer]];
//                }
//                
//                
//            }
//            else{
//                if ([self.SelectedEmails containsObject:[arrEmails objectAtIndex:i]]) {
//                    
//                    [self.SelectedEmails removeObject:[arrEmails objectAtIndex:i]];
//                }
//                else {
//                    [self.SelectedEmails addObject:[arrEmails objectAtIndex:i]];
//                }
//            }
//        }
//        
//        
//        [self.tbl_contacts reloadRowsAtIndexPaths:indexes withRowAnimation:UITableViewRowAnimationAutomatic];
//        
//    }
//    else
//    {
//        for (int i=0; i<arrEmails.count; i++)
//        {
//            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:self.HeaderIndex];
//            [indexes addObject:indexPath];
//            
//            if ([self.SelectedPhoneNo containsObject:[arrPhones objectAtIndex:i]]) {
//                
//                [self.SelectedPhoneNo removeObject:[arrPhones objectAtIndex:i]];
//            }
//            else {
//                [self.SelectedPhoneNo addObject:[arrPhones objectAtIndex:i]];
//            }
//        }
//        [self.tbl_contacts reloadRowsAtIndexPaths:indexes withRowAnimation:UITableViewRowAnimationAutomatic];
//        
//    }
//    
//}

/////////////////////////////////////////////
#pragma mark-TableView Delegates

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    
//    NSDictionary *dict=[[NSDictionary alloc]init];
//    dict=[self.ContactsArray objectAtIndex:section];
//    
//    NSInteger rowCount;
//    rowCount=[[dict valueForKey:@"email"] count]+[[dict valueForKey:@"phone"] count];
//    
//    return rowCount;
//}
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    ContactsTableCell *cell=[tableView dequeueReusableCellWithIdentifier:@"ContactsTableCell" forIndexPath:indexPath];
//    
//    NSDictionary *dict=[[NSDictionary alloc]init];
//    dict=[self.ContactsArray objectAtIndex:indexPath.section];
//    NSArray *arrEmails=[[NSArray alloc]init];
//    NSArray *arrPhones=[[NSArray alloc]init];
//    
//    arrEmails=[dict valueForKey:@"email"];
//    arrPhones=[dict valueForKey:@"phone"];
//    
//    if (arrEmails.count!=0) {
//        
//        if (indexPath.row>=arrEmails.count)
//        {
//            NSInteger integer;
//            integer=indexPath.row-arrEmails.count;
//            cell.lbl_emailOrPhnNo.text=[NSString stringWithFormat:@"Mobile: %@",[arrPhones objectAtIndex:integer] ];
//        }
//        else
//        {
//            cell.lbl_emailOrPhnNo.text=[arrEmails objectAtIndex:indexPath.row];
//        }
//        return cell;
//    }
//    else if(arrPhones.count!=0)
//    {
//        cell.lbl_emailOrPhnNo.text=[NSString stringWithFormat:@"Mobile: %@",[arrPhones objectAtIndex:indexPath.row] ];
//        return cell;
//    }
//    else
//    {
//        return cell;
//    }
//    
//}
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    
//    return self.ContactsArray.count;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 50;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 70;
//}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    AppDelegate  *App=(AppDelegate*)[UIApplication sharedApplication].delegate;
//    [App StartAnimating];
//    self.tbl_contacts.userInteractionEnabled=NO;
//    
//    ContactsTableCell *cell=[tableView dequeueReusableCellWithIdentifier:@"ContactsTableCell" forIndexPath:indexPath];
//    UserProfile *up=[[UserProfile alloc]init];
//    up=[UserProfile getProfile];
//    
//    NSDictionary *dict=[[NSDictionary alloc]init];
//    dict=[self.ContactsArray objectAtIndex:indexPath.section];
//    NSArray *arrEmails=[[NSArray alloc]init];
//    NSArray *arrPhones=[[NSArray alloc]init];
//    
//    arrEmails=[dict valueForKey:@"email"];
//    arrPhones=[dict valueForKey:@"phone"];
//    if (arrEmails.count!=0)
//    {
//        if (indexPath.row>=arrEmails.count)
//        {
//            NSInteger integer;
//            integer=indexPath.row-arrEmails.count;
//            
//            if(![MFMessageComposeViewController canSendText]) {
//                [cell.btn_send setImage:[UIImage imageNamed:@"ic_add_circle_outline"] forState:UIControlStateNormal];
//                UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your device doesn't support SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//                [warningAlert show];
//                return;
//            }
//            else
//            {
//                NSMutableArray *recipents =[[NSMutableArray alloc]init];
//                [recipents addObject:[arrPhones objectAtIndex: integer]];
//                
//                
//                NSString *messageBody=[[NSString alloc]init];
//                messageBody=up.user_code;
//                MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
//                messageController.messageComposeDelegate = self;
//                [messageController setRecipients:recipents];
//                [messageController setBody:messageBody];
//                
//                // Present message view controller on screen
//                [self presentViewController:messageController animated:YES completion:^{
//                    [App StopAnimating];
//                    self.tbl_contacts.userInteractionEnabled=YES;
//                }];
//            }
//        }
//        else
//        {
//            if(![MFMailComposeViewController canSendMail]) {
//                
//                UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your device doesn't support Sending Emails!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//                
//                [warningAlert show];
//                
//                return;
//            }
//            
//            else
//            {
//                NSMutableArray *toRecipents =[[NSMutableArray alloc]init];
//                [toRecipents addObject:[arrEmails objectAtIndex: indexPath.row]];
//                
//                MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
//                
//                mc.mailComposeDelegate = self;
//                
//                [mc setMessageBody:up.user_code isHTML:YES];
//                
//                [mc setToRecipients:toRecipents];
//                
//                
//                // Present mail view controller on screen
//                
//                [self presentViewController:mc animated:YES completion:^{
//                    [App StopAnimating];
//                    self.tbl_contacts.userInteractionEnabled=YES;
//                    
//                }];
//                
//            }
//            
//            
//        }
//        
//    }
//    else if(arrPhones.count!=0)
//    {
//        if(![MFMessageComposeViewController canSendText]) {
//            [cell.btn_send setImage:[UIImage imageNamed:@"ic_add_circle_outline"] forState:UIControlStateNormal];
//            UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your device doesn't support SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//            [warningAlert show];
//            return;
//        }
//        else
//        {
//            NSMutableArray *recipents =[[NSMutableArray alloc]init];
//            [recipents addObject:[arrPhones objectAtIndex: indexPath.row]];
//            
//            NSString *messageBody=[[NSString alloc]init];
//            messageBody=up.user_code;
//            MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
//            messageController.messageComposeDelegate = self;
//            [messageController setRecipients:recipents];
//            [messageController setBody:messageBody];
//            
//            // Present message view controller on screen
//            [self presentViewController:messageController animated:YES completion:^{
//                [App StopAnimating];
//                self.tbl_contacts.userInteractionEnabled=YES;
//                
//            }];
//            
//            
//        }
//    }
//    
//    
//    
//    
//}
//
//
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    NSDictionary *dict=[[NSDictionary alloc]init];
//    dict=[self.ContactsArray objectAtIndex:section];
//    
//    
//    ContactsHeaderView *HeaderView = [[ContactsHeaderView alloc] init];
//    
//    HeaderView.lbl_user_name.text=[dict valueForKey:@"name"];
//    if ([dict valueForKey:@"image"]!=nil) {
//        
//        HeaderView.img_userPic.image=[dict valueForKey:@"image"];
//        HeaderView.lbl_ifNoPIc.hidden=YES;
//    }
//    else
//    {
//        HeaderView.lbl_ifNoPIc.hidden=NO;
//        NSMutableString * firstCharacters = [NSMutableString string];
//        NSArray * words = [[dict valueForKey:@"name"] componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//        for (NSString * word in words) {
//            if ([word length] > 0) {
//                NSString * firstLetter = [word substringToIndex:1];
//                [firstCharacters appendString:[firstLetter uppercaseString]];
//                
//            }
//            HeaderView.lbl_ifNoPIc.text=firstCharacters;
//        }
//        
//        
//    }
//    
//    [HeaderView.btn_AllOption addTarget:self action:@selector(MsgToAll:) forControlEvents:UIControlEventTouchUpInside];
//    
//    return HeaderView;
//    
//}// custom view for header. will be adjusted to default or specified header height



@end

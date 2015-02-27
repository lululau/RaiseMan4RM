// Generated by IB v0.7.2 gem. Do not edit it manually
// Run `rake ib:open` to refresh

#import <AppKit/AppKit.h>
#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <CoreServices/CoreServices.h>

@interface AppDelegate: NSObject <NSApplicationDelegate>
-(IBAction) applicationDidFinishLaunching:(id) notification;

@end

@interface Document: NSDocument

@property IBOutlet NSTableView * table;
@property IBOutlet NSButton * delete_btn;

-(IBAction) insert_person:(id) sender;
-(IBAction) remove_person:(id) sender;
-(IBAction) removeObjectFromEmployeesAtIndex:(id) idx;
-(IBAction) numberOfRowsInTableView:(id) table;
-(IBAction) tableViewSelectionDidChange:(id) nt;
-(IBAction) autosavesInPlace;
-(IBAction) windowControllerDidLoadNib:(id) aController;
-(IBAction) windowNibName;

@end

@interface Person: NSObject
-(IBAction) initialize;
-(IBAction) setNilValueForKey:(id) key;
-(IBAction) initWithCoder:(id) coder;
-(IBAction) encodeWithCoder:(id) coder;

@end

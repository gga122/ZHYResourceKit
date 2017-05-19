//
//  ZHYBusinessViewController.h
//  ZHYResourceKit
//
//  Created by MickyZhu on 19/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ZHYBusinessViewController <NSObject>

@required

- (void)addNewItem:(id)sender;
- (void)removeItem:(id)sender;
- (void)editItem:(id)sender;
- (void)saveItem:(id)sender;

@end

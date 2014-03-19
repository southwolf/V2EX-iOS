//
//  V2EXSingleTopicViewController.h
//  V2EX
//
//  Created by WildCat on 2/19/14.
//  Copyright (c) 2014 WildCat. All rights reserved.
//

#import "V2EXTableViewController.h"
#import "V2EXAfterTopicActionDelegate.h"

@interface V2EXSingleTopicViewController : V2EXTableViewController <V2EXAfterTopicActionDelegate>
{
//    NSMutableArray *_cellHeightArray;
    NSUInteger _topicID;
    NSUInteger _onceCode;
    NSCache *_cellCache;
}

+ (V2EXSingleTopicViewController *)sharedController;

- (void)loadNewTopicWithID:(NSUInteger)ID;
- (void)loadNewTopicWithData:(NSData *)data;

@end

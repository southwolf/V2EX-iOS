//
//  V2EXStringUtil.m
//  V2EX
//
//  Created by WildCat on 2/14/14.
//  Copyright (c) 2014 WildCat. All rights reserved.
//

#import "V2EXStringUtil.h"

@implementation V2EXStringUtil

/**
 *  Conver link to topic ID
 *
 *  @param urlString The link in V2EX topics list.
 *
 *  @return topic ID.
 */
+ (NSUInteger)link2TopicID:(NSString *)urlString{
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"/t/[0-9]+#reply"
                                                                           options:0
                                                                             error:&error];
    if (regex != nil) {
        NSArray *array = [regex matchesInString: urlString
                                        options: 0
                                          range: NSMakeRange( 0, [urlString length])];
        if ([array count] > 0) {
            NSTextCheckingResult *match = [array objectAtIndex:0];
            NSRange firstHalfRange = [match rangeAtIndex:0];
            NSString *result = [[[urlString substringWithRange:firstHalfRange] stringByReplacingOccurrencesOfString:@"/t/" withString:@""] stringByReplacingOccurrencesOfString:@"#reply" withString:@""];
            return (NSUInteger)[result integerValue];
        } else {
            return 0;
        }
    } else {
        return 0;
    }
}

+ (NSString *)filterHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd] == NO)
    {
        [scanner scanUpToString:@"<" intoString:nil];
        [scanner scanUpToString:@">" intoString:&text];
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    //    NSString * regEx = @"<([^>]*)>";
    //    html = [html stringByReplacingOccurrencesOfString:regEx withString:@""];
    return html;
}

+ (NSString *)stringByStrippingHTML:(NSString *)inputString
{
    NSMutableString *outString;
    
    if (inputString)
    {
        outString = [[NSMutableString alloc] initWithString:inputString];
        
        if ([inputString length] > 0)
        {
            NSRange r;
            
            while ((r = [outString rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
            {
                [outString deleteCharactersInRange:r];
            }      
        }
    }
    
    return outString; 
}

+ (NSString *)replaceUnicode:(NSString *)unicodeStr {
    
    NSString *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                                                           mutabilityOption:NSPropertyListImmutable
                                                                     format:NULL
                                                           errorDescription:NULL];
    
//    NSLog(@"Output = %@", returnStr);
    
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
}

/**
 *  Handle V2EX avatar URL
 *
 *  @param url avatar URL
 *
 *  @return avatar url with protocol name http or https(not implementation yet)
 */
+ (NSString *)hanldeAvatarURL:(NSString *)url {
    return [@"http:" stringByAppendingString:url];
    //TODO: Support https.
}

@end

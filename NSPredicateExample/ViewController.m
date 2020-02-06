//
//  ViewController.m
//  NSPredicateExample
//
//  Created by mtaxi on 2019/8/7.
//  Copyright © 2019 leo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (NSInteger)getPriceFromString:(NSString *)price
{
	NSString *price = @"查詢完成|\n車資金額:354564\n交易狀態:扣款-失敗\n其它說明:\n如對金額有疑問";
	//正則表達式過濾條件
	NSString *pattern = @"金額:+[0-9]{1,9}"; //範圍只能0到9的數字，最少1一個，最多有9個字元
	
	NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionDotMatchesLineSeparators error:NULL];
	NSRange firstRange = [reg rangeOfFirstMatchInString:price options:NSMatchingReportProgress range:NSMakeRange(0, price.length)];
	
	if (firstRange.length !=0) {
        	NSString *filterResult = [price substringWithRange:firstRange];
		NSLog(@"匹配到第一組的位置:開始位置%lu--長度%lu",(unsigned long)firstRange.location,(unsigned long)firstRange.length);
		NSLog(@"過濾結果為 %@",filterResult);
		
		return [filterResult integerValue];
    	}else {
        	NSLog(@"無匹配結果");
		
		return nil;
    	}
	
}

- (NSInteger)getPriceFromString1:(NSString *)price
{
	//正則表達式過濾條件
	NSString *pattern = @"~+[0-9]{1,9}";
	
	NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionDotMatchesLineSeparators error:NULL];
	
	NSRange firstRange = [reg rangeOfFirstMatchInString:price options:NSMatchingReportProgress range:NSMakeRange(0, price.length)];
	
	NSString *filterResult = [price substringWithRange:firstRange];
	
	filterResult = [filterResult stringByReplacingOccurrencesOfString:@"~" withString:@""];
	
	NSLog(@"匹配到第一組的位置:開始位置%lu--長度%lu",(unsigned long)firstRange.location,(unsigned long)firstRange.length);
	NSLog(@"過濾結果為 %@",filterResult);
	return [filterResult integerValue];
}

//無~符號的字串驗證
-(BOOL)verifyPrice:(NSString *)price{
	NSString *fareRegex = @"[\u4e00-\u9fa5]*[0-9]{1,9}[\u4e00-\u9fa5]*";
	NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", fareRegex];
	BOOL matches = [test evaluateWithObject:price];
	NSLog(matches ? @"有預估車資" : @"沒有預估車資");
	return matches;
}

//有~符號的字串驗證
-(BOOL)verifyPrice1:(NSString *)price{
	NSString *fareRegex = @"預估+.+元";
	NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", fareRegex];
	BOOL matches = [test evaluateWithObject:price];
	NSLog(matches ? @"有預估車資" : @"沒有預估車資");
	return matches;
}

@end

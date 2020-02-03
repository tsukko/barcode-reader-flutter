//
//  CameraSample.m
//  
//
//  Created by tsuji on 2020/02/03.
//

#import "CameraSample.h"
#import "KXABarcodeReader.h"
#import <UIKit/UIView.h>

@implementation CameraSmaple : NSObject

-(void)testMethod
{
    NSLog(@"犬の鳴き声は一般的に「ワンワンです」");
}

-(void)testMethod2:sampleData
{
//    FlutterStandardTypedData
    NSData *imgBytes = [sampleData data];
    
    KXABarcodeReader *barcodeReader = [KXABarcodeReader sharedInstance];
    [barcodeReader reset];
    barcodeReader.rotation = 1;
    barcodeReader.types = 255;
    
    NSLog(@"AAAA:%@", [barcodeReader version]);
    
    
    if ([[barcodeReader decode:CFBridgingRetain(imgBytes)] length]) {
        // 文字列が空でなければバーコードの検出に成功している。
        NSLog(@"Type: %d", barcodeReader.type);
    }
}
@end


//
//  ViewController.m
//  XML
//
//  Created by HuangQibo on 16/9/6.
//  Copyright © 2016年 HuangQibo. All rights reserved.
//

#import "ViewController.h"
#import "HQB_StudentMod.h"
#import "GDataXMLNode.h"
@interface ViewController ()<NSXMLParserDelegate>
@property (nonatomic ,retain)NSMutableArray *studentArray;
@property (nonatomic, retain)NSString *string;
@property (nonatomic ,retain)HQB_StudentMod *student;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)onbtnSax_Clicked:(id)sender {
    //找到资源路径
  NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Student" ofType:@"xml"];
    //创建url
    NSURL *url  = [[NSURL alloc]initFileURLWithPath:filePath];
    //根据url创建解析类
    NSXMLParser *parse = [[NSXMLParser alloc]initWithContentsOfURL:url];
    //设置代理
    parse.delegate = self;
    //开始解析
    [parse parse];
}
- (IBAction)onbtnDom_Clicked:(id)sender {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Student" ofType:@"xml"];
    
    NSError *error = nil;
    NSString *content = [[NSString alloc]initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    if (error == nil) {
        NSLog(@"%@",content);
        
    }else{
        NSLog(@"%@",error);
        return;
    }
    
    GDataXMLDocument *docment = [[GDataXMLDocument alloc]initWithXMLString:content options:0 error:nil];
    
    //取到根节点
    GDataXMLElement *rootElement = [docment rootElement];
    
    //查找子节点
   NSArray *studentElements = [rootElement elementsForName:@"student"];
    NSLog(@"%@",studentElements);
    self.studentArray = [NSMutableArray arrayWithCapacity:3];
    for (GDataXMLElement *element in studentElements) {
        
        HQB_StudentMod *student = [[HQB_StudentMod alloc]init];
        student.name = [[[element elementsForName:@"name"] firstObject] stringValue];
        student.age = [[[element elementsForName:@"age"] firstObject] stringValue];
         student.gender = [[[element elementsForName:@"gender"] firstObject] stringValue];
        [self.studentArray addObject:student];
        
    }
    NSLog(@"%@",self.studentArray);
    
}

#pragma mark - NSXMLParserDelegate
- (void)parserDidStartDocument:(NSXMLParser *)parser{
    NSLog(@"开始解析文档");
    self.studentArray = [NSMutableArray arrayWithCapacity:0];;
}
- (void)parserDidEndDocument:(NSXMLParser *)parser{
    NSLog(@"结束解析文档");
    for (HQB_StudentMod *student in self.studentArray) {
        NSLog(@"%@",student);
    }
}
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName attributes:(NSDictionary<NSString *, NSString *> *)attributeDict{
    NSLog(@"遇到开始标签:%@",elementName);
    if ([elementName isEqualToString:@"student"]) {
        self.student = [[HQB_StudentMod alloc]init];
        
    }
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName{
    NSLog(@"遇到结束标签:%@",elementName);
    if ([elementName isEqualToString:@"name"]) {
        self.student.name = self.string;
    }else if([elementName isEqualToString:@"age"]){
        self.student.age = self.string;
    }else if([elementName isEqualToString:@"gender"]){
        self.student.gender = self.string;
    }else if([elementName isEqualToString:@"student"]){
        [self.studentArray addObject:self.student];
    }
}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    NSLog(@"遇到解析的字符串：%@",string);
    self.string = string;
}
@end

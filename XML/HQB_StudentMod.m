//
//  HQB_StudentMod.m
//  XML
//
//  Created by HuangQibo on 16/9/6.
//  Copyright © 2016年 HuangQibo. All rights reserved.
//

#import "HQB_StudentMod.h"

@implementation HQB_StudentMod
- (NSString *)description
{
    return [NSString stringWithFormat:@"name:%@, age:%@,gender:%@",self.name,self.age,self.gender];
}
@end

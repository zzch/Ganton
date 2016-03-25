//
//  ZCPayByCardCell.h
//  Ganton
//
//  Created by hh on 16/3/21.
//  Copyright © 2016年 zhongchuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCPayByCardModel.h"
@interface ZCPayByCardCell : UITableViewCell

@property(nonatomic,strong)ZCPayByCardModel *payByCardModel;
+(instancetype)cellWithTableView:(UITableView *)tableView;
@end

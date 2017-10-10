//
//  XHRModel.swift
//  RxSwiftLearning
//
//  Created by xuhaoran on 2017/10/10.
//  Copyright © 2017年 xuhaoran. All rights reserved.
//

import Foundation
import RxDataSources
import ObjectMapper


struct XHRModel : Mappable {
    
    var _id             = ""
    var createdAt       = ""
    var desc            = ""
    var publishedAt     = ""
    var source          = ""
    var type            = ""
    var url             = ""
    var used            = ""
    var who             = ""
    
    
    init?(map: Map) {
        
    }
    
    // 使用 mutating 关键字修饰方法是为了能在该方法中修改 struct 或是 enum 的变量，在设计接口的时候，也要考虑到使用者程序的扩展性。所以要多考虑使用mutating来修饰方法。
    mutating func mapping(map: Map) {
        
        _id         <- map["_id"]
        createdAt   <- map["createdAt"]
        desc        <- map["desc"]
        publishedAt <- map["publishedAt"]
        source      <- map["source"]
        type        <- map["type"]
        url         <- map["url"]
        used        <- map["used"]
        who         <- map["who"]
        
    }
    
}




/* ============================= SectionModel =============================== */

struct XHRSection {
    
    // items就是rows
    var items: [Item]
    // 你也可以这里加你需要的东西，比如 headerView 的 title

}


extension XHRSection : SectionModelType{
    
    typealias Item = XHRModel
    
    init(original: XHRSection, items: [XHRSection.Item]) {
        self = original
        self.items = items
    }
}

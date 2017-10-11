//
//  XHRViewModel.swift
//  RxSwiftLearning
//
//  Created by xuhaoran on 2017/10/11.
//  Copyright © 2017年 xuhaoran. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

enum XHRRefreshStatus {
    case none
    case beginHeaderRefresh
    case endHeaderRefresh
    case beginFooterRefresh
    case endFootorRefresh
    case noMoreData
}


class XHRViewModel: NSObject {

    // 存放着解析完成的模型数组
    let modelArray = Variable<[XHRModel]>([])
    // 记录当前的索引值
    var index :Int = 1
    
   
    
    
}


extension XHRViewModel : XHRViewModelType{
    
    
    typealias Input = XHRInput
    
    typealias Output = XHROutput
    
    struct XHRInput {
        
        // 网络请求类型
        let category : NetworkTool.NetworkCatagory
        
        init(catagory : NetworkTool.NetworkCatagory) {
            self.category = catagory
        }
    }
    
    struct XHROutput {
        
        // tableView的sections数据
        let sections : Driver<[XHRSection]>
        // 外界通过该属性告诉viewModel加载数据（传入的值是为了标志是否重新加载）
        let requestCommod = PublishSubject<Bool>()
        // 告诉外界的tableView当前的刷新状态
        let refreshStatus = Variable<XHRRefreshStatus>(.none)
        
        init(sections: Driver<[XHRSection]>) {
            self.sections = sections
        }
        
    }
    
    
    func transform(input: XHRViewModel.XHRInput) -> XHRViewModel.XHROutput {
        
        let sections = modelArray.asObservable().map { (modelArray) -> [XHRSection] in
            
            // 当models的值被改变时会调用
            return [XHRSection(items:modelArray)]
        }.asDriver(onErrorJustReturn: [])
        
        let output = XHROutput(sections : sections)
        
        xhrNetManager.request(.data(type : input.category , size : 10 , index : self.index)) { [weak self] (event) in
            
            
            
        }
        
        return output
    }
    
}



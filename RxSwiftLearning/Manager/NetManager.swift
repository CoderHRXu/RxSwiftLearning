//
//  NetManager.swift
//  RxSwiftLearning
//
//  Created by xuhaoran on 2017/10/10.
//  Copyright © 2017年 xuhaoran. All rights reserved.
//

import Foundation
import Moya

enum NetworkTool {
    
    enum NetworkCatagory : String {
        case all            = "all"
        case android        = "Android"
        case ios            = "iOS"
        case welfare        = "福利"
    }
    
    case data(type : NetworkCatagory , size : Int , index : Int)
}


extension NetworkTool : TargetType {
    
    /// HTTP的请求header参数
    var headers: [String : String]? {
        return nil
    }
    
    /// baseURL 统一基本的URL
    var baseURL : URL{
        return URL(string : "http://gank.io/api/data")!
    }
    
    /// path字段会追加至baseURL后面
    var path : String {
        
        switch self {
        case .data(type: let type , let size, let index):
            return "\(type.rawValue)/\(size)/\(index)"
        }
        
    }

    /// HTTP的请求方式
    var method: Moya.Method {
        
        return .get
    }
    
    /// 请求参数(会在请求时进行编码)
    var parameters :[String : Any]? {
        
        return nil
    }
    
    /// 参数编码方式(这里使用URL的默认方式)
    var parameterEncoding : ParameterEncoding {
        
        return URLEncoding.default
    }
    
    var sampleData : Data{
        return "Xuhaoran".data(using: .utf8)!
    }
    
    /// 将要被执行的任务(请求：request 下载：upload 上传：download)
    var task : Task {
        return .requestPlain
    }
    
    /// 是否执行Alamofire验证，默认值为false
    var validate : Bool {
        return false
    }
    
    
}

let xhrNetManager = RxMoyaProvider<NetworkTool>()



//
//  XHRViewModelType.swift
//  RxSwiftLearning
//
//  Created by xuhaoran on 2017/10/11.
//  Copyright © 2017年 xuhaoran. All rights reserved.
//

import UIKit

protocol XHRViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}

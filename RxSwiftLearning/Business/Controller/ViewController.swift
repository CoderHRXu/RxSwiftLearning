//
//  ViewController.swift
//  RxSwiftLearning
//
//  Created by xuhaoran on 2017/10/10.
//  Copyright © 2017年 xuhaoran. All rights reserved.
//

import UIKit
import Then
import RxSwift
import RxCocoa
import NSObject_Rx
import RxDataSources
import SnapKit
import Moya
import Kingfisher
import MJRefresh


class ViewController: UIViewController {

    // MARK:- property
    
    let dataSource = RxTableViewSectionedReloadDataSource<XHRSection>()
    let tableView = UITableView().then {
        $0.backgroundColor = UIColor.red
        $0.rowHeight = ItemCell.cellHeight()
        $0.register(cellType: ItemCell.self)
    }
    
    // MARK:- lifeCyle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK:- UI
    fileprivate func setupUI(){
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(view)
            make.top.equalTo(view.snp.top).offset(20)
        }
        
        // 使用数据源属性绑定我们的cell
        dataSource.configureCell = { ds, tableView, indexPath, item in
            // 这个地方使用了Reusable这个库，在LXFViewCell中遵守了相应的协议
            // 使其方便转换cell为非可选型的相应的cell类型
            let cell = tableView.dequeueReusableCell(for: indexPath) as ItemCell
            cell.picView.kf.setImage(with: URL(string: item.url))
            cell.desLabel.text = "描述:\(item.desc)"
            cell.sourceLabel.text = "来源:\(item.source)"
            return cell
        }
        
        tableView.rx.setDelegate(self as! UITableViewDelegate).addDisposableTo(disposeBag)
        
    }

}


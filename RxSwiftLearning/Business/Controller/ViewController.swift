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
import PKHUD

class ViewController: UIViewController {

    // MARK:- property
    let viewModel = XHRViewModel()
    let dataSource = RxTableViewSectionedReloadDataSource<XHRSection>()
    let tableView = UITableView().then {
        $0.backgroundColor = UIColor.red
        $0.rowHeight = ItemCell.cellHeight()
        $0.register(cellType: ItemCell.self)
    }
    
    // MARK:- lifeCyle
    override func viewDidLoad() {
        super.viewDidLoad()
      
        setupUI()
        tableView.mj_header.beginRefreshing()
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        HUD.show(.label("内容测试"))
        HUD.flash(.progress)
        HUD.flash(.progress, onView: view)
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2) {
//            HUD.hide()
//        }
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
        
        // 设置代理
        tableView.rx.setDelegate(self as! UIScrollViewDelegate ).addDisposableTo(disposeBag)
        
        let vmInput = XHRViewModel.XHRInput(catagory: .welfare)
        let vmOutput = viewModel.transform(input: vmInput)
        
        vmOutput.sections.asDriver().drive(tableView.rx.items(dataSource: dataSource)).addDisposableTo(rx.disposeBag)
        
        vmOutput.refreshStatus.asObservable().subscribe(onNext: { [weak self] status in
            
            switch status{
            case .beginHeaderRefresh:
                self?.tableView.mj_header.beginRefreshing()
            case .endHeaderRefresh:
                self?.tableView.mj_header.endRefreshing()
            case .beginFooterRefresh:
                self?.tableView.mj_footer.beginRefreshing()
            case .endFootorRefresh:
                self?.tableView.mj_footer.endRefreshing()
            default:
                break
            }
            
            self?.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock:{
                
                vmOutput.requestCommod.onNext(true)
            })
            
            self?.tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
                vmOutput.requestCommod.onNext(false)
            })
            
            }, onError: { error in
                print(error)
        }, onCompleted: {
            
        }).addDisposableTo(rx.disposeBag)
        
        
    }

}


extension ViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

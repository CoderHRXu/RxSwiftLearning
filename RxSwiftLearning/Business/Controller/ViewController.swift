//
//  ViewController.swift
//  RxSwiftLearning
//
//  Created by xuhaoran on 2017/10/10.
//  Copyright © 2017年 xuhaoran. All rights reserved.
//

import UIKit
import Then



class ViewController: UIViewController {

    // MARK:- property
    
    let tableView = UITableView().then {
        
        $0.backgroundColor = UIColor.red
        
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


}


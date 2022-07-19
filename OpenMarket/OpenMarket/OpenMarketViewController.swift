//
//  OpenMarket - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class OpenMarketViewController: UIViewController {
    @IBOutlet weak var segmentSwitch: UISegmentedControl!
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    
    let jsonParser = JSONParser()    
    var productListItemSettableDelegate: ProductListItemSettable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentSwitch.selectedSegmentIndex = 0
        getProuctData()
    }
    
    @IBAction func switchView(_ sender: UISegmentedControl) {
        print(sender.selectedSegmentIndex)
        switch sender.selectedSegmentIndex {
        case 0:
            firstView.alpha = 1
            secondView.alpha = 0
        case 1:
            firstView.alpha = 0
            secondView.alpha = 1
        default:
            break
        }
    }
    
    func getProuctData() {
        let firstViewController = FirstViewController()
        self.productListItemSettableDelegate = firstViewController

        self.jsonParser.dataTask(by: "https://market-training.yagom-academy.kr/api/products", completion: { (response) in
            switch response {
            case .success(let data):
                self.productListItemSettableDelegate?.setData(data)
                
            case .failure(let data):
                print(data)
            }
        })
    }
}

protocol ProductListItemSettable: AnyObject {
    func setData(_ item: ProductListResponse)
}

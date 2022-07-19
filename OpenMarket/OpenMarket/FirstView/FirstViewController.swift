
//
//  FirstViewController.swift
//  OpenMarket
//
//  Created by 허건 on 2022/07/17.
//

import UIKit

class FirstViewController: UIViewController {
    var productListResponse: ProductListResponse?
    let jsonParser = JSONParser()
    
    @IBOutlet weak var productCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productCollectionView.delegate = self
        productCollectionView.dataSource = self
        self.getProuctData()
        print(self.productListResponse)
    }
    
    func getProuctData() {
        
        self.jsonParser.dataTask(by: "https://market-training.yagom-academy.kr/api/products", completion: { (response) in
            switch response {
            case .success(let data):
                DispatchQueue.global().sync {
                    self.productListResponse = data
                }
                print(self.productListResponse)
                
            case .failure(let data):
                print(data)
            }
        })
    }
}

extension FirstViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCollectionViewCell
        cell.myLabel.text = productListResponse?.pages[indexPath.row].name
        return cell
    }
}

extension FirstViewController: ProductListItemSettable {
    func setData(_ item: ProductListResponse) {
        self.productListResponse = item
    }
}

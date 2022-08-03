//
//  OpenMarket - MainViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit


final class MainViewController: UIViewController {
    @IBOutlet weak var segmentSwitch: UISegmentedControl!
    @IBOutlet weak var collectionListView: UIView!
    @IBOutlet weak var collectionGridView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSegmentSwitch()
    }
    
    @IBAction private func switchView(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            collectionListView.alpha = 1
            collectionGridView.alpha = 0
        case 1:
            collectionListView.alpha = 0
            collectionGridView.alpha = 1
        default:
            break
        }
    }
    
    @IBAction private func switchAddProductView(_ sender: UIButton) {
        guard let addProductViewController = self.storyboard?.instantiateViewController(withIdentifier: "addProductViewController") as? AddProductViewController else { return }
        addProductViewController.modalTransitionStyle = .coverVertical
        addProductViewController.modalPresentationStyle = .fullScreen
                self.present(addProductViewController, animated: true, completion: nil)
    }
    
    private func setSegmentSwitch() {
        segmentSwitch.selectedSegmentTintColor = .systemBlue
        segmentSwitch.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        segmentSwitch.setTitleTextAttributes([.foregroundColor: UIColor.systemBlue], for: .normal)
        segmentSwitch.layer.borderWidth = 1
        segmentSwitch.layer.borderColor = UIColor.systemBlue.cgColor
    }
    
    func patchRequest() {
        let parmtersValue = ["name": "브래드의 맥북", "secret": "aJo1WTMl7u"] as [String : Any]
        
        guard let jsonParams = try? JSONSerialization.data(withJSONObject: parmtersValue, options: .prettyPrinted) else {
            return
        }
        
        guard let url = URL(string: "https://market-training.yagom-academy.kr/api/products/4089") else {
            return
        }
        var request = URLRequest(url: url)
        
        // Header
        request.addValue("fa69efb9-0335-11ed-9676-1db1453669a0", forHTTPHeaderField: "identifier")
        
        // Method
        request.httpMethod = "PATCH"

        // Body
        request.httpBody = String(data: jsonParams, encoding: .utf8)!.data(using: .utf8)!
        
        // Print Body
        print(String(decoding: request.httpBody!, as: UTF8.self))

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("data",String(describing: error))
                return
            }

            print("result", String(data: data, encoding: .utf8)!)
        }
        task.resume()
    }
    
    func checkSeret()  -> String {
        var productSecret = ""
        
        let parmtersValue = ["secret": "aJo1WTMl7u"] as [String : String]
        
        guard let jsonParams = try? JSONSerialization.data(withJSONObject: parmtersValue, options: .prettyPrinted) else {
            return ""
        }
        
        guard let url = URL(string: "https://market-training.yagom-academy.kr/api/products/4089/secret") else {
            return ""
        }
        var request = URLRequest(url: url)
        
        // Header
        request.addValue("fa69efb9-0335-11ed-9676-1db1453669a0", forHTTPHeaderField: "identifier")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        // Method
        request.httpMethod = "POST"

        // Body
        request.httpBody = String(data: jsonParams, encoding: .utf8)?.data(using: .utf8)

        // Print Body
        print(String(decoding: request.httpBody!, as: UTF8.self))
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("data",String(describing: error))
                // print(data)
                return
            }
            print("result", String(data: data, encoding: .utf8)!)
            productSecret = String(data: data, encoding: .utf8)!
        }
        task.resume()
        return productSecret
    }
    
    func deleteRequest(productSecret: String) {
        guard let url = URL(string: "https://market-training.yagom-academy.kr/api/products/4089/\(productSecret)") else {
            return
        }
        var request = URLRequest(url: url)
        request.addValue("fa69efb9-0335-11ed-9676-1db1453669a0", forHTTPHeaderField: "identifier")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpMethod = "DELETE"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("data",String(describing: error))
                return
            }

            print("result", String(data: data, encoding: .utf8)!)
        }
        task.resume()
    }
}


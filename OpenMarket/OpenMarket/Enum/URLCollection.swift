//
//  URLCollection.swift
//  OpenMarket
//
//  Created by BaekGom, Brad on 2022/07/12.
//

import Foundation

enum URLCollection {
    static let hostURL = "https://openmarket.yagom-academy.kr"
    case healthChecker
    case productList(pageNumber: Int, itemsPerPage: Int)
    case productDetail(productNumber: Int)
    case productPost
    case productPatch(productIdentifier: Int)
    
    var string: String {
        switch self {
        case .healthChecker:
            return "/healthChecker"
        case .productList(let pageNumber, let itemsPerPage):
            return "/api/products?page_no=\(pageNumber)&items_per_page=\(itemsPerPage)"
        case .productDetail(let productNumber):
            return "/api/products/\(productNumber)"
        case .productPost:
            return "/api/products/"
        case .productPatch(let productIdentifier):
            return "/api/products/\(productIdentifier)"
        }
    }
}

enum VendorInfo {
    static let identifier = "f67d572f-4aa2-11ed-a200-8ba6a006f5ab"
    static let secret = "z1xc3q4v12b3b1ja3ou"
}

enum HTTPMethod {
    static let post = "POST"
    static let put = "PUT"
    static let get = "GET"
    static let delete = "DELETE"
}

enum CurrencyType {
    static let krw = "KRW"
    static let usd = "USD"
}


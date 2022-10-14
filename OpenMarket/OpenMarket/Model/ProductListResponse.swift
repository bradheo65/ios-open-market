//
//  ProductListResponse.swift
//  OpenMarket
//
//  Created by BaekGom, Brad on 2022/07/11.
//

struct ProductListResponse: Decodable {
    let pageNo: Int
    let itemsPerPage: Int
    let totalCount: Int
    let offset: Int
    let limit: Int
    let hasNext: Bool
    let hasPrev: Bool
    let pages: [Product]
}

extension ProductListResponse {
    enum CodingKeys: String, CodingKey {
        case pageNo
        case itemsPerPage
        case totalCount
        case offset
        case limit
        case hasNext
        case hasPrev
        case pages
    }
}

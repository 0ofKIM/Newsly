//
//  ViewController.swift
//  Newsly
//
//  Created by 0ofKim on 7/20/25.
//

import Foundation

struct NaverNewsResponse: Codable {
    let lastBuildDate: String?
    let total: Int?
    let start: Int?
    let display: Int?
    let items: [NewsItem]
}

struct NewsItem: Codable, Hashable {
    var id: String { originallink }
    let title: String
    let originallink: String
    let link: String
    let description: String
    let pubDate: String

    private enum CodingKeys: String, CodingKey {
        case title, originallink, link, description, pubDate
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: NewsItem, rhs: NewsItem) -> Bool {
        lhs.id == rhs.id
    }
}

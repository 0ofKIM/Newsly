//
//  APIClient.swift
//  Newsly
//
//  Created by 0ofKim on 7/24/25.
//

import Alamofire

class APIClient {
    static let shared = APIClient()

    func request<T: Decodable>(
        url: String,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        headers: HTTPHeaders? = nil,
        completion: @escaping (Result<T, AFError>) -> Void
    ) {
        AF.request(url, method: method, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .validate()
            .responseDecodable(of: T.self) { response in
                completion(response.result)
            }
    }
}

extension APIClient {
    func fetchNaverNews(
        query: String,
        display: Int = 10,
        start: Int = 1,
        sort: String = "sim",
        completion: @escaping (Result<NaverNewsResponse, AFError>) -> Void
    ) {
        let url = "https://openapi.naver.com/v1/search/news.json"
        let parameters: Parameters = [
            "query": query,
            "display": display,
            "start": start,
            "sort": sort
        ]
        let headers: HTTPHeaders = [
            "X-Naver-Client-Id": "bcd6bQ5YytqWh8pSBmjr",
            "X-Naver-Client-Secret": "Irpv2vYcdD"
        ]
        request(
            url: url,
            method: .get,
            parameters: parameters,
            headers: headers,
            completion: completion
        )
    }
}

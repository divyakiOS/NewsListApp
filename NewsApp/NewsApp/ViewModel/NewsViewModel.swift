//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by RAC INFRA RENTAL LLP on 14/09/19.
//  Copyright © 2019 RAC INFRA RENTAL LLP. All rights reserved.
//

import Foundation

class NewsViewModel: NSObject {
    
    private var newsModel: NewsModel?
    var errorMessage: String?
    
    
    func getNewsListApi(completion: @escaping ((NewsModel?) -> ())) {
        
        APIService.serviceRequest(newsRequest, NewsModel.self) { [weak self] (data, error) in
            
            guard let weakSelf = self else {
                return
            }
            
            guard error == nil else {
                weakSelf.errorMessage = error?.localizedDescription
                completion(nil)
                return
            }
            
            guard let data = data as? NewsModel else {
                weakSelf.errorMessage = "No items, please try again"
                completion(nil)
                return
            }
            weakSelf.newsModel = data
            completion(data)
        }
        
    }
    
   
    
    var newsList: [NewsModel.News] {
        
        return newsModel?.newsList ?? []
    }
    
   
    
    private var newsUrl: String {
        return baseUrl + AppUrl.newsApi.url
    }
    
    private var newsRequest:URLRequest  {
        let urlRequest = URLRequest.getRequestWithdefaultConfiguration(newsUrl)
        return urlRequest!
    }
    
}

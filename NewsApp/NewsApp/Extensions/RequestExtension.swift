//
//  RequestExtension.swift
//  NewsApp
//
//  Created by RAC INFRA RENTAL LLP on 14/09/19.
//  Copyright © 2019 RAC INFRA RENTAL LLP. All rights reserved.
//

import Foundation

extension URLRequest {
    
    // GET request with headers
    
    static func getRequestWithdefaultConfiguration(_ urlString: String?) -> URLRequest? {
        guard var urlRequest = urlRequestWithDefaultConfig(urlString) else {
            return nil
        }
        urlRequest.httpMethod = kGetMethod
        urlRequest.addHeaders(request: &urlRequest)

        return urlRequest
    }
    

    static func postRequestWithdefaultConfiguration(_ urlString: String?, requestJson: [String : Any]?) -> URLRequest? {
        guard var urlRequest = urlRequestWithDefaultConfig(urlString) else {
            return nil
        }
        urlRequest.httpMethod = kPostMethod
        urlRequest.addHeaders(request: &urlRequest)
        urlRequest.setValue(kContentTypeValue, forHTTPHeaderField: kContentTypeKey)

        if let requestBody = requestJson {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: requestBody, options: .prettyPrinted)
            } catch {
                debugPrint("Unexpected error: \(error).")
            }
        }
        
        return urlRequest
    }
    
    private func addHeaders( request: inout URLRequest)  {
        
        request.addValue(kConsumerSecretValue, forHTTPHeaderField: kConsumerSecretKey)
        request.addValue(kConsumerValue, forHTTPHeaderField: kConsumerKey)
        
    }
    
    
    private static func urlRequestWithDefaultConfig(_ urlString: String?) -> URLRequest? {
        guard let givenURLString = urlString, let urlComponent = URLComponents.init(string: givenURLString), let url = urlComponent.url else {
            return nil
        }
        
        return URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 10)
    }
    
}



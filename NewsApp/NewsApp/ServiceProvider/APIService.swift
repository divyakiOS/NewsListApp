//
//  APIService.swift
//  NewsApp
//
//  Created by RAC INFRA RENTAL LLP on 14/09/19.
//  Copyright © 2019 RAC INFRA RENTAL LLP. All rights reserved.
//

import Foundation

enum ServiceError: Error {
    case urlError(_ reason: String)
    case objectSerialization(_ reason: String)
}

class APIService: NSObject {
    
    static func serviceRequest<T: Decodable>(_ urlRequest: URLRequest?,_ resultModel: T.Type, completion: @escaping ((Any?, Error?) -> ())) {
        
        guard let request = urlRequest, let _ = request.url else  {
            let error = ServiceError.urlError("Could not find URL")
            completion(nil, error)
            return
        }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            guard error == nil else {
                completion(nil, error)
                return
            }
            
            guard let responseData = data, let httpResponse = response as? HTTPURLResponse else {
                let error = ServiceError.objectSerialization("No data in response")
                completion(nil, error)
                return
            }
            debugPrint(httpResponse.statusCode)
            
            guard  httpResponse.statusCode == 200 else {
                let error = ServiceError.objectSerialization("No data in response")
                completion(nil, error)
                return
            }
            
            do {
                let resultantModel = try JSONDecoder().decode(resultModel.self, from: responseData)
                completion(resultantModel, nil)
            } catch {
                debugPrint("error trying to convert data to JSON")
                debugPrint(error)
                completion(nil, error)
            }
        }
        
        task.resume()
        
    }
}

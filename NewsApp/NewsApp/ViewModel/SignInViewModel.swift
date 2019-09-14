//
//  SignInViewModel.swift
//  NewsApp
//
//  Created by RAC INFRA RENTAL LLP on 14/09/19.
//  Copyright © 2019 RAC INFRA RENTAL LLP. All rights reserved.
//

import UIKit

class SignInViewModel: NSObject {
    
    var body : [String: Any] = [:]
    var errorMessage: String?
    
   
    //SignIn Api Call
    
    func getSignInData(completion: @escaping ((SignInModel?) -> ())) {
        
        APIService.serviceRequest(SignInRequest, SignInModel.self) { [weak self] (data, error) in
            
            guard let weakSelf = self else {
                return
            }
            
            guard error == nil else {
                weakSelf.errorMessage = error?.localizedDescription
                completion(nil)
                return
            }
            
            guard let model = data as? SignInModel else {
                weakSelf.errorMessage = "No items, please try again"
                completion(nil)
                return
            }
            
            if let success = model.success, success == false {
                weakSelf.errorMessage = model.message
                completion(nil)
                return
            }
            completion(model)
        }
        
    }
    
    //MARK:  Validation
    
    let isValid:(String) -> (Bool) = { name in
        
        return !name.isEmpty
    }
    
    let isValidEmail: (String) -> Bool = { email in
        
        guard !email.isEmpty else { return false}
        
        return NSPredicate(format: kSelfMatches, kEmailRegex).evaluate(with: email)
    }
    
    let isValidMobile: (String) -> Bool = { mobile in
        
        guard !mobile.isEmpty else { return false}
        
        return NSPredicate(format: kSelfMatches, kMobileNumberRegex).evaluate(with: mobile)
    }
    
   
    private var SignInUrl : String {
        return baseUrl + AppUrl.loginApi.url
    }
    
    private var SignInRequest : URLRequest {
        
        return URLRequest.postRequestWithdefaultConfiguration(SignInUrl, requestJson: body)!
    }
    
}

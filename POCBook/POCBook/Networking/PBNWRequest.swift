//
//  PBNWRequest.swift
//  POCBook
//
//  Created by rahul mahajan on 06/01/17.
//  Copyright © 2017 rahul mahajan. All rights reserved.
//

import UIKit

typealias PBNWRequestCompletionHandler = (URLResponse?, Any? , Error?)->Void

class PBNWRequest {
    
    var requestURL      : URL
    var requestTag      : String
    var httpMethod      : HTTPMethod
    var shouldParseJSON : Bool
    
    var contentType     : String?{
        set{
            requestHeaders[PBConstants.Network.contentType] = newValue
        }
        get{
            return requestHeaders[PBConstants.Network.contentType]
        }
    }
    
    var postData        : Data?{
        willSet{
            httpMethod = HTTPMethod.POST
        }
    }

    var requestHeaders   =  Dictionary<String,String>()
    
    init(url : String, params : Dictionary<String,String>?, tag : String, parseJson:Bool) {
        requestTag = tag
        shouldParseJSON = parseJson
        httpMethod = HTTPMethod.GET
        if let parameters = params {
            requestURL = URL(string: url + PBNWRequest.queryString(parameters: parameters))!
        }
        else{
            requestURL = URL(string: url)!
        }
    }
    
    static func queryString(parameters : Dictionary<String,String>) -> String {
        var result = "?"
        var isFirstVal = true
        for (key , value) in parameters {
            let encodedKey = key.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            let encodedValue = value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            result += isFirstVal ? "\(encodedKey)=\(encodedValue)" : "&\(encodedKey)=\(encodedValue)"
            isFirstVal = false
        }
        return result
    }
    
    func urlRequest() -> URLRequest {
        var request = URLRequest(url: requestURL)
        request.httpMethod = httpMethod.rawValue
        
        if let data = postData {
            request.httpBody = data
            request.setValue(String(data.count), forHTTPHeaderField: PBConstants.Network.contentLength)
        }
    
        for (field, value) in requestHeaders {
            request.setValue(value, forHTTPHeaderField: field)
        }
        
        return request
    }
    
    func loadRequest(completion : @escaping PBNWRequestCompletionHandler) -> Void {
        URLSession.shared.dataTask(with: urlRequest()) { (data, response, requestError) in
            
            if (requestError != nil) {
                completion(response,nil,requestError)
            } else {
                if let respData = data{
                    if self.shouldParseJSON {
                        do{
                            let jsonResult = try JSONSerialization.jsonObject(with: respData, options: JSONSerialization.ReadingOptions.mutableContainers)
                            completion(response,jsonResult,nil)
                        }
                        catch {
                            completion(response,nil,error)
                        }
                    }
                }
            }
        }.resume()
    }

}

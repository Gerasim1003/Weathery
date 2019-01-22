//
//  NetworkProcessor.swift
//  Weathery
//
//  Created by Gerasim Israyelyan on 1/21/19.
//  Copyright © 2019 Gerasim Israyelyan. All rights reserved.
//

import Foundation

class NetworkProcessor {
    
    lazy var configuration: URLSessionConfiguration = URLSessionConfiguration.default
    lazy var session: URLSession = URLSession(configuration: self.configuration)
    
    let url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    typealias JSONDictonaryHandler = (([String: Any]?) -> Void)
    
    func downloadJSONFromUrl(_ completion: @escaping JSONDictonaryHandler) {
        let request = URLRequest(url: self.url)
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if error == nil {
                
                if let httpResponse = response as? HTTPURLResponse {
                    switch httpResponse.statusCode {
                    case 200 :
                        //seccessful response
                        if let data = data {
                            do {
                                let jsonDictonary = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                                completion(jsonDictonary as? [String : Any])
                            } catch let error as NSError {
                                print("error processing json data : \(error.localizedDescription)")
                            }
                            
                        }
                    default:
                        print("statusCode : \(httpResponse.statusCode )")
                        
                    }
                }
                
            } else {
                print("Error : \(String(describing: error?.localizedDescription))")
            }
        }
        dataTask.resume()
    }
}

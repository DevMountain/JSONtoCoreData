//
//  NetworkController.swift
//  JSONtoCoreData
//
//  Created by Caleb Hicks on 2/4/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

class NetworkController {
    
    static func dataAtURL(url: NSURL, completion:(resultData: NSData?) -> Void) {
        let session = NSURLSession.sharedSession()
        
        let dataTask = session.dataTaskWithURL(url) { (data, _, error) -> Void in
            
            guard let data = data  else {
                print(error?.localizedDescription)
                completion(resultData: nil)
                return
            }
            
            completion(resultData: data)
        }
        
        dataTask.resume()
    }
}
//
//  PostController.swift
//  JSONtoCoreData
//
//  Created by Caleb Hicks on 2/4/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation
import CoreData

class PostController {
    
    var posts: [Post] {
        
        let request = NSFetchRequest(entityName: "Post")
        
        if let posts = try? Stack.sharedStack.managedObjectContext.executeFetchRequest(request) as! [Post] {
            
            return posts
        } else { return [] }
    }
    
    static let sharedController = PostController()
    
    static func fetchCurrentPosts(subreddit: String, completion: () -> Void) {
        
        NetworkController.dataAtURL(NSURL(string: "https://reddit.com/r/\(subreddit)/.json")!) { (resultData) in
            
            if let data = resultData {
                
                if let subRedditData = try! NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as? [String: AnyObject] {
                    
                    if let postDictionaries = subRedditData["data"]?["children"] as? [[String: AnyObject]] {
                        
                        for postDictionary in postDictionaries {
                            
                            if let postData = postDictionary["data"] as? [String: AnyObject] {
                                
                                self.insertOrUpdatePost(postData)
                            }
                        }
                    }
                    
                    completion()
                }
            }
        }
    }
    
    static func insertOrUpdatePost(json: [String: AnyObject]) {
        
        guard let identifier = json["id"] as? String else { return }
        
        if let matchingPost = self.sharedController.posts.filter({$0.identifier == identifier}).first {
            
            matchingPost.update(json)
            
        } else {
            
            let _ = Post(json: json)
        }
        
        try! Stack.sharedStack.managedObjectContext.save()
    }
    
}
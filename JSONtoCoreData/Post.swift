//
//  Post.swift
//  JSONtoCoreData
//
//  Created by Caleb Hicks on 2/4/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation
import CoreData


class Post: NSManagedObject {
    
    convenience init(title: String, url: String, identifier: String, context: NSManagedObjectContext = Stack.sharedStack.managedObjectContext) {
        
        let entity = NSEntityDescription.entityForName("Post", inManagedObjectContext: context)!
        
        self.init(entity: entity, insertIntoManagedObjectContext: context)
        
        self.title = title
        self.url = url
        self.identifier = identifier
    }
    
    convenience init?(json: [String: AnyObject], context: NSManagedObjectContext = Stack.sharedStack.managedObjectContext) {
        
        let entity = NSEntityDescription.entityForName("Post", inManagedObjectContext: context)!
        
        self.init(entity: entity, insertIntoManagedObjectContext: context)
        
        guard let title = json["title"] as? String,
            let url = json["url"] as? String,
            let subreddit = json["subreddit"] as? String,
            let identifier = json["id"] as? String else { return nil }
        
        self.title = title
        self.url = url
        self.subreddit = subreddit
        self.identifier = identifier
    }
    
    func update(json: [String: AnyObject]) {

        guard let title = json["title"] as? String,
            let url = json["url"] as? String,
            let subreddit = json["subreddit"] as? String,
            let identifier = json["id"] as? String else { return }
        
        self.title = title
        self.url = url
        self.subreddit = subreddit
        self.identifier = identifier
    }

}

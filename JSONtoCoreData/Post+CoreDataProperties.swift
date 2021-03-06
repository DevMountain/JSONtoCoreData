//
//  Post+CoreDataProperties.swift
//  JSONtoCoreData
//
//  Created by Caleb Hicks on 2/4/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Post {

    @NSManaged var title: String
    @NSManaged var url: String
    @NSManaged var subreddit: String
    @NSManaged var identifier: String

}

//
//  RealmData.swift
//  PhotoLog
//
//  Created by Lio on 2023/01/10.
//

import RealmSwift

class RealmData: Object {
    
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var date: Date = Date()
    @Persisted var image: String = ""
    @Persisted var title: String = ""
    @Persisted var content: String = ""
    
    convenience init(date: Date, image: String, title: String, content: String) {
        self.init()
        self.date = date
        self.image = image
        self.title = title
        self.content = content
    }
    
}

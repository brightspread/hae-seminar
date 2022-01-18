//
//  Seminar.swift
//  seminar-realm
//
//  Created by Jo on 2022/01/18.
//

import Foundation
import RealmSwift


class Seminar: Object {
    @objc dynamic var id: String = "" // 세미나 ID
    @objc dynamic var title: String = "" // 타이틀
    @objc dynamic var time: String = "" // 세미나 시간

    convenience init(_ seminar: Dictionary<String, Any>) {
         self.init(value:[
             "id" : seminar["id"],
             "title" : seminar["title"],
             "time" : seminar["time"]
         ])
     }
     
     override static func primaryKey() -> String? {
         return "id"
     }
}

//
//  Seminar.swift
//  seminar-realm
//
//  Created by Jo on 2022/01/18.
//

import Foundation
import RealmSwift

// 세미나
// - 세미나 ID
// - 세미나 제목
// - 세미나 일정

class Seminar: Object {
    @objc dynamic var id: String = "" // 세미나 ID
    @objc dynamic var title: String = "" // 타이틀
    @objc dynamic var time: String = "" // 세미나 일정

    convenience init(_ seminar: Dictionary<String, Any>) { // 세미나 db 생성
         self.init(value:[
             "id" : seminar["id"],
             "title" : seminar["title"],
             "time" : seminar["time"]
         ])
     }
     
     override static func primaryKey() -> String? { // pk 지정
         return "id"
     }
}

//
//  RealmManager.swift
//  seminar-realm
//
//  Created by Jo on 2022/01/18.
//

import Foundation
import RealmSwift

class RealmManager {
    public static let shared = RealmManager()
    private let realm = try! Realm()
    
    func add(_ object: RealmSwift.Object) {
        try! realm.write {
            realm.add(object)
        }
    }
    
    func delete(_ object: RealmSwift.Object) {
        try! realm.write {
            realm.delete(object)
        }
    }
    
    // 클래스 타입을 넘겨 전체 가져오기
    func fetch(_ type: RealmSwift.Object.Type) -> Results<RealmSwift.Object> {
        return realm.objects(type)
    }
}

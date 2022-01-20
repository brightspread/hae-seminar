//
//  RealmManager.swift
//  seminar-realm
//
//  Created by Jo on 2022/01/18.
//

import Foundation
import RealmSwift

class RealmManager {
    
    public static let shared = RealmManager() // 싱글톤
    
    private let realm = try! Realm()
    
    func add(_ object: RealmSwift.Object) { // db 추가
        try! realm.write {
            realm.add(object)
        }
    }
    
    func delete(_ object: RealmSwift.Object) { // db 삭제
        try! realm.write {
            realm.delete(object)
        }
    }
    
    // 클래스 타입을 넘겨 전체 가져오기
    func fetch(_ type: RealmSwift.Object.Type) -> Results<RealmSwift.Object> { // db 가져오기
        return realm.objects(type)
    }
    
    // priamry key를 넘겨 하나만 가져오기
    func fetch(type: RealmSwift.Object.Type, pk: String) -> RealmSwift.Object? {
        return realm.object(ofType: type, forPrimaryKey: pk)
    }
}

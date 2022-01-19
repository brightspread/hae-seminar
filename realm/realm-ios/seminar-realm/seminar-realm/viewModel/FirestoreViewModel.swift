//
//  FirestoreViewModel.swift
//  seminar-realm
//
//  Created by Jo on 2022/01/19.
//

import Foundation
import RealmSwift
import Firebase
import BoltsSwift

class FirestoreViewModel: NSObject, FirestoreVMProtocol {
    let db = Firestore.firestore()
    var seminars = Array<Seminar>()
    
    func getDB() {
        seminars.removeAll()
        db.collection("collection").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    self.seminars.append(Seminar(document.data()))
                }
            }
        }
    }
    
    func addDB() {
        let localSeminars = RealmManager.shared.fetch(Seminar.self)
        for seminar in localSeminars {
            db.collection("collection").addDocument(data: seminar.dictionaryWithValues(forKeys: ["id","title","time"]))
        }
    }
    
    func allSeminarString() -> String {
        var string = ""
        for seminar in seminars {
            string += "\(seminar.title) \(seminar.time)\n"
        }
        return string
    }
    
    // Next Step (Bolts)
    func getDBTask() -> Task<Array<Seminar>> {
        let taskCompletionSource = TaskCompletionSource<Array<Seminar>>()
        
        var seminarArray = Array<Seminar>()
        db.collection("collection").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                taskCompletionSource.set(error: err)
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    seminarArray.append(Seminar(document.data()))
                }
                taskCompletionSource.set(result: seminarArray)
            }
        }
        
        return taskCompletionSource.task
    }
    
    func allSeminarString(seminarArr: Array<Seminar>) -> String {
        var string = ""
        for seminar in seminarArr {
            string += "\(seminar.title) \(seminar.time)\n"
        }
        return string
    }
}


protocol FirestoreVMProtocol: FirestoreVMInput, FirestoreVMOutput {}

protocol FirestoreVMOutput {
    func allSeminarString() -> String
    func allSeminarString(seminarArr: Array<Seminar>) -> String
}

protocol FirestoreVMInput {
    func getDB()
    func addDB()
    func getDBTask() -> Task<Array<Seminar>>
}

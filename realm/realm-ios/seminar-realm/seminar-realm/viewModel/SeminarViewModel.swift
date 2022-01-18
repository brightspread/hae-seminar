//
//  SeminarViewModel.swift
//  seminar-realm
//
//  Created by Jo on 2022/01/18.
//

import Foundation
import RealmSwift

class SeminarViewModel: NSObject, SeminarVMProtocol {
    
    lazy var seminars = RealmManager.shared.fetch(Seminar.self)
    

    func allSeminarString() -> String {
        var string = ""
        fetchSeminar()
        for seminar in seminars {
            let semi = seminar as! Seminar
            string += "\(semi.title) \(semi.time)\n"
        }
        return string
    }
    
    
    func addSeminar(title: String, time: String) {
        RealmManager.shared.add(
            Seminar(["id": UUID().uuidString,
                     "title": title,
                     "time": time]))
    }
    
    func removeAllSeminar() {
        fetchSeminar()
        for seminar in seminars {
            RealmManager.shared.delete(seminar)
        }
        fetchSeminar()
    }
    
    private func fetchSeminar() {
        seminars = RealmManager.shared.fetch(Seminar.self)
    }

}

protocol SeminarVMProtocol: SeminarVMInput, SeminarVMOutput {}

protocol SeminarVMOutput {
    var seminars: Results<RealmSwift.Object> {get set}
    func allSeminarString() -> String
}

protocol SeminarVMInput {
    func addSeminar(title: String, time: String)
    func removeAllSeminar()
}

//
//  ViewController.swift
//  seminar-realm
//
//  Created by Jo on 2022/01/18.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    @IBOutlet weak var lbResult: UILabel!
    
    private let realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
        if let documentsPath = FileManager.default.urls(for:.documentDirectory, in: .userDomainMask).first?.path {
            print("Documents Directory: " + documentsPath) // DB 파일 확인을 위해 App 데이터 파일 위치 확인
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateSeminar()
    }
    
    // MARK: UI
    private func updateSeminar() {
        let seminars = fetchSeminar()
        var string = ""
        for seminar in seminars {
            string += "\(seminar.title) \(seminar.time)\n"
        }
        lbResult.text = string
    }
    
    func navigateToSeminarVC() {
        let seminarViewController = storyboard?.instantiateViewController(withIdentifier: "SeminarViewController") as! SeminarViewController
        seminarViewController.viewModel = SeminarViewModel()
        navigationController?.pushViewController(seminarViewController, animated: true)
    }
        
    // MARK: Button
    @IBAction func addButtonTouched(_ sender: Any) {
        var alert: UIAlertController!
        
        // alert 에서 추가 선택시 불리는 핸들러
        let addActionHandler: (UIAlertAction) -> Void = { _ in
            // 텍스트 필드에 입력한 내용 불러오기
            let title = alert.textFields![0].text!
            let time = alert.textFields![1].text!
            self.addSeminar(title: title, time: time)
            self.updateSeminar()
        }
        alert = createAddAlert(handler: addActionHandler)
        present(alert, animated: true)
    }
    
    @IBAction func deleteButtonTouched(_ sender: Any) {
        removeAllSeminar()
        updateSeminar()
    }
    
    @IBAction func mvvmButtonTouched(_ sender: Any) {
        navigateToSeminarVC()
    }
    
    // MARK: Realm
    private func fetchSeminar() -> Results<Seminar> {
        return realm.objects(Seminar.self)
    }
    
    private func addSeminar(title: String, time: String) {
        try! realm.write {
            realm.add(Seminar(["id": UUID().uuidString,
                               "title": title,
                               "time": time]))
        }
    }
    
    private func removeAllSeminar() {
        let seminars = fetchSeminar()
        try! realm.write {
            for seminar in seminars {
                realm.delete(seminar)
            }
        }
    }
    
    // MARK: Alert
    func createAddAlert(handler: @escaping (UIAlertAction) -> Void) -> UIAlertController {
        var alert: UIAlertController!
        alert = UIAlertController(title: "제목 및 시간을 입력하세요.", message: nil, preferredStyle: .alert)
        // 텍스트필드 추가
        alert.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "제목"
            // 포커스를 바로 텍스트필드로 이동
            textField.becomeFirstResponder()
        })
        // 텍스트필드 추가
        alert.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "시간"
        })
        let addAction = UIAlertAction(title: "추가", style: UIAlertAction.Style.destructive, handler: handler)
        alert.addAction(addAction)
        return alert
    }
}


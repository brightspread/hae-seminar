//
//  SeminarViewController.swift
//  seminar-realm
//
//  Created by Jo on 2022/01/18.
//

import UIKit

class SeminarViewController: UIViewController {

    var viewModel: SeminarViewModel!

    @IBOutlet weak var lbResult: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.title = "Realm 테스트 (MVVM 적용)"

        updateSeminar()
    }
    
    // db 업데이트 결과 불러오기
    func updateSeminar() {
        lbResult.text = viewModel.allSeminarString()
    }
    
    // db 추가하기
    @IBAction func addButtonTouched(_ sender: Any) {
        var alert: UIAlertController!
        
        // alert 에서 추가 선택시 불리는 핸들러
        let addActionHandler: (UIAlertAction) -> Void = { _ in
            // 텍스트 필드에 입력한 내용 불러오기
            let title = alert.textFields![0].text!
            let time = alert.textFields![1].text!
            self.viewModel.addSeminar(title: title, time: time)
            self.updateSeminar()
        }
        alert = createAddAlert(handler: addActionHandler)
        present(alert, animated: true)

    }
    
    @IBAction func deleteAllButtonTouched(_ sender: Any) {
        viewModel.removeAllSeminar()
        updateSeminar()
    }
    
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

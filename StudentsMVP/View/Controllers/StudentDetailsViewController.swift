//
//  StudentDetailsViewController.swift
//  testtt
//
//  Created by Volodymyr Rykhva on 07.07.2021.
//

import UIKit

final class StudentDetailsViewController: UIViewController, StudentDetailsPresenterProtocol {

    @IBOutlet private weak var studentImageView: UIImageView!
    @IBOutlet private weak var emailLabel: UILabel!
    
    //створюємо студента
    private var student: Student?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        //передаємо функцію для відображення даних в UI елементах
        renderStudent()
    }
    
    // MARK: - Private

    //Реалізовуємо обов'язкові функції протокола StudentDetailsPresenterProtocol,
    //до якого підпорядковується це вью - передаємо дані для відображення в UI елементах
    func renderStudent() {
        guard let student = student else { return }

        title = student.name
        studentImageView.load(url: student.logo)
        emailLabel.text = student.email
    }

    //сетимо студента - буде викорістовуватись для сігвея для переходу до цієї вьюшки
    //і передачі даних з таблички студентів до конкретного студента
    func setStudent(student: Student?) {
        self.student = student
    }
}

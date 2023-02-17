//
//  StudentsPresenter.swift
//  StudentsMVP
//
//  Created by Алина Власенко on 17.02.2023.
//

import Foundation
import UIKit

//протокол з функцією для передачі даних у UI елементи комірки
protocol StudentCellPresenterProtocol: AnyObject {
    func render(student: Student)
}

//протокол з функціями для передачі даних у UI елементи вьюшки з детальною інформацією студента
protocol StudentDetailsPresenterProtocol: AnyObject {
    func renderStudent()
    func setStudent(student: Student?)
}

//протокол з функцією для передачі даних студентів у табличку і оновлення таблички
protocol StudentsPresenterDelegate: AnyObject {
    func presentStudents(students: [Student])
}

//створимо псевдонім презентатора делегата
typealias PresenterStudentsDelegate = StudentsPresenterDelegate & UIViewController

//клас в якому усі налаштування для відображення даних студентів у табличці
class StudentsPresenter {
    //ми збираємося зберігати екземпляр делегату(це буде слабкий делегат - weak)
    weak var delegate: PresenterStudentsDelegate?
    
    //передаємо відповідальність доповідача за пошуком студентів
    public func getStudent() {
        guard let url = URL(
            string: "https://lynnvlasenko.github.io/studentsjson/") else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let students = try JSONDecoder().decode([Student].self, from: data)
                self?.delegate?.presentStudents(students: students)
            }
            
            catch {
                print(error)
            }
        }
        task.resume()
    }
    
    //створюємо делегат налаштувань перегляду і його типом будуть UserPresenterDelegate
    //& UIViewController(передані через псевдонім PresenterDelegate, створений вище.
    public func setViewDelegate(delegate: PresenterStudentsDelegate) {
        self.delegate = delegate
    }
    
}


//class StudentDetailsPresenter {
//    
//    weak var delegate: StudentDetailsPresenterProtocol?
//    
//    func renderStudent(student: Student?) {
//        //private var student: Student?
//        
//        guard let student = student else { return }
//        
////        title = student.name
////        studentImageView.load(url: student.logo)
////        emailLabel.text = student.email
//    }
//    
//    public func setViewDelegate(delegate: StudentDetailsPresenterProtocol) {
//        self.delegate = delegate
//    }
//}

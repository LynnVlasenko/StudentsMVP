//
//  ViewController.swift
//  testtt
//
//  Created by Volodymyr Rykhva on 28.06.2021.
//

import UIKit

final class StudentsViewController: UIViewController, StudentsPresenterDelegate {

    @IBOutlet private weak var studentTableView: UITableView!

    //створюємо порожній масив для студентів
    private var students: [Student] = []
    
    //створемо екземпляр нашого презентора
    private let presenter = StudentsPresenter()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        //реєструємо табличку(залишилось як у завданні з MVC)
        studentTableView.register(
            UINib.init(nibName: StudentTableViewCell.reuseIdentifier, bundle: nil),
            forCellReuseIdentifier: StudentTableViewCell.reuseIdentifier
        )
        studentTableView.tableFooterView = UIView()//робить під табличкою білий футер(додаючи вью), якщо без нього до будемо бачити під таблицею порожні целі
        title = "Students"
        //сетимо делегат
        presenter.setViewDelegate(delegate: self)
        //передаємо дані студентів з json (функція конвертує дані з посилання)
        presenter.getStudent()
    }

    //підготовка segue для переходу на інший екран з детальними даними студента
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? StudentDetailsViewController,

           let indexPath = sender as? IndexPath { //sender це підготовка сігвею
            destination.setStudent(student: students[indexPath.row]) //посилаємося на функцію яка була створена через протокол у StudentDetailsViewController для передачі даних для відображення конкретного студента
        }
    }
    
// MARK: - Presenter Delegate
    //виконуємо обов'язкову функцію протокола StudentsPresenterDelegate,
    //до якого підпорядковується це вью - презентуємо студентів і оновлюємо табличку
    func presentStudents(students: [Student]) {
        self.students = students
        
        DispatchQueue.main.async {
            self.studentTableView.reloadData()
        }
    }
}

// MARK: - Extensions for Table
extension StudentsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StudentTableViewCell.reuseIdentifier, for: indexPath)
        if let cell = cell as? StudentTableViewCell {
            cell.render(student: students[indexPath.row]) //посилаємося на функцію яка була створена через протокол у StudentTableViewCell для передачі даних для відображення у комірці
        }
        return cell
    }

    // ?? мабудь через presentor не вийде зробити didSelectRowAt, бо цей сігвей усім керую із сторіборда. Як би кодом, то можна було б реалізувати(бачила приклади)
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "StudentDetails", sender: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

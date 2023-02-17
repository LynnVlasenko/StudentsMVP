//
//  LessonTableViewController.swift
//  testtt
//
//  Created by Volodymyr Rykhva on 28.06.2021.
//

import UIKit

final class LessonTableViewController: UITableViewController, LessonsPresenterDelegate {

    //створюємо порожній масив для занять
    private var lessons = [Lesson]()

    //створемо екземпляр нашого презентора для занять
    private let presenter = LessonsPresenter()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Lessons"
        //сетимо делегат
        presenter.setViewDelegate(delegate: self)
        //передаємо дані студентів з json (функція конвертує дані з посилання)
        presenter.getLessons()
    }

    //залишита налаштування для таблички як і було у проекті MVC
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        lessons.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LessonsTableViewCell", for: indexPath)
        cell.textLabel?.text = lessons[indexPath.row].name
        cell.detailTextLabel?.text = lessons[indexPath.row].hours
        return cell
    }

    
    // MARK: - Presenter Delegate
    
    //виконуємо обов'язкову функцію протокола LessonsPresenterDelegate, до якого підпорядковується це вью
    //- презентуємо студентів і оновлюємо табличку
    func presentLessons(lessons: [Lesson]) {
        self.lessons = lessons
        
        DispatchQueue.main.async {
            self.tableView.reloadData()//перезавантажуємо данні, поставивши це у деспетчерську чергу
            //чому нам потрібно відправити головний потік тому,
            //що немає гарантії, що ця функція буде викликана в основному потоці.
        }
    }
}

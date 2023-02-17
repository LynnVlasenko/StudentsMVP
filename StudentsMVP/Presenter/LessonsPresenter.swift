//
//  LessonsPresenter.swift
//  StudentsMVP
//
//  Created by Алина Власенко on 17.02.2023.
//

import Foundation
import UIKit

//протокол з функцією для передачі даних занять у табличку і оновлення таблички
protocol LessonsPresenterDelegate: AnyObject {
    func presentLessons(lessons: [Lesson])
}

//створимо псевдонім презентатора делегата
typealias PresenterLessonsDelegate = LessonsPresenterDelegate & UIViewController

//клас в якому усі налаштування для відображення даних занять у табличці
class LessonsPresenter {
    //ми збираємося зберігати екземпляр делегату(це буде слабкий делегат - weak)
    weak var delegate: PresenterLessonsDelegate?
    
    public func getLessons () {
        guard let url = URL(
            string: "https://lynnvlasenko.github.io/lessonsjson.github.io/") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let lessons = try JSONDecoder().decode([Lesson].self, from: data)
                self?.delegate?.presentLessons(lessons: lessons)
            }
            
            catch {
                print(error)
            }
        }
        task.resume()
    }
    
    //створюємо делегат налаштувань перегляду
    public func setViewDelegate(delegate: PresenterLessonsDelegate) {
        self.delegate = delegate
    }

}


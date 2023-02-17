//
//  UIImageView+Extensions.swift
//  testtt
//
//  Created by Volodymyr Rykhva on 29.06.2021.
//

import UIKit

//екстеншн для витягування картинки з URL (деталі як воно працює розкажуть на наступних заняттях)
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

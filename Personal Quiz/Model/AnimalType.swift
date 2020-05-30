//
//  AnimalType.swift
//  Personal Quiz
//
//  Created by Павел on 29.05.2020.
//  Copyright © 2020 Павел. All rights reserved.
//

enum AnimalType: String {
    case dog = "🐶"
    case cat = "🐱"
    case rabbit = "🐰"
    case turtle = "🐢"
    
    var definition: String {
        switch self {
        case .dog:
            return "Вам нравится быть с друзьями и всегда готовы помочь!"
        case .cat:
            return "Гуляете сами по себе и цените одиночество!"
        case .rabbit:
            return "Вам нравится всё мягкоеб вы здоровы и полны энергии!"
        case .turtle:
            return "Медленный и вдумчивый выигрывает на дальних дистанциях!"
        }
    }
}

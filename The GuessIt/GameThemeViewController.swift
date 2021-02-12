//
//  GameThemeViewController.swift
//  The GuessIt
//
//  Created by Nick on 11.02.2021.
//

import UIKit
import AVFoundation

class GameThemeViewController: Main {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(topStackView)
        setupStackViews()
        createButtons()
        createReturnButton()
        updateUI(to: view.bounds.size)
    }
    
    private func createButtons() {
        //let scaler = min(view.bounds.height, view.bounds.width)
        let viewButtons = [UIButton(),UIButton(),UIButton(), UIButton(), UIButton()]
        let viewButtonsName = ["", "Столицы", "Фрукты?", "Покемоны", ""]

        for i in 0..<viewButtons.count {
            if viewButtonsName[i] != "" {
                viewButtons[i].setTitleColor(.black, for: [])
                viewButtons[i].backgroundColor = .yellow
                viewButtons[i].layer.cornerRadius = 50
                viewButtons[i].tintColor = .black
                viewButtons[i].titleLabel?.font = UIFont.boldSystemFont(ofSize: Main.fontScaler)
                viewButtons[i].setTitle(viewButtonsName[i], for: [])
                viewButtons[i].titleLabel?.textAlignment = .center
                viewButtons[i].translatesAutoresizingMaskIntoConstraints = false
                viewButtons[i].addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
            } else {viewButtons[i].isEnabled = false}
            bottomStackView.addArrangedSubview(viewButtons[i])
        }
        bottomStackView.axis = .vertical
        bottomStackView.distribution = .fillEqually
        bottomStackView.spacing = 20
    }
    
    @objc func buttonPressed(_ sender: UIButton) {
        switch sender.titleLabel?.text {
        case "Столицы": Main.listOfWords = ["Токио",
                                               "Москва",
                                               "Дели",
                                               "Сеул",
                                               "Джакарта",
                                               "Бангкок",
                                               "Мехико",
                                               "Каир",
                                               "Лима",
                                               "Лондон",
                                               "Богота",
                                               "Сантьяго-де-Чили",
                                               "Сингапур",
                                               "Кейптаун",
                                               "Берлин",
                                               "Афины",
                                               "Мадрид",
                                               "Найроби",
                                               "Буэнос-Айрес",
                                               "Киев",
                                               "Рим",
                                               "Тайбэй",
                                               "Гавана",
                                               "Париж",
                                               "Алжир",
                                               "Пномпень",
                                               "Бухарест",
                                               "Кито",
                                               "Куала-Лумпур",
                                               "Будапешт",
                                               "Варшава",
                                               "Вена",
                                               "Манила",
                                               "София",
                                               "Бейрут",
                                               "Прага",
                                               "Тунис",
                                               "Белград",
                                               "Дублин",
                                               "Стокгольм",
                                               "Амстердам",
                                               "Загреб",
                                               "Иерусалим",
                                               "Рига",
                                               "Вашингтон",
                                               "Осло",
                                               "Хельсинки",
                                               "Вильнюс",
                                               "Копенгаген",
                                               "Лиссабон",
                                               "Эдинбург",
                                               "Веллингтон",
                                               "Братислава",
                                               "Таллин",
                                               "Брюссель",
                                               "Рейкьявик",
                                               "Люксембург",
                                               "Валлетта",
                                               "Пекин",
                                               "Монако",].shuffled()
        case "Фрукты?": Main.listOfWords = ["Виталич", "Виталька"].shuffled()
        case "Покемоны": Main.listOfWords = ["Абра",
                                                 "Беллспраут",
                                                 "Бульбазавр",
                                                 "Вартортл",
                                                 "Венонат",
                                                 "Видл",
                                                 "Випинбелл",
                                                 "Волторб",
                                                 "Вульпикс",
                                                 "Гастли",
                                                 "Глум",
                                                 "Голдин",
                                                 "Гравелер",
                                                 "Граймер",
                                                 "Гроулит",
                                                 "Джеодуд",
                                                 "Джигглипуф",
                                                 "Диглетт",
                                                 "Додуо",
                                                 "Драгонэйр",
                                                 "Дратини",
                                                 "Дроузи",
                                                 "Зубат",
                                                 "Иви",
                                                 "Ивизавр",
                                                 "Игглибафф",
                                                 "Кабуто",
                                                 "Кадабра",
                                                 "Какуна",
                                                 "Катерпи",
                                                 "Клефейри",
                                                 "Клеффа",
                                                 "Коффинг",
                                                 "Крабби",
                                                 "Кубон",
                                                 "Магби",
                                                 "Магнемайт",
                                                 "Майм Младший",
                                                 "Манки",
                                                 "Манчлакс",
                                                 "Мачоп",
                                                 "Мачоук",
                                                 "Метапод",
                                                 "Мэджикарп",
                                                 "Мяут",
                                                 "Нидоран",
                                                 "Нидоран",
                                                 "Нидорина",
                                                 "Нидорино",
                                                 "Оддиш",
                                                 "Оманайт",
                                                 "Парас",
                                                 "Пиджеотто",
                                                 "Пиджи",
                                                 "Пикачу",
                                                 "Пичу",
                                                 "Поливаг",
                                                 "Поливирл",
                                                 "Понита",
                                                 "Псидак",
                                                 "Райхорн",
                                                 "Раттата",
                                                 "Сил",
                                                 "Сквиртл",
                                                 "Слоупок",
                                                 "Смучам",
                                                 "Спироу",
                                                 "Старью",
                                                 "Сэндшру",
                                                 "Тентакул",
                                                 "Тирог",
                                                 "Хонтер",
                                                 "Хорси",
                                                 "Хэппини",
                                                 "Чармандер",
                                                 "Чармелеон",
                                                 "Шеллдер",
                                                 "Эканс",
                                                 "Экзеггут",
                                                 "Элекид"].shuffled()
        default: fatalError()
        }
        
        navigationController?.pushViewController(GameSetupViewController(), animated: false)
    }
}

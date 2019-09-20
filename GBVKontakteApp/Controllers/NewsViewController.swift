//
//  NewsViewController.swift
//  
//
//  Created by Dmitry on 07/06/2019.
//  Copyright © 2019 Dmitry. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class NewsViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var news: [NewsModel] = [
        NewsModel(id: 1, nameFriend: "Губка Боб", nameFoto: "ГубкаБоб", dateNews: "31.12.2017", textNews: "Nickelodeon снимет приквел культового мультсериала «Губка Боб Квадратные Штаны». Об этом сообщает Deadline", imageNews: "ГубкаБобНовости"),
        NewsModel(id: 2, nameFriend: "Незнайка", nameFoto: "Незнайка", dateNews: "01.05.2019", textNews: "«Незнайка на Луне» пройдет лингвистическую экспертизу после обвинений в разжигании ненависти к полицейским", imageNews: "НезнайкаНовости"),
        NewsModel(id: 3, nameFriend: "Мамонтенок", nameFoto: "Мамонтенок", dateNews: "05.06.2019", textNews: "В Крыму обнаружили километровую пещеру с останками мамонта и мамонтёнка", imageNews: "МамонтенокНовости"),
        NewsModel(id: 4, nameFriend: "Карлсон", nameFoto: "Карлсон", dateNews: "03.04.2019", textNews: "Союзмультфильм» ожидает завершения переговоров с наследниками шведской писательницы Астрид Линдгрен о создании продолжения советского мультфильма «Малыш и Карлсон» весной, сообщает RNS. В ближайшее время партнеры планируют договориться о софинансировании нового проекта.", imageNews: "КарлсонНовости")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return news.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCell.reuseIdentifier, for: indexPath) as? NewsCell else { return UICollectionViewCell() }
        let row = indexPath.row
        cell.imageFriendNews.image = UIImage(named: news[row].nameFoto)
        cell.imageNews.image = UIImage(named: news[row].imageNews)
        cell.textNews.text = news[row].textNews
        cell.nameFriend.text = news[row].nameFriend
        cell.dateNews.text = news[row].dateNews
        return cell
    }
}

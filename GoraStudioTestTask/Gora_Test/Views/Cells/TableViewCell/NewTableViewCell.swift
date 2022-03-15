//
//  NewTableViewCell.swift
//  Gora_Test
//
//  Created by Maksim Khlestkin on 13.03.2022
//

import UIKit
import SafariServices

protocol SafariDelegate: AnyObject {
    func openArticle(by url: URL)
}

class NewTableViewCell: UITableViewCell {
    
    static let identifier = "NewTableViewCell"
    
    private let networkManager = NetworkManager()
    weak var delegate: SafariDelegate?
    
    var news: News?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    static func nib() -> UINib {
        return UINib(nibName: identifier,
                     bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(
            NewCollectionViewCell.nib(),
            forCellWithReuseIdentifier: NewCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

// MARK: - UICollectionViewDataSource
extension NewTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: NewCollectionViewCell.identifier,
                for: indexPath) as? NewCollectionViewCell,
            let new = news?.articles?[indexPath.row]
        else {
            return UICollectionViewCell()
        }
        cell.setupCells(from: new)
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        news?.articles?.count ?? 0
    }
    
}

// MARK: - UICollectionViewDelegate. Implementing open URL`s feature here
extension NewTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let url = URL(
            string: news?.articles?[indexPath.row].url ?? "") {
            delegate?.openArticle(by: url)
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension NewTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(
            width: 170,
            height: 250)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(
            top: 0,
            left: 16,
            bottom: 0,
            right: 0)
    }
    
}

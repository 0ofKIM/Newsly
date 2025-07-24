//
//  ViewController.swift
//  Newsly
//
//  Created by 0ofKim on 7/19/25.
//

import UIKit

// MARK: - Section Enum
enum Section: CaseIterable {
    case main
}

class ViewController: UIViewController, UICollectionViewDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - DiffableDataSource & CompositionalLayout
    private var dataSource: UICollectionViewDiffableDataSource<Section, NewsItem>?
    private var newsItems: [NewsItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        configureDataSource()
        fetchNews()
    }
    
    // MARK: - CollectionView Setup
    private func setupCollectionView() {
        collectionView.collectionViewLayout = createCompositionalLayout()
        collectionView.delegate = self
        
        collectionView.registerCell(cell: NewsCollectionViewCell.self)
    }
    
    // MARK: - Compositional Layout
    private func createCompositionalLayout() -> UICollectionViewLayout {
        // Item
        let itemSize: NSCollectionLayoutSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(120)
        )
        let item: NSCollectionLayoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // Group
        let groupSize: NSCollectionLayoutSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(120)
        )
        let group: NSCollectionLayoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // Section
        let section: NSCollectionLayoutSection = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16)
        
        // Layout
        let layout: UICollectionViewCompositionalLayout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, NewsItem>(
            collectionView: collectionView
        ) { collectionView, indexPath, newsItem in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCollectionViewCell", for: indexPath) as! NewsCollectionViewCell
            
            cell.configure(with: newsItem)
            
            return cell
        }
    }
    
    // MARK: - Snapshot 적용
    private func applySnapshot() {
        guard dataSource != nil else {
            print("dataSource가 nil입니다.")
            return
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, NewsItem>()
        snapshot.appendSections([.main])
        snapshot.appendItems(newsItems, toSection: .main)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }

    func fetchNews() {
        APIClient.shared.fetchNaverNews(query: "인공지능") { result in
            switch result {
            case .success(let response):
                self.newsItems = response.items
                DispatchQueue.main.async {
                    self.applySnapshot()
                }
                print("뉴스 개수: \(response.items.count)")
            case .failure(let error):
                print("뉴스 불러오기 실패: \(error)")
            }
        }
    }
}

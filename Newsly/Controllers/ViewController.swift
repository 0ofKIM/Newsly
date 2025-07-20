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
    
    // MARK: - Sample Data
    private var newsItems: [NewsItem] = [
        NewsItem(title: "첫 번째 뉴스 제목", content: "첫 번째 뉴스의 내용입니다. 이것은 샘플 데이터입니다.", imageURL: nil),
        NewsItem(title: "두 번째 뉴스 제목", content: "두 번째 뉴스의 내용입니다. 이것은 샘플 데이터입니다.", imageURL: nil),
        NewsItem(title: "세 번째 뉴스 제목", content: "세 번째 뉴스의 내용입니다. 이것은 샘플 데이터입니다.", imageURL: nil),
        NewsItem(title: "네 번째 뉴스 제목", content: "네 번째 뉴스의 내용입니다. 이것은 샘플 데이터입니다.", imageURL: nil),
        NewsItem(title: "다섯 번째 뉴스 제목", content: "다섯 번째 뉴스의 내용입니다. 이것은 샘플 데이터입니다.", imageURL: nil),
        NewsItem(title: "여섯 번째 뉴스 제목", content: "여섯 번째 뉴스의 내용입니다. 이것은 샘플 데이터입니다.", imageURL: nil),
        NewsItem(title: "일곱 번째 뉴스 제목", content: "일곱 번째 뉴스의 내용입니다. 이것은 샘플 데이터입니다.", imageURL: nil),
        NewsItem(title: "여덟 번째 뉴스 제목", content: "여덟 번째 뉴스의 내용입니다. 이것은 샘플 데이터입니다.", imageURL: nil),
        NewsItem(title: "아홉 번째 뉴스 제목", content: "아홉 번째 뉴스의 내용입니다. 이것은 샘플 데이터입니다.", imageURL: nil),
        NewsItem(title: "열 번째 뉴스 제목", content: "열 번째 뉴스의 내용입니다. 이것은 샘플 데이터입니다.", imageURL: nil),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        configureDataSource()
        applySnapshot()
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
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(120)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // Group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(120)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16)
        
        // Layout
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private func configureDataSource() {
        guard let collectionView = collectionView else { return }
        
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
    
    // MARK: - Temp) 데이터 추가/삭제
    func addNewsItem() {
        let newItem = NewsItem(
            title: "새로운 뉴스 제목",
            content: "새로 추가된 뉴스 내용입니다.",
            imageURL: nil
        )
        newsItems.append(newItem)
        applySnapshot()
    }
    
    func removeNewsItem(at index: Int) {
        guard index < newsItems.count else { return }
        newsItems.remove(at: index)
        applySnapshot()
    }
}

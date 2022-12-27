//
//  ViewController.swift
//  MdFahimFaezAbir-30028
//
//  Created by Bjit on 15/12/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var listButton: UIButton!
    @IBOutlet weak var gridButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        let collectionNib =  UINib(nibName:"ItemCell", bundle: nil)
        collectionView.register(collectionNib, forCellWithReuseIdentifier: "itemCell")
        
        /**
         #Default Layout - GridView
         */
        let insets = NSDirectionalEdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3)
        let itemSize  = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2), heightDimension: .fractionalHeight(1))
        
        let item =  NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = insets
        let horGroup = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: horGroup, subitems: [item])
        let section  = NSCollectionLayoutSection(group: group)
        let compLayout = UICollectionViewCompositionalLayout(section: section)
        collectionView.collectionViewLayout = compLayout
    }
    
    @IBAction func gridView(_ sender: Any) {
        gridViewListView(viewStyle: true)
    }
    @IBAction func listView(_ sender: Any) {
        gridViewListView(viewStyle: false)
    }
    func gridView()->UICollectionViewLayout{
        let insets = NSDirectionalEdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3)
        let itemSize  = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2), heightDimension: .fractionalHeight(1))
        
        let item =  NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = insets
        let horGroup = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: horGroup, subitems: [item])
        let section  = NSCollectionLayoutSection(group: group)
        let compLayout = UICollectionViewCompositionalLayout(section: section)
        return compLayout
    }
    func listView()->UICollectionViewLayout{
        let insets = NSDirectionalEdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3)
        let itemSize  = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/2))
        
        let item =  NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = insets
        let horGroup = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/2))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: horGroup, subitems: [item])
        
        let section  = NSCollectionLayoutSection(group: group)
        let compLayout = UICollectionViewCompositionalLayout(section: section)
        return compLayout
    }
    func gridViewListView(viewStyle: Bool){
        gridButton.isUserInteractionEnabled = false
        listButton.isUserInteractionEnabled = false
        collectionView.startInteractiveTransition(to: viewStyle ? gridView() : listView()){[weak self]_,_ in
            guard let self = self else{return}
            self.gridButton.isUserInteractionEnabled = true
            self.listButton.isUserInteractionEnabled = true
        }
        
        collectionView.finishInteractiveTransition()
    }
}

extension ViewController: UICollectionViewDelegate{
    
}

extension ViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        Images.images.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item =  collectionView.dequeueReusableCell(withReuseIdentifier: "itemCell", for: indexPath) as! ItemCell
        item.imageView.image = UIImage(named: Images.images[indexPath.row].image)
        return item
    }
    
    
}

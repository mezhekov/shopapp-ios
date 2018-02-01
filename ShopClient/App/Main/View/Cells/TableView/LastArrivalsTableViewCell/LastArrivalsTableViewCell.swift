//
//  LastArrivalsTableViewCell.swift
//  ShopClient
//
//  Created by Evgeniy Antonov on 9/14/17.
//  Copyright © 2017 Evgeniy Antonov. All rights reserved.
//

import UIKit

protocol LastArrivalsTableCellDelegate: class {
    func tableViewCell(_ tableViewCell: LastArrivalsTableViewCell, didSelect product: Product)
}

class LastArrivalsTableViewCell: UITableViewCell {
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private var collectionProvider: LastArrivalsTableCellProvider!
    private var products: [Product] = []
    
    weak var delegate: LastArrivalsTableCellDelegate?
    
    // MARK: - View lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCollectionView()
    }
    
    // MARK: - Setup
    
    func configure(with products: [Product]) {
        self.products = products
        collectionProvider.products = products
        collectionView.reloadData()
    }
    
    private func setupCollectionView() {
        let cellName = String(describing: LastArrivalsCollectionViewCell.self)
        let nib = UINib(nibName: cellName, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: cellName)
        
        collectionProvider = LastArrivalsTableCellProvider()
        collectionProvider.delegate = self
        collectionView.dataSource = collectionProvider
        collectionView.delegate = collectionProvider
    }
}

// MARK: - LastArrivalsTableCellProviderDelegate

extension LastArrivalsTableViewCell: LastArrivalsTableCellProviderDelegate {
    func provider(_ provider: LastArrivalsTableCellProvider, didSelect product: Product) {
         delegate?.tableViewCell(self, didSelect: product)
    }
}

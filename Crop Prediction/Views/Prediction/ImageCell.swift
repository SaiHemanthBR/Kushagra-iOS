//
//  ImageCell.swift
//  Crop Prediction
//
//  Created by Sai Hemanth Bheemreddy on 02/06/20.
//  Copyright © 2020 Sai Hemanth Bheemreddy. All rights reserved.
//

import UIKit

class ImageCell: CardCell, SelfConfiguringPredictionCell {
    
//    MARK: Class Constants
    static let reuseIdentifier = "ImageCell"
    
//    MARK: UI Variables
    var recent: Recent?
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = cornerRadius
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not Implemented")
    }
    
    func configure(with recent: Recent, for indexPath: IndexPath) {
        self.recent = recent
        
        imageView.image = recent.prediction.image ?? recent.prediction.defaultImage
        
        NotificationCenter.default.addObserver(self, selector: #selector(imageDidChange), name: Prediction.imageDidChange, object: recent.prediction)
    }
    
    func deconfigure() {
        NotificationCenter.default.removeObserver(self, name: Prediction.imageDidChange, object: recent?.prediction)
    }
    
    @objc func imageDidChange() {
        imageView.image = recent?.prediction.image ?? recent?.prediction.defaultImage
    }
    
}

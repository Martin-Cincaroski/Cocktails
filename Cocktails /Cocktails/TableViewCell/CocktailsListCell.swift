//
//  CocktailsListCell.swift
//  Cocktails
//
//  Created by Martin on 7/28/21.
//

import UIKit
import SnapKit

protocol CocktailCellDelegate: class {
    
}

class CocktailsListCell: UITableViewCell {


    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.color = .red
        return activityIndicator
    }()
    
    private lazy var cocktailsImage: UIImageView = {
        let image = UIImageView()
        return image
    }()

}

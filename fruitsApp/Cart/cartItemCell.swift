//
//  cartItemCell.swift
//  fruitsApp
//
//  Created by Bassam Ramadan on 9/13/20.
//  Copyright © 2020 Bassam Ramadan. All rights reserved.
//

import UIKit

class cartItemCell: UICollectionViewCell{
    @IBOutlet var image: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var unit: UILabel!
    @IBOutlet var quantity: UILabel!
    @IBOutlet var price: UILabel!
    @IBOutlet var remove: UIButton!
    @IBOutlet var plus: UIButton!
    @IBOutlet var minus: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

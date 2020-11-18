//
//  UIHelper.swift
//  Reciplease
//
//  Created by anthonymfscott on 18/11/2020.
//

import UIKit

struct UIHelper {
    static func createFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: view.bounds.width, height: 144)

        return flowLayout
    }
}

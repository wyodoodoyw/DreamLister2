//
//  ItemDetailsVC.swift
//  DreamLister
//
//  Created by Matthew Wood on 2016-11-01.
//  Copyright © 2016 Matthew. All rights reserved.
//

import UIKit

class ItemDetailsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // replaces default navigation bar style
        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
    }

}

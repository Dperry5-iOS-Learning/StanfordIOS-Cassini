//
//  CassiniViewController.swift
//  Cassini
//
//  Created by Dylan Perry on 8/27/19.
//  Copyright © 2019 Dylan Perry. All rights reserved.
//

import UIKit

class CassiniViewController: UIViewController {

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if let url = DemoURLS.NASA[identifier] {
                if let imageViewController = segue.destination.contents as? ImageViewController {
                    imageViewController.imageUrl = url
                    imageViewController.title = (sender as? UIButton)?.currentTitle
                }
            }
        }
    }

}


extension UIViewController {
    var contents: UIViewController {
        if let navcon = self as? UINavigationController {
            return navcon.visibleViewController ?? self
        } else{
            return self
        }
    }
}

//
//  DocumentViewController.swift
//  Document App
//
//  Created by Jordan LEBRET on 9/10/25.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    var imageName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let unwrappedImageName = imageName {
            
            imageView.image = UIImage(named: unwrappedImageName)
        }
    }

}

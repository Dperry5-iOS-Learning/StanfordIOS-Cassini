//
//  ImageViewController.swift
//  Cassini
//
//  Created by Dylan Perry on 8/25/19.
//  Copyright © 2019 Dylan Perry. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {

    var imageUrl: URL? {
        didSet {
            image = nil
            // Test if we're on screen!
            if view.window != nil {
                fetchImage()
            }
        }
    }
    
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    // Use a computed car like this to reduce code duplication.
    private var image: UIImage? {
        get {
            return imageView.image
        } set{
            imageView.image = newValue
            imageView.sizeToFit()
            scrollView?.contentSize = imageView.frame.size
            spinner?.stopAnimating()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if imageView.image == nil {
            fetchImage()
        }
    }
    
    var imageView = UIImageView()
    
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet{
            scrollView.minimumZoomScale = 1/25
            scrollView.maximumZoomScale = 1.0
            scrollView.delegate = self
            scrollView.addSubview(imageView)
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }

    private func fetchImage(){
        
        if let url = imageUrl {
            spinner.startAnimating()
            // Use weak self because closure could theoretically take so long to run
            // that this view controller could leave the heap
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                let urlContents = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    if let imageData = urlContents, url == self?.imageUrl {
                        self?.image = UIImage(data: imageData)
                    }
                }
                
            }
        }
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
//        if imageUrl == nil {
//            imageUrl = DemoURLS.randomPicture
//        }
    }
    
    
    
}

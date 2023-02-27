//
//  OverviewVC.swift
//  MVVM Movie
//
//  Created by halil dikişli on 27.02.2023.
//

import UIKit

class OverviewVC: UIViewController {
    
    var overview = ""
    var posterPath = ""

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var overviewLabel: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if overview == "" {
            overviewLabel.text = "No Overview"
        } else {
            overviewLabel.text = overview
        }
        
        ServiceManager().getImages(with: posterPath, to: imageView, resolution: .medium)
    }
    

    

}

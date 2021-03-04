//
//  DetailViewController.swift
//  ApıProject
//
//  Created by Akdag on 28.02.2021.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {
    
    var selectedModel : Model?
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        if selectedModel != nil {
            titleLabel.text = selectedModel!.title
            descriptionLabel.text = selectedModel!.description
            imageView.sd_setImage(with: URL(string: selectedModel!.image))
            imageView.contentMode = .scaleAspectFill
        }
    }
    

   

}

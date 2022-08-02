//
//  NewsListTableViewCell.swift
//  TechCrunchNews
//
//  Created by pankaj bandewar on 02/08/22.
//

import UIKit

class NewsListTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imgVisualEffect: UIImageView!
    @IBOutlet weak var newsImagView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateCell(details: Article?) {
        if let details = details {
            titleLabel.text = details.title!
            authorLabel.text = details.author!
            descriptionLabel.text = details.articleDescription!
            imgVisualEffect.load(url: details.urlToImage!)
            newsImagView.load(url: details.urlToImage!)
        }
    }
}

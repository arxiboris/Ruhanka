//
//  MainCell.swift
//  Ruhanka
//
//  Created by Oleksandr Borysenko on 25.07.2023.
//

import UIKit

class MainCell: UITableViewCell {

    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var mainName: UILabel!
    @IBOutlet weak var mainTag: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
}

extension MainCell {
    static func nib() -> UINib {
        return UINib(nibName: "MainCell", bundle: nil)
    }
    
    public func setCell(withViewModel viewModel: CourseMainPageViewModelType) {
        mainTag.text = viewModel.mainTag
        mainName.text = viewModel.mainName
        mainImage.image = viewModel.mainImage
        mainImage.makeRoundCorners(byRadius: 20)
    }
}

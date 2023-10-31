//
//  FollowerCell.swift
//  GitHubTask_MVVM
//
//  Created by FTS on 31/10/2023.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    @IBOutlet weak var followerImg: RoundedImageView!
    @IBOutlet weak var followerName: UILabel!
    private var viewModel = FollowerCellViewModel()
    
    static var id = "followerCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bindWithViewModel()
    }
    
    private func bindWithViewModel() {
        viewModel.onFetchImage = { [weak self] image in
            self?.followerImg.image = image
        }
    }
    
    func configureCell(model: FollowerCellModel) {
        viewModel.model = model
        followerName.text = viewModel.model?.name
        viewModel.fetchImage()
    }
}

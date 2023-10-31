//
//  UserViewController.swift
//  GitHubTask_MVVM
//
//  Created by FTS on 30/10/2023.
//

import UIKit

class UserViewController: UIViewController {

    @IBOutlet weak var avatarImage: RoundedImageView!
    @IBOutlet weak var loginName: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    static var id: String { return "userVCID" }
    var viewModel: UserViewModel

    override func viewDidLoad() {
        super.viewDidLoad()
        bindWithViewModel()
        configureUILabel()
    }
    
    init(user: GitHubUser) {
        viewModel = UserViewModel(with: user)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bindWithViewModel() {
        viewModel.onFetchImage = { [weak self] image in
            self?.avatarImage.image = image
        }

        viewModel.onShowError = { [weak self] msg in
            self?.showAlert(alertModel: AlertModel(title: Constants.LocalizedStrings.alertTitle, msg: Constants.LocalizedStrings.alertMessage))
        }

        viewModel.onFetchFollowers = { [weak self] followers in
            self?.navigateToFollowerVC(with: followers)
        }
    }

    private func navigateToFollowerVC(with followers: [GitHubFollower]) {
        let destVC = FollowerViewController(followers: followers)
        self.navigationController?.pushViewController(destVC, animated: true)
    }

    private func configureUILabel() {
        loginName.text = viewModel.user.name
        bioLabel.text = viewModel.user.bio
        countLabel.attributedText = viewModel.formattedFollowerCount
        viewModel.fetchImage()
    }

    @IBAction func getFollowersBtnTapped(_ sender: Any) {
        viewModel.fetchFollowers()
    }

}

//
//  ViewController.swift
//  03_URLSessionAndUICollection
//
//  Created by FTS on 02/10/2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var userName: UITextField!
    
    private var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
    private var viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindWithViewModel()
    }
    
    private func bindWithViewModel() {
        viewModel.onShowError = { [weak self] msg in
            self?.hideActivityIndicator()
            self?.showAlert(alertModel: AlertModel(title: Constants.LocalizedStrings.alertTitle, msg: Constants.LocalizedStrings.alertMessage))
        }
        
        viewModel.onFetchUser = { [weak self] user in
            self?.navigateToUserVC(with: user)
            self?.hideActivityIndicator()
        }
    }
    
    private func navigateToUserVC(with user: GitHubUser) {
        let destVC = UserViewController(user: user)
        self.navigationController?.pushViewController(destVC, animated: true)
    }
    
    private func configureActivityIndicator() {
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
    }
    
    private func showActivityIndicator() {
        activityIndicator.startAnimating()
    }
    
    private func hideActivityIndicator() {
        activityIndicator.stopAnimating()
    }
    
    @IBAction func submitBtnTapped(_ sender: Any) {
        configureActivityIndicator()
        showActivityIndicator()
        viewModel.fetchUser(name: userName.text ?? "SAllen0400")
    }
}








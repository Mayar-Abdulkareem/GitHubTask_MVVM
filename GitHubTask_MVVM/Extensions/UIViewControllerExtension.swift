//
//  UIViewControllerExtension .swift
//  03_Alomafire
//
//  Created by FTS on 23/10/2023.
//

import UIKit

struct AlertModel {
    let title: String
    let msg: String
}

extension UIViewController {
    
    func showAlert(alertModel: AlertModel) {
        let alertController = UIAlertController(title: alertModel.title, message: alertModel.msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
//    func navigateToViewController<ViewController: IdentifiableViewController>(
//        viewControllerType: ViewController.Type, viewModel: ViewController.ViewModelType
//    ) where ViewController: UIViewController {
//        let vc = storyboard?.instantiateViewController(withIdentifier: ViewController.id) as? ViewController
//        if var vc = vc  {
//            vc.viewModel = viewModel
//            if let navigationController = navigationController {
//                navigationController.pushViewController(vc, animated: true)
//            } else {
//                showAlert(alertModel: AlertModel(title: "Failure", msg: "Failed to push \(ViewController.id)."))
//            }
//        }
//    }
}

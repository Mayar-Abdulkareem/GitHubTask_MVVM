//
//  FollowerViewController.swift
//  GitHubTask_MVVM
//
//  Created by FTS on 31/10/2023.
//

import UIKit

class FollowerViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var noResultsLabel: UILabel!
    
    static var id: String { return "followerVCID" }
    var viewModel: FollowerViewModel
    
    private var isSearching: Bool {
        return searchBar.text?.count ?? 0 != 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurFollowerCell()
        configureDelegates()
    }
    
    init(followers: [GitHubFollower]) {
        viewModel = FollowerViewModel(with: followers)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configurFollowerCell() {
        let nib = UINib(nibName: "FollowerCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "followerCell")
    }
    
    private func configureDelegates() {
        searchBar.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension FollowerViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return !isSearching ? viewModel.followers.count : viewModel.filteredFollowers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard (isSearching && indexPath.row < viewModel.filteredFollowers.count) || (!isSearching && indexPath.row < viewModel.followers.count)
        else {
            return UICollectionViewCell()
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.id, for: indexPath) as? FollowerCell
        let follower = !isSearching ? viewModel.followers[indexPath.row] : viewModel.filteredFollowers[indexPath.row]
        let followerModel = FollowerCellModel(name: follower.login, avatarUrl: follower.avatarUrl)
        cell?.configureCell(model: followerModel)
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width * 0.2, height: self.view.frame.width * 0.2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 2)
    }
}

extension FollowerViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.showsCancelButton = true
        guard searchText.count != 0 else {
            clearAndShowAllFollowers()
            return
        }
        
        viewModel.updateFilteredFollowers(text: searchText)
        noResultsLabel.isHidden = !(viewModel.filteredFollowersIsEmpty)
        collectionView.isHidden = (viewModel.filteredFollowersIsEmpty)
        collectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        clearAndShowAllFollowers()
    }
    
    private func clearAndShowAllFollowers() {
        searchBar.showsCancelButton = false
        collectionView.isHidden = false
        noResultsLabel.isHidden = true
        searchBar.text = ""
        viewModel.clearFilteredFollowers()
        collectionView.reloadData()
    }
}

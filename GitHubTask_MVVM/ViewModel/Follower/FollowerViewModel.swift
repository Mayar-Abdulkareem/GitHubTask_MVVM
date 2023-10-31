//
//  FollowerViewModel.swift
//  03_Alomafire
//
//  Created by FTS on 24/10/2023.
//

import UIKit

class FollowerViewModel {
    
    private (set) var followers: [GitHubFollower]
    private (set) var filteredFollowers: [GitHubFollower] = []
    
    var filteredFollowersIsEmpty: Bool {
        return filteredFollowers.count == 0
    }
    
    init(with followers: [GitHubFollower]) {
        self.followers = followers
    }
    
    func updateFilteredFollowers(text: String) {
        filteredFollowers = followers.filter { follower in
            return follower.login.lowercased().contains(text.lowercased())
        }
    }
    
    func clearFilteredFollowers() {
        filteredFollowers.removeAll()
    }
}

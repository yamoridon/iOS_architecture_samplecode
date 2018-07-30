//
//  SearchUsersDataSource.swift
//  FluxExample
//
//  Created by marty-suzuki on 2018/07/31.
//  Copyright © 2018年 marty-suzuki. All rights reserved.
//

import UIKit

final class SearchUsersDataSource: NSObject {

    private let userStore: GithubUserStore
    private let actionCreator: ActionCreator

    private let cellIdentifier = "Cell"

    init(userStore: GithubUserStore,
         actionCreator: ActionCreator) {
        self.userStore = userStore
        self.actionCreator = actionCreator

        super.init()
    }

    func configure(_ tableView: UITableView) {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension SearchUsersDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userStore.users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)

        let user = userStore.users[indexPath.row]
        cell.textLabel?.text = user.login

        return cell
    }
}

extension SearchUsersDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = userStore.users[indexPath.row]
        actionCreator.setSelectedUser(user)
    }
}

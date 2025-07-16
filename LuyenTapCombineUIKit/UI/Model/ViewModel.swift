//
//  ListViewModel.swift
//  TestThuDelegate
//
//  Created by iKame Elite Fresher 2025 on 16/7/25.
//

import Foundation
import Combine
final class ListViewModel{
    private var cancellables = Set<AnyCancellable>()
    @Published var users: [UserProfile] = []
    init() {
        UserManager.shared.$users
            .receive(on: RunLoop.main) // nhận từ luông main
            .assign(to: &$users) // nối publisher
    }
}
//final class Profile

//
//  AuthStorage.swift
//  eventHub
//
//  Created by David on 24.12.25.
//


import Foundation

final class AuthStorage {

    static let shared = AuthStorage()

    private init() {}

    var accessToken: String?
    var refreshToken: String?
}

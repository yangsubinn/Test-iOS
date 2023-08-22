//
//  KeychainManager.swift
//  KeyChain
//
//  Created by 양수빈 on 2023/08/11.
//

import Foundation
import Security

class UserToken: Codable {
    var accessToken: String
    var refreshToken: String
    
    init(accessToken: String, refreshToken: String) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
    }
}

class KeychainManager {
    static let shared = KeychainManager()
    
    private init() {}
    
    private let account = "KeyChain"
    private let service = Bundle.main.bundleIdentifier
    
    private lazy var query: [CFString: Any]? = {
        guard let service = self.service else { return nil }
        return [kSecClass: kSecClassGenericPassword,
          kSecAttrService: service,
          kSecAttrAccount: account]
    }()
    
    func createUser(_ user: UserToken) -> Bool {
        print("user: \(user)")
        guard let data = try? JSONEncoder().encode(user),
              let service = self.service else { return false }
        print("service: \(service)")
        let query: [CFString: Any] = [kSecClass: kSecClassGenericPassword,
                                kSecAttrService: service,
                                kSecAttrAccount: account,
                                kSecAttrGeneric: data]
        print("query: \(query)")
        let status = SecItemAdd(query as CFDictionary, nil)
        
        if status != errSecSuccess {
            if let error = SecCopyErrorMessageString(status, nil) {
                print("Keychain error: \(error)")
            } else {
                print("Unknown keychain error with status: \(status)")
            }
        }
        return status == errSecSuccess
    }
    
    func readUser() -> UserToken? {
        guard let service = self.service else { return nil }
        let query: [CFString: Any] = [kSecClass: kSecClassGenericPassword,
                                kSecAttrService: service,
                                kSecAttrAccount: account,
                                 kSecMatchLimit: kSecMatchLimitOne,
                           kSecReturnAttributes: true,
                                 kSecReturnData: true]
        var item: CFTypeRef?
        if SecItemCopyMatching(query as CFDictionary, &item) != errSecSuccess { return nil }
        
        guard let existingItem = item as? [String: Any],
              let data = existingItem[kSecAttrGeneric as String] as? Data,
              let user = try? JSONDecoder().decode(UserToken.self, from: data) else { return nil }
        
        return user
    }
    
    func updateUser(_ user: UserToken) -> Bool {
        guard let query = self.query,
              let data = try? JSONEncoder().encode(user) else { return false }
        
        let attributes: [CFString: Any] = [kSecAttrAccount: account,
                                           kSecAttrGeneric: data]
        
        return SecItemUpdate(query as CFDictionary, attributes as CFDictionary) == errSecSuccess
    }
    
    func deleteUser() -> Bool {
        guard let query = self.query else { return false }
        return SecItemDelete(query as CFDictionary) == errSecSuccess
    }
}

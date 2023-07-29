//
//  UserDefaultWrapper.swift
//  AppStorage
//
//  Created by 양수빈 on 2023/07/25.
//

import Foundation

@propertyWrapper struct UserDefaultWrapper<T> {
    
    private let key: UserDefaultKey
    
    init(key: UserDefaultKey) {
        self.key = key
    }
    
    var wrappedValue: T? {
        get {
            return UserDefaults.standard.object(forKey: self.key.rawValue) as? T
        }
        
        set {
            if newValue == nil {
                UserDefaults.standard.removeObject(forKey: key.rawValue)
            } else { UserDefaults.standard.setValue(newValue, forKey: key.rawValue) }
        }
    }
}

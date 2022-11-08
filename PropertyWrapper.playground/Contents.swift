import Foundation
import SwiftUI

// Address와 Person 둘다 저장 자체는 그대로 하지만, get으로 보여줄때는 uppercased로 보여주고 싶다
struct Address {
//    private var _town: String = ""
//
//    var town: String {
//        // 중복
//        get {
//            self._town.uppercased()
//        } set {
//            self._town = newValue
//        }
//    }
//
//    init(town: String) {
//        self.town = town
//    }
    
    // propertyWrapper 사용
    @Uppercase var town: String
}

struct Person {
//    private var _name: String = ""
//
//    var name: String {
//        // 중복
//        get {
//            self._name.uppercased()
//        } set {
//            self._name = newValue
//        }
//    }
//
//    init(name: String) {
//        self.name = name
//    }
    
    // propertyWrapper 사용
    @Uppercase var name: String
}

// MARK: - propertyWrapper
// 중복되는 get,set 부분(uppercased)을 공통적으로 사용하기 위해
// 행동(uppercased)을 정의하는 타입을 하나 생성
/// property를 uppercase로 만들어주는 wrapper
@propertyWrapper
struct Uppercase {
    private var value: String = ""
    
    var wrappedValue: String {
        get {
            self.value
        } set {
            self.value = newValue.uppercased()
        }
    }
    
    init(wrappedValue initialValue: String) {
        self.wrappedValue = initialValue
    }
}

let address = Address(town: "seoul")
let subin = Person(name: "subin")

print(address.town, subin.name) // SEOUL SUBIN

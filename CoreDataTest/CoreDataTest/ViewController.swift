//
//  ViewController.swift
//  CoreDataTest
//
//  Created by 양수빈 on 2022/11/04.
//

import UIKit

import CoreData

class ViewController: UIViewController {
    var container: NSPersistentContainer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        // 2. VC에서 생성한 persistentContainter을 가져옴
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.container = appDelegate.persistentContainer
        
        // 3. entity 가져옴
        let entity = NSEntityDescription.entity(forEntityName: "PhoneBook", in: self.container.viewContext)
        
        // 4. NSManagedObject 생성
        let person = NSManagedObject(entity: entity!, insertInto: self.container.viewContext)
        person.setValue("워쩔", forKey: "memo")
        person.setValue("양수빈", forKey: "personName")
        person.setValue("010-0000-0001", forKey: "phoneNumber")
        
        do {
            try self.container.viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        fetchContact()
    }
    
    func fetchContact() {
        do {
            let contact = try self.container.viewContext.fetch(PhoneBook.fetchRequest()) as! [PhoneBook]
            contact.forEach {
                print($0.personName)
                print($0.phoneNumber)
                print($0.memo)
            }
        } catch {
            print(error.localizedDescription)
        }
    }

}


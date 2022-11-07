//
//  CreateViewController.swift
//  CoreDataTest
//
//  Created by 양수빈 on 2022/11/07.
//

import UIKit

import CoreData

class CreateViewController: UIViewController {
    var container: NSPersistentContainer!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var memoTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        self.container = appDelegate.persistentContainer
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    @IBAction func createButtonTapped(_ sender: Any) {
        print("createButtonTapped")
        createContact()
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    func createContact() {
        // entity 가져옴
        let entity = NSEntityDescription.entity(forEntityName: "PhoneBook", in: self.container.viewContext)
        
        // NSManagedObject 생성
        let person = NSManagedObject(entity: entity!, insertInto: self.container.viewContext)
        person.setValue(memoTextField.text, forKey: "memo")
        person.setValue(nameTextField.text, forKey: "personName")
        person.setValue(phoneTextField.text, forKey: "phoneNumber")
        
        do {
            try self.container.viewContext.save()
            self.dismiss(animated: true)
        } catch {
            print(error.localizedDescription)
        }
    }
}

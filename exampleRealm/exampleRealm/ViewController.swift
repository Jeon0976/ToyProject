//
//  ViewController.swift
//  exampleRealm
//
//  Created by 전성훈 on 2023/10/11.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dog = Dog()
        dog.name = "Rex"
        dog.age = 1
        print("dog name ", dog.name)
        
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(dog)
        }
    }


}

class Dog: Object {
    @Persisted var name: String
    @Persisted var age: Int 
}

class Person: Object {
    @Persisted(primaryKey: true) var _id: String
    @Persisted var name: String
    @Persisted var age: Int
    @Persisted var dogs: List<Dog>
}



//
//  CardListViewController.swift
//  CreditCardList
//
//  Created by 전성훈 on 2022/08/30.
//

import UIKit
import Kingfisher
import FirebaseDatabase
import FirebaseFirestore

class CardListViewController: UITableViewController {
    
//    var ref: DatabaseReference! // Firebase Realtime Database Reference
    
    var db = Firestore.firestore()
    
    var creditCardList : [CreditCard] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //UITableView Cell Register
        let nibName = UINib(nibName: "CardListCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "CardListCell")
        
        // Cloud Firestroe Read
        db.collection("creditCardList").addSnapshotListener{ snapshot, error in
            guard let documents = snapshot?.documents else {
                print("ERROR Firestore fetching document \(String(describing : error))")
                return
            }
            self.creditCardList = documents.compactMap { doc-> CreditCard? in
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: doc.data(), options: [])
                    let creditCard = try JSONDecoder().decode(CreditCard.self, from: jsonData)
                    return creditCard
                } catch let error {
                    print("ERROR JSON Parsing")
                    return nil
                }
            }.sorted { $0.rank < $1.rank }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        
        // RealTime Database Read
        // ref = Database.database().reference(fromURL: "https://creditcard-list-9d189-default-rtdb.asia-southeast1.firebasedatabase.app")
        // ref = Database.database(url: "https://creditcard-list-9d189-default-rtdb.asia-southeast1.firebasedatabase.app")
//        self.ref = Database.database().reference()
//
//        self.ref.observe(.value) { snapshot in
//            guard let value = snapshot.value as? [String : [String:Any]] else {return}
//            do {
//                let jsonData = try JSONSerialization.data(withJSONObject: value)
//                let cardData = try JSONDecoder().decode([String:CreditCard].self, from: jsonData)
//                let cardList = Array(cardData.values)
//                self.creditCardList = cardList.sorted {$0.rank < $1.rank}
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                 }
//
//            } catch let error {
//                print("ERROR JSON parsing \(error.localizedDescription)")
//            }
//        }
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return creditCardList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CardListCell", for: indexPath) as? CardListCell else {return UITableViewCell()}
        cell.rankLabel.text = "\(creditCardList[indexPath.row].rank)위"
        cell.promotionLabel.text = "\(creditCardList[indexPath.row].promotionDetail.amount)만원 증정"
        cell.cardNameLabel.text = "\(creditCardList[indexPath.row].name)"
        
        // image URL을 활용하여 손쉽게 이미지를 나타나게 해주는 API kingfisher
        // 왜 kingfisher를 사용할까?
        ///  예를들어 UITableView의 cell에 UIImageview가 있고, 각각의 UIImageview에 있는 이미지들은 원격저장소에서 가져왔다고 가정해보면
        ///  이 UITableview를 스크롤 하는 순간 UITableview는 셀을 다시 그리고, 재사용 하기 때문에, 각각의  cell에 있는 이미지를 비동기로 처리하다보니 이미지가 의도와는 다른 곳에 배치되며 뒤죽박죽이 된다.
        ///  물론 이마저도 swift 코드로 방지할 수 있지만, 코드가 지저분해지고 처리해야할 부분이 많이 생긴다.
        ///  kingfisher는 이미지를 다운로드하여 캐시하기 때문에 이미지 비동기호출에 대해 걱정할 필요가 없다. 한번 캐시된 이미지는 다음번 호출에 더 빠르게 보여지는 것도 장점이다.
        let imageURL = URL(string: creditCardList[indexPath.row].cardImageURL)
        cell.cardImageView.kf.setImage(with: imageURL)
        
        return cell
    }

    // 셀 높이 지정
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 상세화면 전달
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let detailViewController = storyboard.instantiateViewController(identifier: "CardDetailViewController") as? CardDetailViewController else {return}
        detailViewController.promotionDetail = creditCardList[indexPath.row].promotionDetail
        self.show(detailViewController, sender: nil)
        
        // Firestore writing
        // Option 1
        let cardID = creditCardList[indexPath.row].id
//        db.collection("creditCardList").document("card\(cardID)").updateData(["isSelected" : true])
        // Option 2
        db.collection("creditCardList").whereField("id", isEqualTo: cardID).getDocuments{ snapshot, _ in
            guard let document = snapshot?.documents.first else {
                print("ERROR Firestore fetching document")
                return
            }
            
            document.reference.updateData(["isSelected": true])
        }
        
        
        
        // real time database writing
//         let cardID = creditCardList[indexPath.row].id
//        // Option 1 (객체의 순번 및 이름이 명확할떄)
//        // ref.child("Item\(cardID)/isSelected").setValue(true)
//
//        // Option 2 (객체 이름은 불명확하나, 객체 안에 PK가 있을때)
//        ref.queryOrdered(byChild: "id").queryEqual(toValue: cardID).observe(.value) { [weak self] snapshot in
//            guard let self = self,
//                  let value = snapshot.value as? [String : [String:Any]],
//                  let key = value.keys.first else {return}
//            self.ref.child("\(key)/isSelected").setValue(true)
//        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
//            let cardID = creditCardList[indexPath.row].id
            
            // real time database delete
            // Option 1
            // ref.child("Item\(cardID)").removeValue()
            
//            // Option 2
//            ref.queryOrdered(byChild: "id").queryEqual(toValue: cardID).observe(.value) { [weak self] snapshot in
//                guard let self = self,
//                      let value = snapshot.value as? [String : [String:Any]],
//                      let key = value.keys.first else {return}
//
//                self.ref.child(key).removeValue()
//            }
            
            // firestore delete
            let cardID = creditCardList[indexPath.row].id
            
            // Option 1
            // 데이터 내부 isSelected 삭제 하는 방법
//             db.collection("creditCardList").document("card\(cardID)").updateData([
//                "isSelected" : FieldValue.delete()])
            
            // Option 2
            db.collection("creditCardList").whereField("id", isEqualTo: cardID).getDocuments {
                snapshot, _ in
                guard let document = snapshot?.documents.first else {
                    print ("error")
                    return}
                document.reference.delete()
            }
        }
    }
}

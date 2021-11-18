////  PaginationCollectionViewController.swift
////  TableViewController
////
////  Created by Pushpendra on 09/03/21.
////  Copyright © 2021 Pushpendra. All rights reserved.
////
//
//import UIKit
//
//
//class PaginationCollectionViewController: UICollectionViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        fetchData(page: 1)
//    }
//
//
//
//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//
//
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return cars.count
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if current_page < total_page && indexPath.row == cars.count - 1 {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "loading_cell", for: indexPath) as! PaginationCollectionViewCell
//            cell.actIndicator.startAnimating()
//            
//            return cell
//        }else {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PaginationCollectionViewCell
//            cell.lbTitle.text = cars[indexPath.row].company_name
//            cell.lbDescription.text = cars[indexPath.row].engine_power
//            return cell
//        }
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        if current_page < total_page && indexPath.row == cars.count - 1 {
//            current_page = current_page + 1
//            DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
//                self.fetchData(page: self.current_page)
//            }
//        }
//    }
//
//    var total_page = 1
//    var current_page = 1
//    var cars : [Cars] = [Cars]()
//    private func fetchData(page : Int, refresh : Bool = false){
//
//        guard let url = URL(string: API.URL) else {
//            return
//        }
//        let params = "page=\(page)&type=Car"
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.httpBody = params.data(using: .utf8)
//
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//            DispatchQueue.main.async {
//                if refresh {
//                    self.cars.removeAll()
//                }
//                if error != nil {
//                    print(error.debugDescription)
//                    return
//                }else if data != nil {
//                    do {
//                        let myData = try JSONDecoder().decode(APIResponse<[Cars]>.self, from: data!)
//                        if myData.status == 1 {
//                            print("Current Page = \(self.current_page)")
//                            self.total_page = myData.total_page ?? 1
//                            self.cars.append(contentsOf: myData.data!)
//                            self.collectionView.reloadData()
//                        }
//                    }catch let error {
//                        print(error.localizedDescription)
//                    }
//                }
//            }
//        }
//        task.resume()
//    }
//}

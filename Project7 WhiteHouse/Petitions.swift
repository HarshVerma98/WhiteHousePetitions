//
//  Petitions'.swift
//  Project7 WhiteHouse
//
//  Created by Harsh Verma on 08/08/21.
//

import Foundation
struct Petitions: Codable {
    var results: [Petition]
//
//    var url = "https://www.hackingwithswift.com/samples/petitions-1.json"
//
//    func fetchData(completion: @escaping()->()) {
//        guard let validURL = URL(string: url) else {
//            print("Error Invalid URL")
//            return completion()
//        }
//
//        let session = URLSession.shared
//
//
//        let task = session.dataTask(with: validURL) { data, _, error in
//            do {
//                let result = try! JSONDecoder().decode([Petition].self, from: data!)
//                print(result)
//            }catch {
//                print(error.localizedDescription)
//            }
//            completion()
//        }
//        task.resume()
//    }
}

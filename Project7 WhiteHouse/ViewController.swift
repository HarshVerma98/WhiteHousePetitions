//
//  ViewController.swift
//  Project7 WhiteHouse
//
//  Created by Harsh Verma on 08/08/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var table: UITableView!
    var petitions = [Petition]()
    var url: String!
    var filteredResult = [Petition]()
    var keyWord: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(didPressCredits))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(didPressFilter))
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "White House Petitions"
        if navigationController?.tabBarItem.tag == 0 {
            url = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            url = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        table.dataSource = self
        table.delegate = self
        if let validURL = URL(string: url) {
            if let data = try? Data(contentsOf: validURL) {
                parser(json: data)
            }else {
                showError()
            }
        }else {
            showError()
        }
        // Do any additional setup after loading the view.
    }
    
    
    func parser(json: Data) {
        if let obtainedJSON = try? JSONDecoder().decode(Petitions.self, from: json) {
            petitions = obtainedJSON.results
            filterData()
            table.reloadData()
        }
    }
    
    func showError() {
        let alert = UIAlertController(title: "Loading Error", message: "Problem Fetching Data", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
    
    func filterData() {
        if keyWord.isEmpty {
            filteredResult = petitions
            navigationItem.leftBarButtonItem?.title = "Filter"
            return
        }
        navigationItem.leftBarButtonItem?.title = "Filter (current: \(keyWord))"
        filteredResult = petitions.filter({ pet in
            if let _ = pet.title.range(of: keyWord, options: .caseInsensitive) {
                return true
            }
            if let _ = pet.body.range(of: keyWord, options: .caseInsensitive) {
                return true
            }
            return false
        })
        
    }
    
    @objc func didPressCredits() {
        let alert = UIAlertController(title: "This data comes from:", message: "We The People API of the WhiteHouse", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        present(alert, animated: true)
    }
    
    @objc func didPressFilter() {
        let alert = UIAlertController(title: "Filter", message: "Enter the text to look for", preferredStyle: .alert)
        alert.addTextField()
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "LookUp", style: .default, handler: { _ in
            self.keyWord = alert.textFields?[0].text ?? ""
            self.filterData()
            self.table.reloadData()
        }))
        present(alert, animated: true)
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = petitions[indexPath.row].title
        cell.detailTextLabel?.text = petitions[indexPath.row].body
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailVC()
        vc.details = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

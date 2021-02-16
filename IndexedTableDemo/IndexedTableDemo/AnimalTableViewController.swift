//
//  ViewController.swift
//  IndexedTableDemo
//
//  Created by Simon Ng on 28/1/2021.
//

import UIKit

class AnimalTableViewController: UITableViewController {

    // MARK: - Properties -
    
    var animalsDict = [String : [String]]()
    var animalSectionTitles = [String]()
    
    lazy var dataSource = configureDataSource()
    
    let animals = ["Bear", "Black Swan", "Buffalo", "Camel", "Cockatoo", "Dog", "Donkey", "Emu", "Giraffe", "Greater Rhea", "Hippopotamus", "Horse", "Koala", "Lion", "Llama", "Manatus", "Meerkat", "Panda", "Peacock", "Pig", "Platypus", "Polar Bear", "Rhinoceros", "Seagull", "Tasmania Devil", "Whale", "Whale Shark", "Wombat"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createAnimalDict()
        tableView.dataSource = dataSource
        updateSnapshot()
    }

    // MARK: - Helper Method -

//    In this method, we loop through all the items in the animals array. For each item, we initially extract the first letter of the animal's name. To obtain an index for a specific position (i.e. String.Index ), you have to ask the string itself for the startIndex and then call the index method to get the desired position. In this case, the target position is 1 , since we are only interested in the first character.
    
//    In older version of Swift, you use substring(to:) method of a string to get a new string containing the characters up to a given index. Now, the method has been deprecated. Instead, you slice a string into a substring using subscripting like this:
//    let animalKey = String(animal[..<firstLetterIndex])
    
//    animal[..<firstLetterIndex] slices the animal string up to the specified index. In the above case, it means to extract the first character. You may wonder why we need to wrap the returned substring with a String initialization. In Swift 4, when you slice a string into a substring, you will get a Substring instance. It is a temporary object, sharing its storage with the original string. In order to convert a Substring instance to a String instance, you will need to wrap it with String() .

    private func createAnimalDict() {
        for animal in animals {
            // Get the first letter of the animal name and build the dictionary
            let firstLetterIndex = animal.index(animal.startIndex, offsetBy: 1)
            let animalKey = String(animal[..<firstLetterIndex])
            
            if var animalValues = animalsDict[animalKey] {
                animalValues.append(animal)
                animalsDict[animalKey] = animalValues
            } else {
                animalsDict[animalKey] = [animal]
            }
        }
        
        // Get the section titles from the dictionary's keys and sort them in ascending order
        animalSectionTitles = [String](animalsDict.keys)
        animalSectionTitles.sort(by: { $0 < $1 })
    }
}

extension AnimalTableViewController {
    
    func configureDataSource() -> UITableViewDiffableDataSource<String, String> {

         let dataSource = AnimalTableDataSource(tableView: tableView) { (tableView, indexPath, animalName) -> UITableViewCell? in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            
            // Configure the cell...
            cell.textLabel?.text = animalName
            
            // Convert the animal name to lower case and
            // then replace all occurences of a space with an underscore
            let imageFileName = animalName.lowercased().replacingOccurrences(of: " ", with: "_")
            cell.imageView?.image = UIImage(named: imageFileName)
            
            
            return cell
        }

        return dataSource
    }
    
    func updateSnapshot(animatingChange: Bool = false) {
//  Modify the updateSnapshot method like this to organize the item into different sections:
//  Instead of putting all items in the "all" section, we modify the code to create a snapshot with different sections (i.e. snapshot.appendSections(animalSectionTitles) ). And, for each section, we add the correct animal items to it.
        
        // Create a snapshot and populate the data
        var snapshot = NSDiffableDataSourceSnapshot<String, String>()
        snapshot.appendSections(animalSectionTitles)
        animalSectionTitles.forEach { (section) in
            if let animals = animalsDict[section] {
                snapshot.appendItems(animals, toSection: section)
            }
        }

        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
}

extension AnimalTableViewController {
   
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let headerView = view as! UITableViewHeaderFooterView
        headerView.backgroundView?.backgroundColor = UIColor(red: 236.0/255.0, green: 240.0/255.0, blue: 241.0/255.0, alpha: 1.0)
        headerView.textLabel?.textColor = UIColor(red: 231.0/255.0, green: 76.0/255.0, blue: 60.0/255.0, alpha: 1.0)

        headerView.textLabel?.font = UIFont(name: "Avenir", size: 25.0)
    }
    
//    Before the section header view is displayed, the tableView(_:willDisplayHeaderView:forSection:) method will be called. The method
//    includes an argument named view . This view object can be a custom header view or a standard one. In our demo, we just use the standard header view, which is the
//    UITableViewHeaderFooterView object. Once you have the header view, you can alter the text color, font, and background color.
    
//    When you need to display a large number of records, it is simple and effective to organize the data into sections and provide an index list for easy access.

}

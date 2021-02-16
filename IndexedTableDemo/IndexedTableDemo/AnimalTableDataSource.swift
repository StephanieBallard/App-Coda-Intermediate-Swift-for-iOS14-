//
//  AnimalTableDataSource.swift
//  IndexedTableDemo
//
//  Created by Stephanie Ballard on 2/15/21.
//

import UIKit

//In the starter project, we use the UITableViewDiffableDataSource class directly. To override the method above and provide our own implementation, we have to create a custom diffable data source. In the project navigator, right click IndexedTableDemo and choose New file.... Use the Swift file template and name it AnimalTableDataSource.

class AnimalTableDataSource: UITableViewDiffableDataSource<String, String> {
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.snapshot().sectionIdentifiers[section]
    }
    
//    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
//        return self.snapshot().sectionIdentifiers
//    }
    // can use either one of these. ^ only includes the first letters of the animals we have
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    }
    
    override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        guard let index = self.snapshot().sectionIdentifiers.firstIndex(of: title) else { return -1 }
        return index
    }
}
    
//    ^The whole point of the implementation is to verify if the given title can be found in the section identifiers and return the corresponding index. Then the table view moves to the corresponding section. For instance, if the title is B , we check that B is a valid section title and return the index 1 . In case the title is not found (e.g. A ), we return -1 .

//We create a custom diffable data source by extending UITableViewDiffableDataSource and override the required method. In the method, we simply return the title of the given section number.

//The first method provides the content of the index list. Here we return the section titles. The second method returns the index of the section having the given title and section title index. By implementing this method, your app can scroll to a particular section of the table when the user taps any of the indexes.


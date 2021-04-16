//
//  ArticleTableViewController.swift
//  TableCellAnimation
//
//  Created by Simon Ng on 3/10/2020.
//  Copyright © 2020 AppCoda. All rights reserved.
//

import UIKit

class ArticleTableViewController: UITableViewController {
    
    enum Section {
        case all
    }
    
    let articles = [ Article(title: "Use Background Transfer Service To Download File in Background", image: "imessage-sticker-pack"),
                     Article(title: "Face Detection in iOS Using Core Image", image: "face-detection-featured"),
                     Article(title: "Building a Speech-to-Text App Using Speech Framework in iOS", image: "speech-kit-featured"),
                     Article(title: "Building Your First Web App in Swift Using Vapor", image: "vapor-web-framework"),
                     Article(title: "Creating Gradient Colors Using CAGradientLayer", image: "cagradientlayer-demo"),
                     Article(title: "A Beginner's Guide to CALayer", image: "calayer-featured")
    ]
    
    lazy var dataSource = configureDataSource()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateSnapshot()
        
        tableView.estimatedRowHeight = 258.0
        tableView.rowHeight = UITableView.automaticDimension
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .automatic
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureDataSource() -> UITableViewDiffableDataSource<Section, Article> {
        
        let cellIdentifier = "Cell"
        
        let dataSource = UITableViewDiffableDataSource<Section, Article>(
            tableView: tableView,
            cellProvider: {  tableView, indexPath, article in
                let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ArticleTableViewCell
                
                cell.titleLabel.text = article.title
                cell.postImageView.image = UIImage(named: article.image)
                
                return cell
            }
        )
        
        return dataSource
    }
    
    func updateSnapshot(animatingChange: Bool = false) {
        
        // Create a snapshot and populate the data
        var snapshot = NSDiffableDataSourceSnapshot<Section, Article>()
        snapshot.appendSections([.all])
        snapshot.appendItems(articles, toSection: .all)
        
        dataSource.apply(snapshot, animatingDifferences: animatingChange)
    }
    
    // FADE - in Animation
//    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        // Define the initial state (Before the animation)
//        cell.alpha = 0
//        // Define the final state (After the animation)
//        UIView.animate(withDuration: 1.0, animations: { cell.alpha = 1 })
//    }
    
//    Core Animation provides iOS developers with an easy way to create animation. All you need to do is define the initial and final state of the visual element. Core Animation will then figure out the required animation between these two states.
//    In the code above, we first set the initial alpha value of the cell to 0 , which represents total transparency. Then we begin the animation; set the duration to 1 second and define the final state of the cell, which is completely opaque. This will automatically create a fade-in effect when the table cell appears.
    
    // Creating a Rotation Effect Using CATransform3D
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        // Define the initial state (Before the animation)
        let rotationAngleInRadians = 90.0 * CGFloat(Double.pi / 180.0)
        let rotationTransform = CATransform3DMakeRotation(rotationAngleInRadians, 0, 0, 1)
        cell.layer.transform = rotationTransform
        
        // Define the final state (After the animation)
        UIView.animate(withDuration: 1.0, animations: { cell.layer.transform = CATransform3DIdentity })
    }
    
//    Same as before, we define the initial and final state of the transformation. The general idea is that we first rotate the cell by 90 degrees clockwise and then bring it back to the normal orientation which is the final state.
//    Okay, but how can we rotate a table cell by 90 degrees clockwise?
//    The key is to use the CATransform3DMakeRotation function to create the rotation transform. The function takes four parameters:
//    Angle in radians - this is the angle of rotation. As the angle is in radian, we first
//    need to convert the degrees to radians.
//    X-axis - this is the axis that goes from the left of the screen to the right of the screen. Y-axis - this is the axis that goes from the top of the screen to the bottom of the screen.
//    Z-axis - this is the axis that points directly out of the screen.
//    Since the rotation is around the Z axis, we set the value of this parameter to 1 , while leaving the value of the X axis and Y axis at 0 . Once we create the transform, it is assigned to the cell's layer.
//    Next, we start the animation with the duration of 1 second. The final state of the cell is set to CATransform3DIdentity , which will reset the cell to the original position.
    
//    Quick Tip: You may wonder what CATransform3D is. It is actually a structure representing a matrix. Performing transformation in 3D space such as rotation involves some matrices calculation. I’ll not go into the details of matrices calculation. If you want to learn more, you can check out http://www.opengl- tutorial.org/beginners-tutorials/tutorial-3-matrices/.
    
//    Creating a Fly-in Effect using CATransform3DTranslate
//    Does the rotation effect look cool? You can further tweak the animation to make it even better. Try to change the tableView(_:willDisplay:forRowAt:) method and replace the initialization of rotationTransform with the following line of code:
//
//    let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, -500, 100, 0 )
//    
//    The line of code simply translates or shifts the position of the cell. It indicates the cell is shifted to the left (negative value) by 500 points and down (positive value) by 100 points. There is no change in the Z axis.
//    Now you're ready to test the app again. Hit the Run button and play around with the fly- in effect.
}

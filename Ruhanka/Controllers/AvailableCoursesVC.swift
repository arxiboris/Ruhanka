//
//  AvailableCoursesVC.swift
//  Ruhanka
//
//  Created by Oleksandr Borysenko on 07.07.2023.
//

import UIKit
import FirebaseAuth

class AvailableCoursesVC: UIViewController {
    
    let marafonNog = Course(courseImage: #imageLiteral(resourceName: "course1"), courseLevel: [easyLevel,mediumLevel], courseType: [yogaType], courseBody: [shouldersPart], courseTitle: "Марафон Ніг", courseAuthor: "Dasha Harchenko", courseLength: "20 дней")
    
    let marafonPlechey = Course(courseImage: #imageLiteral(resourceName: "course2"), courseLevel: [easyLevel], courseType: [yogaType], courseBody: [shouldersPart], courseTitle: "Марафон Плечей", courseAuthor: "Даша Харченко", courseLength: "15 дней")
    
    let marafonNog2 = Course(courseImage: #imageLiteral(resourceName: "course1"), courseLevel: [easyLevel,mediumLevel], courseType: [yogaType], courseBody: [shouldersPart], courseTitle: "Марафон Ніг", courseAuthor: "Dasha Harchenko", courseLength: "20 дней")
    
    let marafonPlechey2 = Course(courseImage: #imageLiteral(resourceName: "course2"), courseLevel: [easyLevel], courseType: [yogaType], courseBody: [shouldersPart], courseTitle: "Марафон Плечей", courseAuthor: "Даша Харченко", courseLength: "15 дней")
    
    let marafonNog3 = Course(courseImage: #imageLiteral(resourceName: "course1"), courseLevel: [easyLevel,mediumLevel], courseType: [yogaType], courseBody: [shouldersPart], courseTitle: "Марафон Ніг", courseAuthor: "Dasha Harchenko", courseLength: "20 дней")
    
    
    var availableCourses: [Course] { //computed variable
        return  [marafonNog, marafonPlechey,marafonNog2,marafonPlechey2,marafonNog3]
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.setHidesBackButton(true, animated: true) // hides back button
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.reusableCell)
        
      
    }
    
    @IBAction func logOutBtn(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)// go to firsrt VC in stack
        } catch let signOutError as NSError {
            createAlert(from: self, errorText: signOutError.localizedDescription)
        }
        
    }
    
    
    
}


extension AvailableCoursesVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return availableCourses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell  {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.reusableCell, for: indexPath) as! CourseCell //create reusable cell with all properties of custom cell
        cell.courseTitle.text = availableCourses[indexPath.row].courseTitle
        cell.courseMainImage.image = availableCourses[indexPath.row].courseImage
        return cell
    }
    
    
}

extension AvailableCoursesVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { //tells the delegate that the current row is selected
        print(indexPath.row)
    }
}

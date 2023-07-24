//
//  PartofCourse.swift
//  Ruhanka
//
//  Created by Oleksandr Borysenko on 17.07.2023.
//

import UIKit
import FirebaseAuth

class PartOfCourseVC: UIViewController {
    var courseTitle: String = ""
    var allPartsOfCourse = myCourseParts
    var filteredPartsOfCourse: [CoursePart] = []
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.reusableCell)
        filteredPartsOfCourse = allPartsOfCourse.filter {$0.courseTitle == courseTitle}
    }
    
}

//filteredPartsOfCourse = partsOfCourse.filter {$0.courseNumber ==  filteredCourses[indexPath.row].courseNumber }

extension PartOfCourseVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPartsOfCourse.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell  {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.reusableCell, for: indexPath) as! CourseCellVC //create reusable cell with all properties of custom cell
      
        cell.courseTitle.text = "\(filteredPartsOfCourse[indexPath.row].courseTitle).   \(filteredPartsOfCourse[indexPath.row].coursePart)"
        cell.courseMainImage.image = filteredPartsOfCourse[indexPath.row].coursePartImage
            cell.courseAuthor.text = filteredPartsOfCourse[indexPath.row].courseAuthor
            cell.courseLevel.text = ""
            for (index,element) in filteredPartsOfCourse[indexPath.row].courseLevel.enumerated() {
                cell.courseLevel.text! += "\(element.level) "
                if index+1 < filteredPartsOfCourse[indexPath.row].courseLevel.count {
                    cell.courseLevel.text! += "/ "
                } else {
                    cell.courseLevel.text! += "  "
                }
            }
            
            cell.courseType.text = ""
            for (index, element) in filteredPartsOfCourse[indexPath.row].courseType.enumerated() {
                cell.courseType.text! += "\(element.type)  "
                if index+1 < filteredPartsOfCourse[indexPath.row].courseType.count {
                    cell.courseType.text! += "·  "
                }
            }
            cell.courseLength.text = "·   \(filteredPartsOfCourse[indexPath.row].coursePartLength)"
            cell.courseMainImage.makeRoundCorners(byRadius: 20)
           
        return cell
    }
    
    
}

extension PartOfCourseVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { //tells the delegate that the current row is selected
        self.performSegue(withIdentifier: K.Segues.partOfCourseToCourseMainPage, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if segue.identifier == K.Segues.partOfCourseToCourseMainPage {
          if let destinationVC = segue.destination as? CourseMainPageVC {
               if let indexPath = tableView.indexPathForSelectedRow {
                    let courseImage = filteredPartsOfCourse[indexPath.row].coursePartImage
                    let  courseTitle = "\(filteredPartsOfCourse[indexPath.row].courseTitle).   \(filteredPartsOfCourse[indexPath.row].coursePart)"
                    let courseAuthor = filteredPartsOfCourse[indexPath.row].courseAuthor
                    let courseLength  = "·   \(filteredPartsOfCourse[indexPath.row].coursePartLength)"
                   var courseLevel = ""
                   for (index,element) in filteredPartsOfCourse[indexPath.row].courseLevel.enumerated() {
                       courseLevel += "\(element.level) "
                       if index+1 < filteredPartsOfCourse[indexPath.row].courseLevel.count {
                           courseLevel += "/ "
                       } else {
                           courseLevel += "  "
                       }
                   }
                   var courseType = ""
                   for (index, element) in filteredPartsOfCourse[indexPath.row].courseType.enumerated() {
                       courseType += "\(element.type)  "
                       if index+1 < filteredPartsOfCourse[indexPath.row].courseType.count {
                           courseType += "·  "
                       }
                   }
                   let courseDescription = filteredPartsOfCourse[indexPath.row].coursePartDescription
                   
                    destinationVC.courseImage = courseImage
                    destinationVC.courseTitle =  courseTitle
                    destinationVC.courseAuthor = courseAuthor
                    destinationVC.courseLength = courseLength
                    destinationVC.courseLevel = courseLevel
                    destinationVC.courseType = courseType
                    destinationVC.courseDescription = courseDescription
                   
               }
           }
        }
    }

}


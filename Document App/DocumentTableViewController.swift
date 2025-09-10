//
//  DocumentTableViewController.swift
//  Document App
//
//  Created by Jordan LEBRET on 9/10/25.
//

import UIKit

class DocumentTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listFileInBundle().count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DocumentCell", for: indexPath)

        let documentView = listFileInBundle()[indexPath.row]
        
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = documentView.title
        contentConfiguration.secondaryText = documentView.size.formattedSize()
        cell.contentConfiguration = contentConfiguration

        return cell
    }
    
    struct DocumentFile {
        var title: String
        var size: Int
        var imageName: String? = nil
        var url: URL
        var type: String
    }
    
    func listFileInBundle() -> [DocumentFile] {
            
            let fm = FileManager.default
            let path = Bundle.main.resourcePath!
            let items = try! fm.contentsOfDirectory(atPath: path)
            
            var documentListBundle = [DocumentFile]()
        
            for item in items {
                if !item.hasSuffix("DS_Store") && item.hasSuffix(".jpg") {
                    let currentUrl = URL(fileURLWithPath: path + "/" + item)
                    let resourcesValues = try! currentUrl.resourceValues(forKeys: [.contentTypeKey, .nameKey, .fileSizeKey])
                       
                    documentListBundle.append(DocumentFile(
                        title: resourcesValues.name!,
                        size: resourcesValues.fileSize ?? 0,
                        imageName: item,
                        url: currentUrl,
                        type: resourcesValues.contentType!.description)
                    )
                }
            }
            return documentListBundle
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow {
                    let selectedRow = indexPath.row
            if let destinationVC = segue.destination as? DetailViewController {
                destinationVC.imageName = listFileInBundle()[selectedRow].imageName
            }
                }
        }
}

extension Int {
    func formattedSize() -> String {
        return ByteCountFormatter.string(fromByteCount: Int64(self), countStyle: ByteCountFormatter.CountStyle.file)
    }
}

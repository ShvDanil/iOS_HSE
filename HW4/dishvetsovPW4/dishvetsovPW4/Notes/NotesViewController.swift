//
//  NotesViewController.swift
//  dishvetsovPW4
//
//  Created by Danil Shvetsov on 19.11.2022.
//

import UIKit

/// Notes controller.
final class NotesViewController: UIViewController {
    
    // Identifier for registration of notes view controller.
    static let reuseIdentifier = "NotesViewController"
    
    // Reference to managed object context.
    public static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // Main component of controller.
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    // Array which contains all short note objects which data will be presented in cells.
    private var dataSource = [ShortNoteEntity]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = CustomColors.set(to: .majorBackgroundDarkGray)
        
        fetchShortNotes()
    }
    
    /// Function where notes data fetches to dataSource array from ShortNoteEntity in storage.
    private func fetchShortNotes() {
        do {
            self.dataSource = try NotesViewController.context.fetch(ShortNoteEntity.fetchRequest())
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            print("Log: error while fetching data of [ShortNoteEntity]!")
        }
        
        // To be honest, I didn't really understand why entities upload reversed from db ;) that's why there is a line below ))
        dataSource.reverse()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupView()
    }
    
    /// Function which sets view up.
    private func setupView() {
        setupTableView()
        setupNavBar()
    }
    
    /// Setup of table view.
    private func setupTableView() {
        // Registration of main cell types (NoteCell + AddNoteCell).
        tableView.register(NoteCell.self, forCellReuseIdentifier: NoteCell.reuseIdentifier)
        tableView.register(AddNoteCell.self, forCellReuseIdentifier: AddNoteCell.reuseIdentifier)
        
        // Setup of table view appearance + behaviour.
        tableView.backgroundColor = .clear
        tableView.separatorColor = CustomColors.set(to: .majorFontWhite)
        tableView.keyboardDismissMode = .onDrag
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        tableView.pin(to: self.view)
    }
    
    /// Navigation bar setup.
    private func setupNavBar() {
        // Setup of title and its' color.
        self.title = "Notes"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: CustomColors.set(to: .majorFontWhite)]
        
        // Setup of close button.
        let closeButton = UIButton(type: .close)
        closeButton.addTarget(
            self,
            action: #selector(dismissViewController(_:)),
            for: .touchUpInside
        )
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: closeButton)
    }
    
    /// Function which handles the delete of cell with short note.
    /// - Parameter indexPath: Index of chosen cell.
    private func handleDelete(indexPath: IndexPath) {
        let shortNoteToRemove = self.dataSource.remove(at: indexPath.row)
        NotesViewController.context.delete(shortNoteToRemove)
        
        do {
            try NotesViewController.context.save()
        } catch {
            print("Log: error deleting short note!")
        }
        
        tableView.reloadData()
    }
    
    /// Action which handles the event of return to previous contoller.
    /// - Parameter sender: Sender data.
    @objc
    private func dismissViewController(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

// Extension which handles appearance.
extension NotesViewController: UITableViewDataSource {
    // Defines number of sections in table view.
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // Defines number of rows according to chosen section.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return dataSource.count
        }
    }
    
    // Defines the display of cells.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if let addNewCell = tableView.dequeueReusableCell(withIdentifier: AddNoteCell.reuseIdentifier, for: indexPath) as? AddNoteCell {
                addNewCell.delegate = self
                return addNewCell
            }

        default:
            let note = dataSource[indexPath.row]

            if let noteCell = tableView.dequeueReusableCell(withIdentifier: NoteCell.reuseIdentifier, for: indexPath) as? NoteCell {
                noteCell.configure(note)
                return noteCell
            }
        }

        return UITableViewCell()
    }
}

// Extension which handles behaviour.
extension NotesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        if (indexPath.section != 1) {
            return nil
        }
        
        let deleteAction = UIContextualAction(
            style: .destructive,
            title: .none
        ) { [weak self] (action, view, completion) in
            self?.handleDelete(indexPath: indexPath)
            completion(true)
        }
        deleteAction.image = UIImage(
            systemName: "trash.fill",
            withConfiguration: UIImage.SymbolConfiguration(weight: .bold)
        )?.withTintColor(.white)
        deleteAction.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

extension NotesViewController: AddNoteDelegate {
    /// Adds new short note entity.
    /// - Parameter note: Short note entity.
    func newNoteAdded(note: ShortNoteEntity) {
        dataSource.insert(note, at: 0)
        tableView.reloadData()
    }
}

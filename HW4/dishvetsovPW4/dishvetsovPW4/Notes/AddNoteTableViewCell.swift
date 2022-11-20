//
//  AddNoteTableViewCell.swift
//  dishvetsovPW4
//
//  Created by Danil Shvetsov on 19.11.2022.
//

import UIKit


/// Protocol for adding short notes.
protocol AddNoteDelegate: AnyObject {
    func newNoteAdded(note: ShortNoteEntity)
}

/// Add short notes cell class.
final class AddNoteCell: UITableViewCell {
    
    // Identifier for registration of add note cells.
    static let reuseIdentifier = "AddNoteCell"
    
    // Main components of cell.
    private var textView = UITextView()
    private var addButton = UIButton()
    
    // Delegate of cell.
    internal var delegate: AddNoteDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        setupView()
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    /// Setup of view components (behaviour + appearance).
    private func setupView() {
        // Text view setup.
        textView.font = .systemFont(ofSize: 14, weight: .regular)
        textView.textColor = .black
        textView.backgroundColor = .clear
        textView.setHeight(to: 140)
        textView.delegate = self
        
        // Add button setup.
        addButton.setTitle("Add new note", for: .normal)
        addButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        addButton.setTitleColor(.systemBackground, for: .normal)
        addButton.backgroundColor = .label
        addButton.layer.cornerRadius = 8
        addButton.setHeight(to: 44)
        addButton.addTarget(
            self,
            action: #selector(addButtonTapped(_:)),
            for: .touchUpInside
        )
        addButton.isEnabled = false
        addButton.alpha = 0.5
        
        // Stack view with all components beyond.
        let stackView = UIStackView(arrangedSubviews: [textView, addButton])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fill
        contentView.addSubview(stackView)
        stackView.pin(to: contentView, [.left: 16, .top: 16, .right: 16])
        let cs = stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        cs.priority = .defaultHigh
        cs.isActive = true
        contentView.backgroundColor = .systemGray5
    }
    
    /// Function which clears the text in view after its' value had been added as a new short note to list of notes.
    private func clearTextView() {
        textView.selectAll(textView)
        if let range = textView.selectedTextRange {
            textView.replace(range, withText: "")
        }
    }
    
    /// Action which handles the event of press of add button.
    /// - Parameter sender: Sender data.
    @objc
    private func addButtonTapped(_ sender: UIButton) {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        
        // Create a new short note object.
        let newShortNoteEntity = ShortNoteEntity(context: NotesViewController.context)
        newShortNoteEntity.text = textView.text
        
        // Save a new short note object.
        do {
            try NotesViewController.context.save()
        } catch {
            print("A log of error while fetching data!")
        }
        
        delegate?.newNoteAdded(note: newShortNoteEntity)
        clearTextView()
    }
}

extension AddNoteCell: UITextViewDelegate {
    /// Delegate function which observes the changes inside textView.
    /// - Parameter textView: view where user will enter short note text.
    public func textViewDidChange(_ textView: UITextView) {
        addButton.isEnabled = !textView.text.isEmpty
        addButton.alpha = addButton.isEnabled ? 0.75 : 0.5
    }
}

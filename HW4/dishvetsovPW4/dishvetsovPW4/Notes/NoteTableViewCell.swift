//
//  NoteTableViewCell.swift
//  dishvetsovPW4
//
//  Created by Danil Shvetsov on 19.11.2022.
//

import UIKit

/// Note cell class.
final class NoteCell: UITableViewCell {
    
    // Identifier for registration of note cells.
    static let reuseIdentifier = "NoteCell"
    
    // Main text label with note data.
    private var textlabel = UILabel()
    
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
    
    /// Setup of main components of note cell.
    private func setupView() {
        // Setup of text label.
        textlabel.font = .systemFont(ofSize: 16, weight: .regular)
        textlabel.textColor = CustomColors.set(to: .majorFontWhite)
        textlabel.numberOfLines = 0
        textlabel.backgroundColor = .clear
        
        // Adding text label to cell.
        contentView.backgroundColor = CustomColors.set(to: .minorBackgroundLightOrange)
        contentView.addSubview(textlabel)
        textlabel.pin(to: contentView, [.left: 16, .top: 16, .right: 16, .bottom: 16])
    }
    
    /// Function which configures the data from note entity to cell text label.
    /// - Parameter note: Note entity.
    public func configure(_ note: ShortNoteEntity) {
        textlabel.text = note.text
    }
}

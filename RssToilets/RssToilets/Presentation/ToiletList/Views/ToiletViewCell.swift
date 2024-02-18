//
//  ToiletViewCell.swift
//  RssToilets
//
//  Created by Ha Kevin on 16/02/2024.
//

import Foundation
import UIKit

final class ToiletViewCell: UITableViewCell {
    // MARK: - Subviews

    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()

    private lazy var openingHourLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()

    private lazy var distanceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()

    private lazy var stackViewIcon: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        stackView.spacing = .paddingSmall
        return stackView
    }()

    private lazy var isAccessiblePrmIcon: UILabel = {
        let imageView = UILabel()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    // MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupInterface()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Reusable

    override func prepareForReuse() {
        super.prepareForReuse()
        resetCell()
    }

    // MARK: - Configure

    func configure(with viewModel: ToiletViewModel) {
        addressLabel.text = viewModel.adressText
        openingHourLabel.text = viewModel.openingHourText
        distanceLabel.text = viewModel.distanceText
        if viewModel.isPrmFriendly {
            isAccessiblePrmIcon.text = viewModel.prmText
            stackViewIcon.addArrangedSubview(isAccessiblePrmIcon)
        } else {
            stackViewIcon.removeArrangedSubview(isAccessiblePrmIcon)
        }
    }

}

// MARK: - Private

private extension ToiletViewCell {
    func resetCell() {
        addressLabel.text = ""
        openingHourLabel.text = ""
        distanceLabel.text = ""
        isAccessiblePrmIcon.text = ""
    }

    func setupInterface() {
        stackViewIcon.addArrangedSubview(addressLabel)
        stackViewIcon.addArrangedSubview(openingHourLabel)
        stackViewIcon.addArrangedSubview(distanceLabel)
        stackViewIcon.addArrangedSubview(isAccessiblePrmIcon)
        contentView.addSubview(stackViewIcon)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackViewIcon.topAnchor.constraint(equalTo: topAnchor, constant: .padding),
            stackViewIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .padding),
            stackViewIcon.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -.padding),
            stackViewIcon.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.padding)
        ])
    }
}

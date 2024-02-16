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
        addressLabel.text = viewModel.address
        openingHourLabel.text = viewModel.openingHour
        distanceLabel.text = viewModel.distance
    }

}

// MARK: - Private

private extension ToiletViewCell {
    func resetCell() {
        addressLabel.text = ""
        openingHourLabel.text = ""
        distanceLabel.text = ""
    }

    func setupInterface() {
        contentView.addSubview(addressLabel)
        contentView.addSubview(openingHourLabel)
        contentView.addSubview(distanceLabel)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            addressLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .padding),
            addressLabel.topAnchor.constraint(equalTo: topAnchor, constant: .paddingSmall),
            addressLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.padding),

            openingHourLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: .paddingSmall),
            openingHourLabel.leadingAnchor.constraint(equalTo: addressLabel.leadingAnchor),

            distanceLabel.topAnchor.constraint(equalTo: openingHourLabel.bottomAnchor, constant: .paddingSmall),
            distanceLabel.leadingAnchor.constraint(equalTo: openingHourLabel.leadingAnchor),
            distanceLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -.padding),
        ])
    }
}

//
//  ReceiptsViewMaker.swift
//  MyFinances
//
//  Created by NIKOLAI BORISOV on 28.06.2021.
//

import UIKit

final class ReceiptsViewMaker {
  
  unowned var container: ReceiptsViewController
  
  init(container: ReceiptsViewController) {
    self.container = container
  }
  
  lazy var chooseButton: UIButton = {
    let button = MFButton(type: .uploadReceipt)
    button.backgroundColor = .customGreen
    return button
  }()
  
  lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    layout.estimatedItemSize = .zero
    let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
    collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: Constants.CollectionViewCell.cellIdentifier)
    collectionView.backgroundColor = .white
    return collectionView
  }()
  
  func setupLayouts() {
    [
      collectionView,
      chooseButton
    ]
    .forEach { container.view.addSubview($0) }
    
    collectionView.snp.makeConstraints { make in
      make.bottom.left.right.top.equalTo(self.container.view)
    }
    chooseButton.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.bottom.equalTo(container.view.safeAreaLayoutGuide).inset(17)
      make.left.equalToSuperview().offset(20)
    }
  }
  
}

//
//  ViewController.swift
//  CalculatorApp
//
//  Created by shinichiro kudo on 2021/02/13.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // UICollectionViewDelegateFlowLayoutは、セルの大きさやコレクションビューのヘッダーサイズなど、レイアウトに関するメソッドを取得できるもの
    // コレクションビューの必須要素の設定
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return numbers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numbers[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: collectionView.frame.width, height: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 3 * 10) / 4
        return .init(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = calculatorCollectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! calculatorViewCell
        // 詳細な型にダウンキャスト
        
        // 配列から要素を取得
        cell.numberLabel.text = numbers[indexPath.section][indexPath.row]
        
        return cell
    }
    
    
    
    let numbers = [
        //横の列(配列一つ)がsection
        // さらにその配列の要素一つ一つがrow
        ["C", "%", "$", "÷"],
        ["7", "8", "9", "×"],
        ["4", "5", "6", "-"],
        ["1", "2", "3", "+"],
        ["0", ".", "="]
    ]

    // 各種UIの関連付け
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var calculatorCollectionView: UICollectionView!
    @IBOutlet weak var calculatorHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 以下view読み込み後に実行される要素
        
        calculatorCollectionView.delegate = self
        calculatorCollectionView.dataSource = self
        calculatorCollectionView.register(calculatorViewCell.self, forCellWithReuseIdentifier: "cellID")
        calculatorHeightConstraint.constant = view.frame.width * 1.4
        calculatorCollectionView.backgroundColor = .clear
        
        view.backgroundColor = .black
    }


}



// 以下calculatorViewCell固有の設定
class calculatorViewCell: UICollectionViewCell {
    
    // セルのラベル中身をクロージャで設定
    let numberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.text = "1"
        label.font = .boldSystemFont(ofSize: 32)
        label.backgroundColor = .orange
        label.clipsToBounds = true
        return label
    }()
    
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        addSubview(numberLabel)
        
        numberLabel.frame.size = self.frame.size
        numberLabel.layer.cornerRadius = self.frame.height / 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

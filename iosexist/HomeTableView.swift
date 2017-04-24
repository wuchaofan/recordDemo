//
//  HomeTableView.swift
//  iosexist
//


import UIKit

class HomeTableView: UITableView {

    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        separatorStyle = .none
        backgroundColor = UIColor.clear
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }


}

extension HomeTableView{
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        print(contentOffset)
        
        return true
    }
}

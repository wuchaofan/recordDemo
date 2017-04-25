//
//  ImagePickerVC.swift
//  iosexist
//

import UIKit
import Photos

class ImagePickerVC: UIViewController {

    var collectionView: UICollectionView?
    
    var assets:PHFetchResult<PHAsset>?
    
    let sideSize: CGFloat = UIScreen.main.bounds.width/4
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let footView = UIView()
        view.addSubview(footView)
        footView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(44)
        }
        footView.backgroundColor = UIColor.black
        let backBtn = UIButton()
        footView.addSubview(backBtn)
        backBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
        backBtn.setImage(#imageLiteral(resourceName: "back"), for: .normal)
        backBtn.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        layout.itemSize = CGSize(width: sideSize, height: sideSize)
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 0
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        view.addSubview(collectionView!)
        collectionView?.snp.makeConstraints({ (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(20)
            make.bottom.equalTo(footView.snp.top)
        })
        
        let finishBtn = UIButton()
        footView.addSubview(finishBtn)
        finishBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 50, height: 34))
        }
        finishBtn.setTitle("完成", for: .normal)
        finishBtn.addTarget(self, action: #selector(finishAction), for: .touchUpInside)

        assets = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: nil)
        
        collectionView?.dataSource = self
        
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "lcell")

    }
    func finishAction(){
        dismiss(animated: true, completion: nil)
    }
    func backAction(){
        dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ImagePickerVC: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.assets?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "lcell", for: indexPath)
        let imageView = UIImageView(frame: cell.contentView.bounds)
        cell.contentView.addSubview(imageView)
        
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = true
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key:"creationDate", ascending: true)]
        
        PHImageManager.default().requestImage(for: assets![indexPath.row], targetSize: CGSize(width: sideSize,height: sideSize), contentMode: .aspectFill, options: requestOptions) { (image, _) in
            imageView.image = image
        }

        return cell
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

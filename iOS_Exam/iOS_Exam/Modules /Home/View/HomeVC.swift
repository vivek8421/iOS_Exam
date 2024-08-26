//
//
//  HomeVC.swift
//  iOS_Exam
//


import UIKit

class HomeVC: UIViewController {
// MARK: - Outlets
    @IBOutlet weak var homePageTableView: UITableView!
    
    private let viewModel = HomeViewModel()
    
// MARK: - ViewLifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
       configuration()
       viewModel.fetchData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
}

// MARK: - Configuratins
extension HomeVC{
    private func configuration(){
        homePageTableView.dataSource = self
        homePageTableView.delegate = self
        homePageTableView.rowHeight = 220
        homePageTableView.register(HomePageBannerCell.nib, forCellReuseIdentifier: HomePageBannerCell.id)
//        homePageTableView.register(NewsCell.nib, forCellReuseIdentifier: NewsCell.identifier)
    }
}


extension HomeVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            guard let cell = homePageTableView.dequeueReusableCell(withIdentifier: HomePageBannerCell.id, for: indexPath) as? HomePageBannerCell else { fatalError("xib doesn't exist")
            }
            return cell
        }
//        else {
//            guard let cell = homePageTableView.dequeueReusableCell(withIdentifier: NewsCell.identifier, for: indexPath) as? NewsCell else { fatalError("xib doesn't exist") }
//            cell.news = viewModel.news[indexPath.row]
//            return cell
//        }
        return UITableViewCell()
    }
}
extension HomeVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (indexPath.row == 0) ? 220 : 120
    }
}

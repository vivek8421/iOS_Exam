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
        homePageTableView.register(HomePageBannerCell.nib, forCellReuseIdentifier: HomePageBannerCell.id)
        homePageTableView.register(TeamPlayerCell.nib, forCellReuseIdentifier: TeamPlayerCell.id)
    }
}


extension HomeVC: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : 30
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            guard let cell = homePageTableView.dequeueReusableCell(withIdentifier: HomePageBannerCell.id, for: indexPath) as? HomePageBannerCell else { fatalError("xib doesn't exist")
            }
            return cell
        }
        else {
            guard let cell = homePageTableView.dequeueReusableCell(withIdentifier: TeamPlayerCell.id, for: indexPath) as? TeamPlayerCell else {
                fatalError("xib doesn't exist") }
           // cell.news = viewModel.news[indexPath.row]
            return cell
        }
    }
}
extension HomeVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (indexPath.section == 0) ? 240 : UITableView.automaticDimension
    }
}

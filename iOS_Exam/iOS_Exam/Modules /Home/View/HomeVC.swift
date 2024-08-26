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
    
// MARK: - Configuration Methods
    private func configuration() {
        viewModel.refresh = { [weak self] in
            guard let self else { return }
            self.homePageTableView.reloadData()
        }
        homePageTableView.dataSource = self
        homePageTableView.delegate = self
        homePageTableView.register(HomePageBannerCell.nib, forCellReuseIdentifier: HomePageBannerCell.id)
        homePageTableView.register(TeamPlayerCell.nib, forCellReuseIdentifier: TeamPlayerCell.id)
    }
}

// MARK: - UITableViewDataSource Methods
extension HomeVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : viewModel.selectedTeamPlayer.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = homePageTableView.dequeueReusableCell(withIdentifier: HomePageBannerCell.id, for: indexPath) as? HomePageBannerCell else {
                return UITableViewCell()
            }
            cell.teams = viewModel.cricketTeams
            cell.didChangeTeam = { [weak self] index in
                guard let self else { return }
                self.viewModel.didChangeTeam(index: index)
            }
            return cell
        } else {
            guard let cell = homePageTableView.dequeueReusableCell(withIdentifier: TeamPlayerCell.id, for: indexPath) as? TeamPlayerCell else {
                return UITableViewCell()
            }
            cell.player = self.viewModel.selectedTeamPlayer[indexPath.row]
            return cell
        }
    }
}

// MARK: - UITableViewDelegate Methods
extension HomeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (indexPath.section == 0) ? 220 : UITableView.automaticDimension
    }
}

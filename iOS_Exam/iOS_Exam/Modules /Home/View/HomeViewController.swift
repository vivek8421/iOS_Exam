//
//
//  HomeVC.swift
//  iOS_Exam
//


import UIKit

class HomeViewController: UIViewController {
// MARK: - Outlets
    @IBOutlet weak var homePageTableView: UITableView!
    @IBOutlet weak var floatingBtn: UIButton!
    
    private let searchBar = UISearchBar()
    private let viewModel = HomeViewModel()
    
    
// MARK: - ViewLifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSearchBar()
        setupFloatingButton()
        viewModel.fetchData()
    }
    
// MARK: - Configuration Methods
    private func setupTableView() {
        viewModel.refresh = { [weak self] in
            guard let self else { return }
            self.homePageTableView.reloadData()
        }
        
        homePageTableView.dataSource = self
        homePageTableView.delegate = self
        let homePageBannerCellNib = UINib(nibName: Constants.homePageBannerCell,
                                          bundle: nil)
        homePageTableView.register(homePageBannerCellNib,
                                   forCellReuseIdentifier: Constants.homePageBannerCell)
        let teamPlayerCellNib = UINib(nibName: Constants.teamPlayerCell,
                                      bundle: nil)
        homePageTableView.register(teamPlayerCellNib,
                                   forCellReuseIdentifier: Constants.teamPlayerCell)
    }
    
    private func setupSearchBar() {
        searchBar.placeholder = "Search Player"
        searchBar.searchBarStyle = .prominent
        searchBar.delegate = self
        searchBar.showsCancelButton = false
        searchBar.sizeToFit()
    }
    
    private func setupFloatingButton() {
        floatingBtn.layer.shadowColor = UIColor.black.cgColor
        floatingBtn.layer.shadowOffset = CGSize(width: 0, height: 4)
        floatingBtn.layer.shadowOpacity = 0.5
        floatingBtn.layer.shadowRadius = 4.0
    }
    
    
    @IBAction func presentBottomSheet(_ sender: Any) {
        if let bottomSheetVC = self.storyboard?.instantiateViewController(withIdentifier: Constants.bottomSheetViewController) as? BottomSheetViewController {
            bottomSheetVC.viewModel.player = viewModel.selectedPlayer
            self.presentBottomSheet(height: 180, viewController: bottomSheetVC)
        }
    }
    
}

// MARK: - UITableViewDataSource Methods
extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : viewModel.selectedFilterTeamPlayers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = homePageTableView.dequeueReusableCell(withIdentifier: Constants.homePageBannerCell, for: indexPath) as? HomePageBannerCell else {
                return UITableViewCell()
            }
            cell.teams = viewModel.cricketTeams
            cell.didChangeTeam = { [weak self] index in
                guard let self else { return }
                let searchText = self.searchBar.text ?? ""
                self.viewModel.didChangeTeam(index: index, searchText: searchText)
                self.title = self.viewModel.cricketTeams[index].country
            }
            return cell
        } else {
            guard let cell = homePageTableView.dequeueReusableCell(withIdentifier: Constants.teamPlayerCell, for: indexPath) as? TeamPlayerCell else {
                return UITableViewCell()
            }
            cell.player = self.viewModel.selectedFilterTeamPlayers[indexPath.row]
            return cell
        }
    }
}


// MARK: - UITableViewDelegate Methods
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (indexPath.section == 0) ? CGFloat(tableView.frame.width * 0.65) : UITableView.automaticDimension
    }
    
    //header Section
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        section == 1 ? searchBar : nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        section == 1 ? 50 : 0
    }
}


// MARK: - UISearchBarDelegate Methods
extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.didSearchPlayer(text: searchText)
        searchBar.showsCancelButton = !searchText.isEmpty
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.selectedFilterTeamPlayers = viewModel.selectedPlayer
        searchBar.text = ""
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton = false
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

import UIKit
import Kingfisher

class ListCell: UITableViewCell {
    static let reuseIdentifier = "ListCell"
    
    private let cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.kf.indicatorType = .activity
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    
    private func commonInit(){
        contentView.addSubview(cellImageView)
        contentView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            
            cellImageView.widthAnchor.constraint(equalToConstant: 80),
            cellImageView.heightAnchor.constraint(equalToConstant: 80),
            cellImageView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            cellImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            nameLabel.leadingAnchor.constraint(equalTo: cellImageView.trailingAnchor, constant: 12),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            nameLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 8),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -8),
        ])
        
        
    }
    
    
    /// Configures Cell with the species response
    /// - Parameter specy: Specy response from API
    func configureCel(specy:Species){
        nameLabel.text = specy.name.capitalized
        
        guard let imageURL = StringUtilities.getImageURLFromSpeciesResponse(urlStr: specy.url.absoluteString) else {
            Logger.log.warning("Failed to fetch image using specy url, url:\(specy.url)")
            return
        }
        
        
        cellImageView.kf.setImage(with: imageURL,
                                  placeholder: UIImage(named: "PlaceholderImage"),
                                  options: [
                                    .transition(.fade(1)),
                                    .cacheOriginalImage
                                  ])
        
    }
    
}

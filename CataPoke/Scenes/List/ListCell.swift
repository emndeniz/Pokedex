import UIKit
import Kingfisher

class ListCell: UICollectionViewCell {
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
        label.font = .systemFont(ofSize: 24, weight: .thin)
        return label
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit(){
        contentView.backgroundColor = .cellBackgroundcolor
        contentView.addSubview(cellImageView)
        contentView.addSubview(nameLabel)
        contentView.layer.cornerRadius = 12
        
        NSLayoutConstraint.activate([
            
            cellImageView.widthAnchor.constraint(equalToConstant: 80),
            cellImageView.heightAnchor.constraint(equalToConstant: 80),
            cellImageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 8),
            cellImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: cellImageView.safeAreaLayoutGuide.bottomAnchor, constant: 8),
            nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
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
                                  options: [
                                    .transition(.fade(1)),
                                    .cacheOriginalImage
                                  ])
        
    }
    
}

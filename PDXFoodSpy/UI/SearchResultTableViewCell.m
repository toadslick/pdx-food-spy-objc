#import "SearchResultTableViewCell.h"

@interface SearchResultTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@end

@implementation SearchResultTableViewCell {
    SearchResult *_searchResult;
}

- (void)setSearchResult:(SearchResult *)searchResult {
    _searchResult = searchResult;
    self.titleLabel.text = searchResult.name;
    self.subtitleLabel.text = searchResult.address;
    self.scoreLabel.text = [searchResult scoreString];
    self.scoreLabel.textColor = [searchResult scoreColor];
}

- (SearchResult *)searchResult {
    return _searchResult;
}

@end

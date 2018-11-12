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
    self.scoreLabel.text = [[[NSNumber alloc] initWithInt:searchResult.score] stringValue];
    self.scoreLabel.textColor = [self scoreTextColor:searchResult.score];
}

- (SearchResult *)searchResult {
    return _searchResult;
}

- (UIColor *)scoreTextColor:(int)score {
    if (score > 99) {
        return [UIColor colorWithRed:0.308 green:0.562 blue:0 alpha:1];
    } else if (score > 89) {
        return [UIColor colorWithRed:0.574 green:0.566 blue:0 alpha:1];
    } else if (score > 79) {
        return [UIColor colorWithRed:0.579 green:0.322 blue:0 alpha:1];
    } else {
        return [UIColor colorWithRed:0.584 green:0.157 blue:0.102 alpha:1];
    }
}



@end

#import "InspectionHistoryTableViewCell.h"

@interface InspectionHistoryTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@end

@implementation InspectionHistoryTableViewCell {
    SearchResult *_searchResult;
}

- (void)setSearchResult:(SearchResult *)searchResult {
    _searchResult = searchResult;
    self.dateLabel.text = [searchResult dateString];
    self.scoreLabel.text = [searchResult scoreString];
    self.scoreLabel.textColor = [searchResult scoreColor];
}

- (SearchResult *)searchResult {
    return _searchResult;
}

@end

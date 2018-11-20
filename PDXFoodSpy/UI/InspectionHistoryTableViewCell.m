#import "InspectionHistoryTableViewCell.h"

@interface InspectionHistoryTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *scoreBar;
@end

@implementation InspectionHistoryTableViewCell {
    SearchResult *_searchResult;
}

- (void)setSearchResult:(SearchResult *)searchResult {
    _searchResult = searchResult;
    UIColor *color = [searchResult scoreColor];
    self.dateLabel.text = [searchResult dateString];
    self.scoreLabel.text = [searchResult scoreString];
    self.scoreLabel.textColor = color;
    self.scoreBar.progress = [searchResult scorePercent];
    self.scoreBar.progressTintColor = color;
}

- (SearchResult *)searchResult {
    return _searchResult;
}

@end

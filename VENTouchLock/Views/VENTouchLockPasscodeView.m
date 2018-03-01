#import "VENTouchLockPasscodeView.h"
#import "VENTouchLockPasscodeCharacterView.h"
#import "PureLayout.h"

@import AudioToolbox;

@interface VENTouchLockPasscodeView ()

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet VENTouchLockPasscodeCharacterView *firstCharacter;
@property (strong, nonatomic) IBOutlet VENTouchLockPasscodeCharacterView *secondCharacter;
@property (strong, nonatomic) IBOutlet VENTouchLockPasscodeCharacterView *thirdCharacter;
@property (strong, nonatomic) IBOutlet VENTouchLockPasscodeCharacterView *fourthCharacter;

@end

@implementation VENTouchLockPasscodeView

- (instancetype)initWithTitle:(NSString *)title frame:(CGRect)frame titleColor:(UIColor *)titleColor characterColor:(UIColor *)characterColor
{
//    NSArray *nibArray = [[NSBundle bundleForClass:[self class]] loadNibNamed:NSStringFromClass([self class])
//                                                      owner:self options:nil];
//    self = [nibArray firstObject];
    if (self = [super initWithFrame:CGRectMake(0, 0, 600, 600)]) {
        self.frame = frame;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
        
        UILabel *titleLabel = [[UILabel alloc] initForAutoLayout];
        [titleLabel setText:@"Create a new Passcode"];
        [titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [self addSubview:titleLabel];
        [titleLabel autoAlignAxis:ALAxisVertical toSameAxisOfView:self withOffset:-0.5];
        
        UIView *container = [[UIView alloc] initForAutoLayout];
        [self addSubview:container];
        [container autoAlignAxis:ALAxisVertical toSameAxisOfView:self withOffset:-0.5];
        [container autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self withOffset:0.5];
        [container autoSetDimensionsToSize:CGSizeMake(140.0f, 20.0f)];
        
        [container autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:titleLabel withOffset:20];
        
        _firstCharacter = [[VENTouchLockPasscodeCharacterView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        _secondCharacter = [[VENTouchLockPasscodeCharacterView alloc] initWithFrame:CGRectMake(40, 0, 20, 20)];
        _thirdCharacter = [[VENTouchLockPasscodeCharacterView alloc] initWithFrame:CGRectMake(80, 0, 20, 20)];
        _fourthCharacter = [[VENTouchLockPasscodeCharacterView alloc] initWithFrame:CGRectMake(120, 0, 20, 20)];
        
        
        _title = title;
        _titleLabel.text = title;
        _titleColor = titleColor;
        _titleLabel.textColor = titleColor;
        _characterColor = characterColor;
        _characters = @[_firstCharacter, _secondCharacter, _thirdCharacter, _fourthCharacter];
        for (VENTouchLockPasscodeCharacterView *characterView in _characters) {
            characterView.fillColor = characterColor;
            [container addSubview:characterView];
        }
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title frame:(CGRect)frame;
{
    return [self initWithTitle:title frame:frame titleColor:[UIColor blackColor] characterColor:[UIColor blackColor]];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithTitle:@"" frame:frame];
}

- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

- (void)shakeAndVibrateCompletion:(void (^)())completionBlock
{
    AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
    [CATransaction begin];
    [CATransaction setCompletionBlock:^{
        if (completionBlock) {
            completionBlock();
        }
    }];
    NSString *keyPath = @"position";
    CABasicAnimation *animation =
    [CABasicAnimation animationWithKeyPath:keyPath];
    [animation setDuration:0.04];
    [animation setRepeatCount:4];
    [animation setAutoreverses:YES];
    CGFloat delta = 10.0;
    CGPoint center = self.center;
    [animation setFromValue:[NSValue valueWithCGPoint:
                             CGPointMake(center.x - delta, center.y)]];
    [animation setToValue:[NSValue valueWithCGPoint:
                           CGPointMake(center.x + delta, center.y)]];
    [[self layer] addAnimation:animation forKey:keyPath];
    [CATransaction commit];
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.text = _title;
}

- (void)setCharacterColor:(UIColor *)characterColor
{
    _characterColor = characterColor;
    for (VENTouchLockPasscodeCharacterView *characterView in self.characters) {
        characterView.fillColor = characterColor;
    }
}

- (void)setTitleColor:(UIColor *)titleColor
{
    _titleColor = titleColor;
    self.titleLabel.textColor = titleColor;
}

@end

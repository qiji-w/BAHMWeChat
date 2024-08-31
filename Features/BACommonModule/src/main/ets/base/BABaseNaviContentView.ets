import { BACommonConstants } from '../constants/BACommonConstants'
import { BANavigationBar } from '../view/BANavigationBar'

@Component
export struct BABaseNaviContentView {
  @Prop leftIcon?: Resource | undefined
  @Prop title?: string | undefined
  @Prop rightIcon?: Resource | undefined
  @Prop navBarBgColor?: string
  @BuilderParam contentView?: () => void
  onBackClick?: (event?: ClickEvent) => void = () => {
  }
  onRightButtonClick?: (event?: ClickEvent) => void = () => {
  }
  onBANavigationBarClick: (event?: ClickEvent) => void = () => {
  }

  //code
  build() {
    Column() {
      BANavigationBar({
        leftIcon: this.leftIcon,
        title: this.title,
        rightIcon: this.rightIcon,
        navBarBgColor: this.navBarBgColor,
        onBackClick: this.onBackClick,
        onRightButtonClick: this.onRightButtonClick,
        onBANavigationBarClick: this.onBANavigationBarClick
      })
        .width(BACommonConstants.PERCENT_FULL)
        .height(BACommonConstants.NAVIGATIONBAR_HEIGHT)

      Column() {
        if (this.contentView) {
          this.contentView()
        }
      }
      .width(BACommonConstants.PERCENT_FULL)
      .height('calc(100% - 64vp)')
    }
    .width(BACommonConstants.PERCENT_FULL)
    .height(BACommonConstants.PERCENT_FULL)
  }
}
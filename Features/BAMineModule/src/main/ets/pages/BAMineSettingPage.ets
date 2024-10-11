import { BABaseNaviContentView, BACommonConstants } from '@ohos/bacommonmodule'
import { AppRouter, DynamicsRouter } from '@ohos/dynamicsrouter'

@AppRouter({ name: "baminemodule/BAMineSettingPage" })
@Component
export struct BAMineSettingPage {
  @Builder
  contentView() {
    Text('设置')
      .textAlign(TextAlign.Center)
      .width(BACommonConstants.PERCENT_FULL)
      .height('calc(100% - 64vp)')
      .fontSize(16)
  }

  //code
  build() {
    Column() {
      BABaseNaviContentView({
        leftIcon: $r('sys.media.ohos_ic_public_arrow_left'),
        contentView: this.contentView,
        onBackClick: (event?: ClickEvent) => {
          DynamicsRouter.popAppRouter()
        }
      })
        .width(BACommonConstants.PERCENT_FULL)
        .height(BACommonConstants.PERCENT_FULL)


    }
  }
}
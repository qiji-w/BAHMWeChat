import { BACommonConstants } from '../constants/BACommonConstants'
import { Image } from '@kit.ArkGraphics3D'
import { BACommonUtil } from '../util/BACommonUtil'
import { BAStringUtil } from '../util/BAStringUtil'

@Component
export struct BANavigationBarTitle {
  @Prop title?: string | undefined

  build() {
    Row() {
      Column() {
        Text(this.title)
          .fontSize(BACommonConstants.FONT_SIZE_NAVI_TITLE)
          .fontWeight(FontWeight.Medium)
          .textAlign(TextAlign.Center)// .backgroundColor(Color.Yellow)
          .alignSelf(ItemAlign.Center)
          .width(BACommonConstants.PERCENT_FULL)
          .height(BACommonConstants.PERCENT_FULL)
      }
      .width(BACommonConstants.PERCENT_FULL)
      .height(BACommonConstants.PERCENT_FULL)
      .layoutWeight(1)
    }
  }
}

@Component
export struct BANavigationBar {
  @Prop leftIcon?: Resource | undefined
  @Prop title?: string | undefined
  @Prop rightIcon?: Resource | undefined
  @Prop navBarBgColor?: string
  onBackClick?: (event?: ClickEvent) => void = () => {
  }
  onCenterClick?: (event?: ClickEvent) => void = () => {
  }
  onRightButtonClick?: (event?: ClickEvent) => void = () => {
  }
  onBANavigationBarClick?: (event?: ClickEvent) => void = () => {
  }

  //code
  build() {
    Row() {
      Row() {
        if (this.leftIcon != undefined) {
          Image(this.leftIcon)// .backgroundColor(Color.Red)
            .objectFit(ImageFit.ScaleDown)
            .sourceSize({
              width: 44,
              height: 44
            })
            .aspectRatio(1)
            .width(28)
            .margin({ left: 18 })
            .onClick(this.onBackClick)
        }
      }
      .width("10%")
      .height(BACommonConstants.PERCENT_FULL)
      .layoutWeight(2)
      .justifyContent(FlexAlign.Start)
      .onClick(this.onBANavigationBarClick)

      Row() {
        if (!BAStringUtil.isStringEmpty(this.title)) {
          BANavigationBarTitle({ title: this.title })
            .width(BACommonConstants.PERCENT_FULL)
            .height(BACommonConstants.PERCENT_FULL)
            .onClick(this.onCenterClick)
        }
      }
      .width('60%')
      .height(BACommonConstants.PERCENT_FULL)
      .layoutWeight(1)
      .onClick(this.onBANavigationBarClick)

      Row() {
        if (this.rightIcon != undefined) {
          Image(this.rightIcon)
            .objectFit(ImageFit.ScaleDown)
            .sourceSize({
              width: 44,
              height: 44
            })
            .aspectRatio(1)
            .width(28)
            .margin({ right: 18 })
            .onClick(this.onRightButtonClick)
        }
      }
      .width('10%')
      .height(BACommonConstants.PERCENT_FULL)
      .justifyContent(FlexAlign.End)
      .layoutWeight(2)
      .onClick(this.onBANavigationBarClick)
    }
    .width(BACommonConstants.PERCENT_FULL)
    .height(BACommonConstants.NAVIGATIONBAR_HEIGHT)
    .backgroundColor(this.navBarBgColor)
    .onClick(this.onBANavigationBarClick)
  }
}





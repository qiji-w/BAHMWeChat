import { BACommonConstants } from '@ohos/bacommonmodule'

@Entry
@Component
export struct BAPyqHeaderView {
  //code

  build() {
    Column() {
      // Stack({ alignContent: Alignment.TopStart }) {
      Image($r('app.media.img_sangshen'))// .backgroundColor(Color.Red)
        .width(BACommonConstants.PERCENT_FULL)
        .height('calc(100% - 20vp)')
        .objectFit(ImageFit.Auto)
        .align(Alignment.Top)
        .margin({ top: -50 })

      Row() {
        Text('奇迹')
          .fontColor(Color.White)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .margin({ top: -10, right: 6 })

        Image('https://img2.baidu.com/it/u=3991072649,2204516516&fm=253&fmt=auto&app=138&f=JPEG?w=551&h=500')
          .width(80)
          .height(80)
          .borderRadius(12)

      }
      // .backgroundColor(Color.Pink)
      .width('50%')
      .height(80)
      .margin({ top: -50, bottom: 20, right: 16 })
      .alignSelf(ItemAlign.End)
      .justifyContent(FlexAlign.End)
    }
    .backgroundColor(Color.White)
    .width(BACommonConstants.PERCENT_FULL)
    .height(BACommonConstants.PERCENT_FULL)
  }
}
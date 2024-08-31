import { XTEasyHUD } from '@jxt/xt_hud/src/main/ets/components/XTEasyHUD'
import { BABaseNaviContentView, BACommonConstants, BALogger } from '@ohos/bacommonmodule';
import { AppRouter, DynamicsRouter } from '@ohos/dynamicsrouter';
import { Logger } from '@yunkss/eftool';
import { BAAddressBookItemView } from '../view/BAAddressBookItemView';
import {
  BAAddressBookItem,
  BAAddressBookModel,
  BAAddressBookSectionType,
  BAAddressBookViewModel
} from '../viewmodel/BAAddressBookViewModel';
import { promptAction } from '@kit.ArkUI';
import { emitter } from '@kit.BasicServicesKit';

const searchController: SearchController = new SearchController()
let searchFlag: boolean = false;

function searchStopEditing() {
  if (searchFlag) {
    searchController.stopEditing()
    searchFlag = false
  }
}

@AppRouter({ name: "baaddressbookmodule/BAAddressBookPage" })
@Entry
@Component
export struct BAAddressBookPage {
  // @State enterTypes: Array<EnterKeyType> = [EnterKeyType.Go, EnterKeyType.Search, EnterKeyType.Send, EnterKeyType.Done, EnterKeyType.Next, EnterKeyType.PREVIOUS, EnterKeyType.NEW_LINE]

  @Builder
  contentView() {
    Search({ placeholder: '搜索', controller: searchController })
      .width('94%')
      .height(44)
      .backgroundColor('#F5F5F5')
      .padding({ left: 8, right: 8 })
      .enterKeyType(EnterKeyType.Go)
      .onEditChange(() => {
        searchFlag = true
        return true;
      })
      .onChange((value: string) => {
        AppStorage.setOrCreate('BAAddressBookSearchName', value)
      })
      .onSubmit((value: string) => {
        AppStorage.setOrCreate('BAAddressBookSearchName', value)
      })

    BAAddressBookList()
      .width(BACommonConstants.PERCENT_FULL)
      .height('calc(100% - 64vp)')
  }

  build() {
    Column() {
      BABaseNaviContentView({
        // leftIcon: $r('sys.media.ohos_ic_public_arrow_left'),
        title: '通讯录',
        rightIcon: $r('app.media.icon_friend_add'),
        contentView: this.contentView,
        onBackClick: (event?: ClickEvent) => {
          searchStopEditing()
        },
        onRightButtonClick: (event?: ClickEvent) => {
          searchStopEditing()
        },
        onBANavigationBarClick: (event?: ClickEvent) => {
          searchStopEditing()
        }
      })
    }
    .width(BACommonConstants.PERCENT_FULL)
    .height(BACommonConstants.PERCENT_FULL)
  }
}

@Component
struct BAAddressBookList {
  private listScroller: Scroller = new Scroller()
  @State selectedListItemIndex: number = 0
  @State indexValues: string[] = BAAddressBookViewModel.getIndexDatas()
  @State BAAddressBooks: BAAddressBookModel[] = BAAddressBookViewModel.datas
  @StorageProp('BAAddressBookSearchName') @Watch('onBAAddressBookSearchName') BAAddressBookSearchName: string = ''

  onBAAddressBookSearchName() {
    if (this.BAAddressBookSearchName) {
      this.BAAddressBooks =
        this.filterBAAddressBooksDataByName(BAAddressBookViewModel.datas, this.BAAddressBookSearchName);
      this.indexValues = BAAddressBookViewModel.getIndexDatas(this.BAAddressBooks)
    } else {
      this.BAAddressBooks = BAAddressBookViewModel.datas
      this.indexValues = BAAddressBookViewModel.getIndexDatas()
    }
  }

  filterBAAddressBooksDataByName(data: BAAddressBookModel[], name: string): BAAddressBookModel[] {
    const firstData = data[0]

    const BAAddressBook: BAAddressBookModel[] = data.filter((addressBook: BAAddressBookModel) => {
      if (addressBook.items != undefined) {
        let addressBookItems = addressBook.items.filter((f => f.name.includes(name)))
        if (addressBookItems.length > 0) {
          addressBook.items = addressBookItems
          return true
        }
      }
      return false
    })

    if (BAAddressBook.length === 0) {
      return []
    }
    BAAddressBook.unshift(firstData)

    return BAAddressBook;
  }

  @Builder
  itemHead(text: string) {
    Row() {
      Text(text)
        .fontSize(16)
        .margin({ left: 16 })
    }
    .backgroundColor($r('app.color.list_background'))
    .width(BACommonConstants.PERCENT_FULL)
    .height(40)
  }

  // 排除头部内容
  isShowHeader(sectionModel: BAAddressBookModel): boolean {
    let isShowHeader: boolean = sectionModel.type != BAAddressBookSectionType.top
    return isShowHeader
  }

  build() {
    Stack({ alignContent: Alignment.End }) {
      List({ space: 0, scroller: this.listScroller }) {

        Repeat<BAAddressBookModel>(this.BAAddressBooks)
          .each((sectionModel: RepeatItem<BAAddressBookModel>) => {
            ListItemGroup({
              header: this.isShowHeader(sectionModel.item) ? this.itemHead(sectionModel.item.sectionTitle) : undefined
            }) {
              Repeat<BAAddressBookItem>(sectionModel.item.items)
                .each((obj: RepeatItem<BAAddressBookItem>) => {
                  BAAddressBookItemView({ itemModel: obj.item })
                    .width(BACommonConstants.PERCENT_FULL)
                    .height(60)
                    .onClick(() => {
                      // XTEasyHUD.showToast('点击了：' + JSON.stringify(obj.item))
                      searchStopEditing()
                      DynamicsRouter.pushUri("baaddressbookmodule/BAPersonDetailPage",obj.item)
                    })
                })
                .key((itemModel: BAAddressBookItem) => itemModel.id.toString())
            }
            .divider({
              strokeWidth: 1,
              color: $r('app.color.list_divider'),
              startMargin: 60,
              endMargin: 0
            }) // 每行之间的分界线
          })
        // .key((itemModel: BADiscoverViewItem) => itemModel.id.toString())
      }
      .layoutWeight(1)
      .listDirection(Axis.Vertical)
      .onScrollIndex((firstIndex: number) => {
        this.selectedListItemIndex = firstIndex
      })
      .onScrollStart(() => {
        searchStopEditing()
      })

      AlphabetIndexer({ arrayValue: this.indexValues, selected: this.selectedListItemIndex })
        .align(Alignment.End)
        .selectedColor(0xFFFFFF)// 选中项文本颜色
        .popupColor(0xFFFAF0)// 弹出框文本颜色
        .selectedBackgroundColor(0xCCCCCC)// 选中项背景颜色
        .popupBackground(0xD2B48C)// 弹出框背景颜色
        .usingPopup(true)// 是否显示弹出框
        .selectedFont({ size: 16, weight: FontWeight.Bolder })// 选中项字体样式
        .popupFont({ size: 30, weight: FontWeight.Bolder })// 弹出框内容的字体样式
        .itemSize(28)// 每一项的尺寸大小
        .alignStyle(IndexerAlign.Left)// 弹出框在索引条右侧弹出
        .popupItemBorderRadius(24)// 设置提示弹窗索引项背板圆角半径
        .itemBorderRadius(14)// 设置索引项背板圆角半径
        .popupBackgroundBlurStyle(BlurStyle.NONE)// 设置提示弹窗的背景模糊材质
        .popupTitleBackground(0xCCCCCC)// 设置提示弹窗首个索引项背板颜色
        .popupSelectedColor(0x00FF00)
        .popupUnselectedColor(0x0000FF)
        .popupItemFont({ size: 30, style: FontStyle.Normal })
        .popupItemBackgroundColor(0xCCCCCC)
        .onSelect((index: number) => {
          console.info(this.indexValues[index] + ' Selected!')
          this.listScroller.scrollToIndex(index)
        })
        .onRequestPopupData((index: number) => {
          // if (this.indexValues[index] == 'A') {
          //   return this.arrayA // 当选中A时，弹出框里面的提示文本列表显示A对应的列表arrayA，选中B、C、L时也同样
          // }
          return []
        })
        .onPopupSelect((index: number) => {
          console.info('onPopupSelected:' + index)
        })


    }
    .backgroundColor($r('app.color.list_background'))
    .width(BACommonConstants.PERCENT_FULL)
    .height(BACommonConstants.PERCENT_FULL)
  }
}
import { XTEasyHUD } from '@jxt/xt_hud'
import { BABaseNaviContentView, BACommonConstants } from '@ohos/bacommonmodule'
import { AppRouter, DynamicsRouter } from '@ohos/dynamicsrouter'
import { BAAddressBookItem } from '../viewmodel/BAAddressBookViewModel'
import BAChatDetail from './ChatDetail/BAChatDetail'


@AppRouter({ name: "baaddressbookmodule/BAPersonDetailPage", hasParam: true })
@Component
export struct BAPersonDetailPage {
  pageStack: NavPathStack = DynamicsRouter.navPathStack;
  addressBook: BAAddressBookItem = {
    id: 0,
    name: ''
  }

  aboutToAppear(): void {
    this.addressBook = this.pageStack.getParamByName("baaddressbookmodule/BAPersonDetailPage")[0] as BAAddressBookItem;
    AppStorage.setOrCreate('addressBook', this.addressBook)
  }

  @Builder
  contentView() {
    Column() {
      BAChatDetail()
    }
  }

  build() {
    Column() {
      BABaseNaviContentView({
        leftIcon: $r('sys.media.ohos_ic_public_arrow_left'),
        title: this.addressBook.name ? this.addressBook.name : '',
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

@Component
struct demo {
  build() {
    Column() {
      Text('详情')
    }
  }
}


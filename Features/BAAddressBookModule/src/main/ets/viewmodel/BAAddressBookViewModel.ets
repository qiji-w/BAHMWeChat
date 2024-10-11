import { BAStringUtil } from '@ohos/bacommonmodule'
import { ArrayList, JSON } from '@kit.ArkTS'

export enum BAAddressBookSectionType {
  default,
  top,
  myCompany,
  starFriend,
}

export class BAAddressBookViewModel {
  //获取通讯录数据
  static datas: BAAddressBookModel[] = [
    {
      type: BAAddressBookSectionType.top,
      sectionTitle: '',
      items: [
        {
          id: 100001,
          icon: $r('app.media.icon_friend_new'),
          name: "新的朋友",
          desc: ""
        },
        {
          id: 100002,
          icon: $r('app.media.icon_friend_onlyChat'),
          name: "仅聊天的朋友",
          desc: ""
        },
        {
          id: 100003,
          icon: $r('app.media.icon_chat_group'),
          name: "群聊",
          desc: ""
        },
        {
          id: 100004,
          icon: $r('app.media.icon_tag'),
          name: "标签",
          desc: ""
        },
        {
          id: 100005,
          icon: $r('app.media.icon_officialAccounts'),
          name: "公众号",
          desc: ""
        },
        {
          id: 100006,
          icon: $r('app.media.icon_companywx'),
          name: "企业微信联系人",
          desc: ""
        }
      ]
    },
    {
      type: BAAddressBookSectionType.myCompany,
      sectionTitle: '我的企业',
      items: [
        {
          id: 100007,
          icon: $r('app.media.icon_didi_chuxing'),
          name: "滴滴打车",
          desc: ""
        },
        {
          id: 100008,
          icon: $r('app.media.icon_didi_waimai'),
          name: "滴滴代驾",
          desc: ""
        }
      ]
    },
    {
      type: BAAddressBookSectionType.starFriend,
      sectionTitle: '※ 星标朋友',
      items: [
        {
          id: 200001,
          icon: "https://img2.baidu.com/it/u=3991072649,2204516516&fm=253&fmt=auto&app=138&f=JPEG?w=551&h=500",
          name: "奇迹",
          desc: "我们做朋友吧！"
        },
        {
          id: 200002,
          icon: 'https://img2.baidu.com/it/u=2043908015,1542611851&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=500',
          name: "刘亦菲",
          desc: "主动加我的..."
        }
      ]
    },
    {
      type: BAAddressBookSectionType.default,
      sectionTitle: 'A',
      items: [
        {
          id: 200003,
          icon: 'https://img2.baidu.com/it/u=3991072649,2204516516&fm=253&fmt=auto&app=138&f=JPEG?w=551&h=500',
          name: "阿猫",
          desc: ""
        },
        {
          id: 200004,
          icon: 'https://img2.baidu.com/it/u=2043908015,1542611851&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=500',
          name: "阿狗",
          desc: "汪汪汪..."
        }
      ]
    },
    {
      type: BAAddressBookSectionType.default,
      sectionTitle: 'B',
      items: [
        {
          id: 200005,
          icon: "https://img2.baidu.com/it/u=3991072649,2204516516&fm=253&fmt=auto&app=138&f=JPEG?w=551&h=500",
          name: "博华",
          desc: ""
        },
        {
          id: 200006,
          icon: 'https://img2.baidu.com/it/u=2043908015,1542611851&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=500',
          name: "柏林",
          desc: ""
        }
      ]
    },
    {
      type: BAAddressBookSectionType.default,
      sectionTitle: 'F',
      items: [
        {
          id: 200007,
          icon: 'https://img2.baidu.com/it/u=3991072649,2204516516&fm=253&fmt=auto&app=138&f=JPEG?w=551&h=500',
          name: "丰田",
          desc: ""
        },
        {
          id: 200008,
          icon: 'https://img2.baidu.com/it/u=2043908015,1542611851&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=500',
          name: "法拉利",
          desc: ""
        },
        {
          id: 200009,
          icon: 'https://img2.baidu.com/it/u=2043908015,1542611851&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=500',
          name: "福特",
          desc: ""
        }
      ]
    }
  ]

  static getIndexDatas(BAAddressBooks?: BAAddressBookModel[]): Array<string> {
    let arrayList: Array<string> = new Array()
    arrayList.push('🔍')

    if (BAAddressBooks) {
      for (let i = 0; i < BAAddressBooks.length; i++) {
        let sectionModel = BAAddressBooks[i]
        if (sectionModel.type == BAAddressBookSectionType.default &&
          !BAStringUtil.isStringEmpty(sectionModel.sectionTitle)) {
          arrayList.push(sectionModel.sectionTitle)
        }
      }
    } else {
      arrayList.push('※')
      let datas = BAAddressBookViewModel.datas
      for (let i = 0; i < datas.length; i++) {
        let sectionModel = datas[i]
        if (sectionModel.type == BAAddressBookSectionType.default &&
          !BAStringUtil.isStringEmpty(sectionModel.sectionTitle)) {
          arrayList.push(sectionModel.sectionTitle)
        }
      }
    }


    return arrayList
  }
}

export interface BAAddressBookModel {
  type: BAAddressBookSectionType
  sectionTitle: string
  items?: BAAddressBookItem[] | undefined
}

export interface BAAddressBookItem {
  id: number
  icon?: string | Resource
  name: string
  desc?: string
}

export const currentUser: BAAddressBookItem = {
  id: 100000,
  icon: 'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fsafe-img.xhscdn.com%2Fbw1%2Fe9543d7c-02f3-484f-a3f0-5bfa8b2e6ef9%3FimageView2%2F2%2Fw%2F1080%2Fformat%2Fjpg&refer=http%3A%2F%2Fsafe-img.xhscdn.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1708069502&t=118303a29ce4a8ef2c1a496ae880b76b',
  name: '奇迹',
  desc: ""
}
// import { JSONArray, JSONObject, JSONUtil } from '@yunkss/eftool'
import { Context } from '@ohos.abilityAccessCtrl';
import { BALogger } from '@ohos/bacommonmodule';
import { JSON, util } from '@kit.ArkTS';
import { BusinessError } from '@kit.BasicServicesKit';
import json from '@ohos.util.json';

export enum BAPyqItemType {
  default = 0,
  ad = 1
}

let jsonPath: string = "data/pyqDataList.json"

export class BAPyqViewModel {
  //code
  static getDataList(context: Context): BAPyqItemModel[] {
    let rawFile: Uint8Array;
    try {
      rawFile = context.resourceManager.getRawFileContentSync(jsonPath)
      let jsonStr: string = util.TextDecoder.create('utf-8', { ignoreBOM: true }).decodeWithStream(rawFile);
      let jsonObj = JSON.parse(jsonStr) as Record<string, Object>
      let result = jsonObj["result"] as number
      if (result == 1) {
        let data: BAPyqItemModel[] = jsonObj["data"] as BAPyqItemModel[]
        return data
      } else {
        return []
      }
    } catch (error) {
      let code = (error as BusinessError).code
      let message = (error as BusinessError).message
      BALogger.error(`ResourceManager:callback getRawFileContent failed, error code: ${code}, message: ${message}.`,
        'BAPyqViewModel');
      return []
    }
  }

  static getDatas: BAPyqItemModel[] = [
    {
      type: BAPyqItemType.default,
      contentId: 100004,
      userIcon: 'https://img2.baidu.com/it/u=3991072649,2204516516&fm=253&fmt=auto&app=138&f=JPEG?w=551&h=500',
      userName: '华为',
      content: "超聚光影像系统结合 XD Motion 运动引擎，捕捉 300 km/h 的超高速运⁠动瞬间⁠4 。\n赛车飞驰，乘风破浪，万⁠千精彩，不论远近，清晰定格。",
      images: undefined,
      video: undefined,
      time: '2024-7-3 9:43:39',
      urlPath: undefined,
      contentSource: undefined,
      comments: [
        {
          contentId: 100004,
          commentId: 1000040001,
          userName: 'vivo',
          content: '以微小，诠释盛大'
        }
      ]
    },
    {
      type: BAPyqItemType.default,
      contentId: 100003,
      userIcon: 'https://img2.baidu.com/it/u=3991072649,2204516516&fm=253&fmt=auto&app=138&f=JPEG?w=551&h=500',
      userName: '杨幂',
      content: "超聚光伸缩摄像头，实力出镜，开启专属仪式感；\n1 英寸大底传感器，超大进光量，捕捉瞬息精彩；\n超聚光微距长⁠焦，F2.1 超大光圈，35x 超级微距⁠1，探索未见之美。",
      images: undefined,
      video: undefined,
      time: '2024-7-3 9:43:39',
      urlPath: undefined,
      contentSource: undefined,
      comments: [
        {
          contentId: 100003,
          commentId: 1000030001,
          userName: '奇迹',
          content: '沙发🛋'
        },
        {
          contentId: 100003,
          commentId: 1000010002,
          userName: '一博',
          content: '创新旋动伸缩镜头结构，每次相机开启，专业机械音随之响起，给你专属仪式感。'
        }
      ]
    },
    {
      type: BAPyqItemType.default,
      contentId: 100002,
      userIcon: 'https://img2.baidu.com/it/u=2043908015,1542611851&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=500',
      userName: '刘亦菲',
      content: "Pura，是一次新生 源自纯粹  生而独特 以大胆想象  探索未见之美 以先锋视角  打开全新视界以独创风格  引领时尚风向\nHUAWEI Pura 追逐本心  锐意向前",
      images: undefined,
      video: undefined,
      time: '2024-6-18 18:38:49',
      urlPath: undefined,
      contentSource: undefined,
      comments: [
        {
          contentId: 100002,
          commentId: 1000020001,
          userName: '一博',
          content: '创新旋动伸缩镜头结构，每次相机开启，专业机械音随之响起，给你专属仪式感。'
        },
        {
          contentId: 100002,
          commentId: 1000020002,
          userName: '杨幂',
          content: '楼上的不要刷屏'
        }
      ]
    },
    {
      type: BAPyqItemType.default,
      contentId: 100001,
      userIcon: "https://img2.baidu.com/it/u=3991072649,2204516516&fm=253&fmt=auto&app=138&f=JPEG?w=551&h=500",
      userName: '奇迹',
      content: "星芒纹，撷漫天星光，于手中绽放；\n高定刺绣压纹工艺，精细雅致，一触倾心。\n全新风向标设计，饰以专属 XMAGE 影像徽标，引领艺术新风向。",
      images: undefined,
      video: undefined,
      time: '2024-6-16 15:26:18',
      urlPath: undefined,
      contentSource: undefined,
      comments: []
    }
  ]
}

export interface BAPyqItemModel {
  type: BAPyqItemType
  contentId: number
  userIcon: Resource | undefined | string
  userName: string | undefined
  content: string
  images: Resource[] | string[] | undefined
  video: Resource | string | undefined
  time: string | undefined
  urlPath: string | undefined
  contentSource: string | undefined
  comments: BAPyqItemCommentModel[]
}

export interface BAPyqItemCommentModel {
  contentId: number
  commentId: number
  userName: string | undefined
  content: string | undefined
}
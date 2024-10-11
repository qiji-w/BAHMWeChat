export interface BAChatInfo {
  text: string
}

export interface BAChatData {
  type: string
  info: BAChatInfo
}

export interface BAChatResult {
  status: number
  message: string
  data: BAChatData
}
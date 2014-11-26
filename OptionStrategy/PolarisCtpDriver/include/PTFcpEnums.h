//
//  PTFcpEnums.h
//  OptionStrategy
//
//  Created by admin on 11/17/14.
//  Copyright (c) 2014 Polaris Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    /// <summary>
    /// 组织机构代码。
    /// </summary>
    OrganizationCode = '0',
    
    /// <summary>
    /// 身份证。
    /// </summary>
    IDCard = '1',
    
    /// <summary>
    /// 军官证。
    /// </summary>
    MilitaryOfficer = '2',
    
    /// <summary>
    /// 警官证。
    /// </summary>
    PoliceOfficer = '3',
    
    /// <summary>
    /// 士兵证。
    /// </summary>
    Soldier = '4',
    
    /// <summary>
    /// 户口本。
    /// </summary>
    HouseholdRegister = '5',
    
    /// <summary>
    /// 护照。
    /// </summary>
    Passport = '6',
    
    /// <summary>
    /// 台胞证。
    /// </summary>
    MTPs = '7',
    
    /// <summary>
    /// 回乡证。
    /// </summary>
    HVPs = '8',
    
    /// <summary>
    /// 营业执照。
    /// </summary>
    BusinessLicense = '9',
    
    /// <summary>
    /// 其它证件。
    /// </summary>
    Other = 'x',
} PTFcpIDCardType;

typedef enum : NSUInteger {
    
    /**
     * 未知。
     */
     PTFcpMarketUnknown = 0,
    
    /**
     * 中国金融交易所。
     */
     PTFcpMarketCFFE = 1,
    
    /**
     * 大连商品交易所。
     */
     PTFcpMarketDCE = 2,
    
    /**
     * 上海期货交易所。
     */
     PTFcpMarketSFE = 4,
    
    /**
     * 郑州商品交易所。
     */
     PTFcpMarketCZCE = 8,
    
    /**
     * 上海证券交易所。
     */
    
     PTFcpMarketSH = 16,
    
    /**
     * 深证证券交易所。
     */
     PTFcpMarketSZ = 32,
} PTFcpMarket;

typedef enum : int {
    /**
     * 做多
     */
PTFcpDirectionLong = 0,
    
    /**
     * 做空
     */
PTFcpDirectionShort = 1,
} PTFcpDirection;

/// 投机套保标志
typedef enum : int {
    
    /// <summary>
    /// 投机
    /// </summary>
    PTFcpHedgeFlagTypeSpeculation = '1',
    
    /// <summary>
    /// 套利
    /// </summary>
    PTFcpHedgeFlagTypeArbitrage = '2',
    
    /// <summary>
    /// 套保
    /// </summary>
    PTFcpHedgeFlagTypeHedge = '3',
    
} PTFcpHedgeFlagType;

typedef enum : int {

    /// <summary>
    /// 所有
    /// </summary>
    PTFcpInvestorRangeTypeAll = '1',
    
    /// <summary>
    /// 投资者组
    /// </summary>
    PTFcpInvestorRangeTypeGroup = '2',
    
    /// <summary>
    /// 单一投资者
    /// </summary>
    PTFcpInvestorRangeTypeSingle = '3'
    
} PTFcpInvestorRangeType;


typedef enum : int {
PTFcpProductClassUnknow = 0,
    /**
     * 期货
     */
PTFcpProductClassFutures = 1,
    
    /**
     * 期货期权
     */
PTFcpProductClassOptions = 2,
    
    /**
     * 组合
     */
PTFcpProductClassCombination = 3,
    
    /**
     * 即期
     */
PTFcpProductClassSpot = 4,
    
    /**
     * 期转现
     */
PTFcpProductClassEFP = 5,
    
    /**
     * 现货期权
     */
PTFcpProductClassSpotOption = 6,
} PTFcpProductClass;


typedef enum : int {
    
    /**
     * 今仓。
     */
PTFcpPositionTypeToday = 0,
    
    /**
     * 昨仓。
     */
PTFcpPositionTypeYestorday = 1,
} PTFcpPositionType;
// PTFcpPositionType

typedef enum : int {
    
    /**
     * 未知
     */
PTFcpOrderStatusUnknown = 0,
    
    /**
     * 未成交
     */
PTFcpOrderStatusNoTraded = 1,
    
    /**
     * 部分撤单
     */
PTFcpOrderStatusPartCanceled = 2,
    
    /**
     * 全部已撤
     */
PTFcpOrderStatusAllCanceled = 3,
    
    /**
     * 部分成交
     */
PTFcpOrderStatusPartTraded = 4,
    
    /**
     * 全部已成交
     */
PTFcpOrderStatusAllTraded = 5,
    
    /**
     * 废单
     */	
PTFcpOrderStatusBlankOrder = 6,
} PTFcpOrderStatus;

typedef enum : int {
    
    /**
     * 买入
     */
PTFcpOrderSideBuy = 0,
    
    /**
     * 卖出
     */
PTFcpOrderSideSell = 1
} PTFcpOrderSide;



typedef enum : int {
    
    // / <summary>
    // / 鏃犳晥鐘舵�銆�
    // / </summary>
PTFcpOrderDriverStateInactive = 0,
    
    // / <summary>
    // / 宸叉柇寮��
    // / </summary>
PTFcpOrderDriverStateDisConnected = 1,
    
    // / <summary>
    // / 杩炴帴涓�
    // / </summary>
PTFcpOrderDriverStateConnecting = 2,
    
    // / <summary>
    // / 宸茶繛鎺ャ�
    // / </summary>
PTFcpOrderDriverStateConnected = 3,
    
    // / <summary>
    // / 鐧诲綍涓�
    // / </summary>
PTFcpOrderDriverStateLoggingOn = 4,
    
    // / <summary>
    // / 宸茬櫥褰�
    // / </summary>
PTFcpOrderDriverStateLoggedOn = 5,
    
    // / <summary>
    // / 鍔犺浇涓�
    // / </summary>
PTFcpOrderDriverStateLoading = 6,
    
    // / <summary>
    // / 鍙敤銆�
    // / </summary>
PTFcpOrderDriverStateReady = 7,
    
    // / <summary>
    // / 鐧诲嚭涓�
    // / </summary>
PTFcpOrderDriverStateLoggingOut = 8,
    
    // / <summary>
    // / 宸茬櫥鍑恒�
    // / </summary>
PTFcpOrderDriverStateLoggedOut = 9,
} PTFcpOrderDriverState;

/// 行情驱动状态枚举
typedef enum : int {
    /// <summary>
    /// 无效状态。
    /// </summary>
    PTFcpQuoteDriverStateInactive = 0,
    
    /// <summary>
    /// 已断开。
    /// </summary>
    PTFcpQuoteDriverStateDisConnected = 1,
    
    /// <summary>
    /// 连接中。
    /// </summary>
    PTFcpQuoteDriverStateConnecting = 2,
    
    /// <summary>
    /// 已连接。
    /// </summary>
    PTFcpQuoteDriverStateConnected = 3,
    
    /// <summary>
    /// 登录中。
    /// </summary>
    PTFcpQuoteDriverStateLoggingOn = 4,
    
    /// <summary>
    /// 已登录
    /// </summary>
    PTFcpQuoteDriverStateLoggedOn = 5,
    
    /// <summary>
    /// 加载中。
    /// </summary>
    PTFcpQuoteDriverStateLoading = 6,
    
    /// <summary>
    /// 可用。
    /// </summary>
    PTFcpQuoteDriverStateReady = 7,
    
    /// <summary>
    /// 登出中。
    /// </summary>
    PTFcpQuoteDriverStateLoggingOut = 8,
    
    /// <summary>
    /// 已登出。
    /// </summary>
    PTFcpQuoteDriverStateLoggedOut = 9,
} PTFcpQuoteDriverState;

typedef enum : int {
    
PTFcpOptionsTypeNone = 0,
    
PTFcpOptionsTypeCall = 1,
    
PTFcpOptionsTypePut = 2,
} PTFcpOptionsType;

typedef enum : int {
    /**
     * 开仓
     */
PTFcpOffsetTypeOpen = 0,
    
    /**
     * 平昨仓
     */
PTFcpOffsetTypeCloseHistory = 1,
    
    /**
     * 平今仓
     */
PTFcpOffsetTypeCloseToday = 2,
    
    /**
     * 平仓
     */	
PTFcpOffsetTypeClose = 3,

} PTFcpOffsetType;








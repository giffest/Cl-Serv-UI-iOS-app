//
//  Group.swift
//  GBVKontakteApp
//
//  Created by Dmitry on 25/08/2019.
//  Copyright © 2019 Dmitry. All rights reserved.
//

import Foundation
import SwiftyJSON

class Group {
    let count: Int
    let id: String
    let name: String
    let avatarUrl: URL?
    
    init(_ json: JSON) {
        self.count = json["count"].intValue
        self.id = json["id"].stringValue
        self.name = json["name"].stringValue
        let photoString = json["photo_50"].stringValue
        self.avatarUrl = URL(string: photoString)
    }
}


//{
//    "response": {
//        "count": 38,
//        "items": [
//        {
//        "id": 1,
//        "name": "ВКонтакте API",
//        "screen_name": "apiclub",
//        "is_closed": 0,
//        "type": "group",
//        "is_admin": 0,
//        "is_member": 1,
//        "is_advertiser": 0,
//        "photo_50": "https://sun9-52.userapi.com/c638629/v638629852/2afc3/ei2DXpoO0h8.jpg?ava=1",
//        "photo_100": "https://sun9-6.userapi.com/c638629/v638629852/2afc2/nlmcXQP0V6c.jpg?ava=1",
//        "photo_200": "https://sun9-23.userapi.com/c638629/v638629852/2afc0/_QdFMmxSRyY.jpg?ava=1"
//        },
//        {
//        "id": 118929911,
//        "name": "Сеть АЗС ЕКА",
//        "screen_name": "azs_eka",
//        "is_closed": 0,
//        "type": "group",
//        "is_admin": 0,
//        "is_member": 1,
//        "is_advertiser": 0,
//        "photo_50": "https://sun1-28.userapi.com/c840129/v840129601/8609b/5G_3I-sSt1E.jpg?ava=1",
//        "photo_100": "https://sun1-18.userapi.com/c840129/v840129601/8609a/qW2yxg-wMZI.jpg?ava=1",
//        "photo_200": "https://sun1-21.userapi.com/c840129/v840129601/86098/TM5-vFM0KEM.jpg?ava=1"
//        },
//        {
//        "id": 123996389,
//        "name": "Команда Сбербанка",
//        "screen_name": "sberbank_team",
//        "is_closed": 1,
//        "type": "group",
//        "is_admin": 0,
//        "is_member": 1,
//        "is_advertiser": 0,
//        "photo_50": "https://sun1-20.userapi.com/c849424/v849424023/152152/MbJqoGgAezs.jpg?ava=1",
//        "photo_100": "https://sun1-19.userapi.com/c849424/v849424023/152151/k4ksACuQcYY.jpg?ava=1",
//        "photo_200": "https://sun1-17.userapi.com/c849424/v849424023/152150/Tn2VA79zRv4.jpg?ava=1"
//        },
//        {
//        "id": 22522055,
//        "name": "Сбербанк",
//        "screen_name": "sberbank",
//        "is_closed": 0,
//        "type": "page",
//        "is_admin": 0,
//        "is_member": 1,
//        "is_advertiser": 0,
//        "photo_50": "https://sun1-26.userapi.com/c855624/v855624601/56aca/Imy8OKnvzqk.jpg?ava=1",
//        "photo_100": "https://sun1-18.userapi.com/c855624/v855624601/56ac9/nmQN5vM2FNM.jpg?ava=1",
//        "photo_200": "https://sun1-17.userapi.com/c855624/v855624601/56ac8/yLbjUjW3XoI.jpg?ava=1"
//        },
//        {
//        "id": 94169305,
//        "name": "Спортивно оздоровительный комплекс \"Солонцово\"",
//        "screen_name": "sok_solontsovo",
//        "is_closed": 0,
//        "type": "group",
//        "is_admin": 0,
//        "is_member": 1,
//        "is_advertiser": 0,
//        "photo_50": "https://sun9-56.userapi.com/c624324/v624324533/45513/kxNIxXabSEY.jpg?ava=1",
//        "photo_100": "https://sun9-12.userapi.com/c624324/v624324533/45512/-E5yJA84xCw.jpg?ava=1",
//        "photo_200": "https://sun9-49.userapi.com/c624324/v624324533/45511/y-D3uPc1338.jpg?ava=1"
//        },
//        {
//        "id": 157369801,
//        "name": "СберКот",
//        "screen_name": "sberkot",
//        "is_closed": 0,
//        "type": "group",
//        "is_admin": 0,
//        "is_member": 1,
//        "is_advertiser": 0,
//        "photo_50": "https://sun1-21.userapi.com/c849024/v849024409/1b3351/M33L1B66khc.jpg?ava=1",
//        "photo_100": "https://sun1-88.userapi.com/c849024/v849024409/1b3350/FN_wDkIQ2xw.jpg?ava=1",
//        "photo_200": "https://sun1-24.userapi.com/c849024/v849024409/1b334f/bK-uifzeDlQ.jpg?ava=1"
//        },
//        {
//        "id": 34001496,
//        "name": "Zaycev.net",
//        "screen_name": "zaycevnet",
//        "is_closed": 0,
//        "type": "page",
//        "is_admin": 0,
//        "is_member": 1,
//        "is_advertiser": 0,
//        "photo_50": "https://sun1-87.userapi.com/c830108/v830108276/bc344/jJlOFYYa4ZE.jpg?ava=1",
//        "photo_100": "https://sun1-24.userapi.com/c830108/v830108276/bc343/80Bz1vHQh2M.jpg?ava=1",
//        "photo_200": "https://sun1-15.userapi.com/c830108/v830108276/bc342/TYmp0Exyo1o.jpg?ava=1"
//        },
//        {
//        "id": 4653,
//        "name": "█████ CIVIC-CLUB RU █████",
//        "screen_name": "civic_club_ru",
//        "is_closed": 1,
//        "type": "group",
//        "is_admin": 0,
//        "is_member": 1,
//        "is_advertiser": 0,
//        "photo_50": "https://sun9-5.userapi.com/c9935/g04653/c_57b51b9c.jpg?ava=1",
//        "photo_100": "https://sun9-5.userapi.com/c9935/g04653/b_98fa8d1f.jpg?ava=1",
//        "photo_200": "https://sun9-5.userapi.com/c9935/g04653/b_98fa8d1f.jpg?ava=1"
//        },
//        {
//        "id": 20845272,
//        "name": "Интересная Москва",
//        "screen_name": "vk_moscow",
//        "is_closed": 0,
//        "type": "page",
//        "is_admin": 0,
//        "is_member": 1,
//        "is_advertiser": 0,
//        "photo_50": "https://sun1-84.userapi.com/c855120/v855120657/687cf/axhSfS99OQA.jpg?ava=1",
//        "photo_100": "https://sun1-14.userapi.com/c855120/v855120657/687ce/geDSVleMDws.jpg?ava=1",
//        "photo_200": "https://sun1-27.userapi.com/c855120/v855120657/687cd/9Bk758oDLA0.jpg?ava=1"
//        },
//        {
//        "id": 54530371,
//        "name": "Библиотека программиста",
//        "screen_name": "proglib",
//        "is_closed": 0,
//        "type": "page",
//        "is_admin": 0,
//        "is_member": 1,
//        "is_advertiser": 0,
//        "photo_50": "https://sun1-15.userapi.com/c855524/v855524662/b44d6/aqmDnoZsF84.jpg?ava=1",
//        "photo_100": "https://sun1-14.userapi.com/c855524/v855524662/b44d5/cQ0CI25yrKU.jpg?ava=1",
//        "photo_200": "https://sun1-16.userapi.com/c855524/v855524662/b44d4/RF4KBR1rgOQ.jpg?ava=1"
//        },
//        {
//        "id": 126015425,
//        "name": "КомуСлона • промокоды ЛитРес, Озон, Book24",
//        "screen_name": "komuslona",
//        "is_closed": 0,
//        "type": "group",
//        "is_admin": 0,
//        "is_member": 1,
//        "is_advertiser": 0,
//        "photo_50": "https://sun1-85.userapi.com/c837327/v837327175/250a6/t1sZosyedNE.jpg?ava=1",
//        "photo_100": "https://sun1-86.userapi.com/c837327/v837327175/250a5/hGg6uggB8xk.jpg?ava=1",
//        "photo_200": "https://sun1-16.userapi.com/c837327/v837327175/250a4/c4vuqN5lS2o.jpg?ava=1"
//        },
//        {
//        "id": 26239991,
//        "name": "Hyundai Russia",
//        "screen_name": "hyundairussia",
//        "is_closed": 0,
//        "type": "group",
//        "is_admin": 0,
//        "is_member": 1,
//        "is_advertiser": 0,
//        "photo_50": "https://sun1-18.userapi.com/c638722/v638722228/4ce00/Jy8JP6NbiRA.jpg?ava=1",
//        "photo_100": "https://sun1-17.userapi.com/c638722/v638722228/4cdff/Q3k_w1Z9FBA.jpg?ava=1",
//        "photo_200": "https://sun1-16.userapi.com/c638722/v638722228/4cdfe/biVeYTYSmQc.jpg?ava=1"
//        },
//        {
//        "id": 44666449,
//        "name": "Банк Открытие",
//        "screen_name": "otkritiecorp",
//        "is_closed": 0,
//        "type": "page",
//        "is_admin": 0,
//        "is_member": 1,
//        "is_advertiser": 0,
//        "photo_50": "https://sun1-28.userapi.com/c845416/v845416463/1144c7/h_UUn2PY6e8.jpg?ava=1",
//        "photo_100": "https://sun1-23.userapi.com/c845416/v845416463/1144c6/ilIr17CoHNs.jpg?ava=1",
//        "photo_200": "https://sun1-87.userapi.com/c845416/v845416463/1144c5/rURhQfWjecw.jpg?ava=1"
//        },
//        {
//        "id": 72503420,
//        "name": "Ford #EXPLORER CLUB №1 | Форд Эксплорер",
//        "screen_name": "explorerford",
//        "is_closed": 0,
//        "type": "page",
//        "is_admin": 0,
//        "is_member": 1,
//        "is_advertiser": 0,
//        "photo_50": "https://sun1-28.userapi.com/c836728/v836728959/4231/VTVj-OHgUFY.jpg?ava=1",
//        "photo_100": "https://sun1-18.userapi.com/c836728/v836728959/4230/RWa0Nztt798.jpg?ava=1",
//        "photo_200": "https://sun1-88.userapi.com/c836728/v836728959/422f/DYGoLsDGRyM.jpg?ava=1"
//        },
//        {
//        "id": 1096659,
//        "name": "рожденные 27 марта",
//        "screen_name": "club1096659",
//        "is_closed": 1,
//        "type": "group",
//        "is_admin": 0,
//        "is_member": 1,
//        "is_advertiser": 0,
//        "photo_50": "https://sun9-48.userapi.com/c637/g1096659/c_f23ba128.jpg?ava=1",
//        "photo_100": "https://sun9-48.userapi.com/c637/g1096659/b_b0b24cca.jpg?ava=1",
//        "photo_200": "https://sun9-48.userapi.com/c637/g1096659/b_b0b24cca.jpg?ava=1"
//        },
//        {
//        "id": 20225241,
//        "name": "Тинькофф",
//        "screen_name": "tinkoffbank",
//        "is_closed": 0,
//        "type": "page",
//        "is_admin": 0,
//        "is_member": 1,
//        "is_advertiser": 0,
//        "photo_50": "https://sun1-15.userapi.com/c846123/v846123269/af97/JZ1TZmGyjVc.jpg?ava=1",
//        "photo_100": "https://sun1-25.userapi.com/c846123/v846123269/af96/RfvFdcEFnVw.jpg?ava=1",
//        "photo_200": "https://sun1-26.userapi.com/c846123/v846123269/af95/IQZ9FX5DCyU.jpg?ava=1"
//        },
//        {
//        "id": 165358325,
//        "name": "Туристический оператор Библио-Глобус",
//        "screen_name": "bgoperatorb2c",
//        "is_closed": 0,
//        "type": "group",
//        "is_admin": 0,
//        "is_member": 1,
//        "is_advertiser": 0,
//        "photo_50": "https://sun1-21.userapi.com/c846221/v846221794/32c8c/HQ_lcX0sT0E.jpg?ava=1",
//        "photo_100": "https://sun1-27.userapi.com/c846221/v846221794/32c8b/p9RKEe6K2p8.jpg?ava=1",
//        "photo_200": "https://sun1-17.userapi.com/c846221/v846221794/32c8a/XJ5NyUD_Gb4.jpg?ava=1"
//        },
//        {
//        "id": 91540518,
//        "name": "Детстрана - современное медиа для родителей",
//        "screen_name": "detstrana_ru",
//        "is_closed": 0,
//        "type": "group",
//        "is_admin": 0,
//        "is_member": 1,
//        "is_advertiser": 0,
//        "photo_50": "https://sun1-26.userapi.com/c846122/v846122928/187fa8/jKO9GPELLbs.jpg?ava=1",
//        "photo_100": "https://sun1-30.userapi.com/c846122/v846122928/187fa7/U-WoJ35VbrM.jpg?ava=1",
//        "photo_200": "https://sun1-84.userapi.com/c846122/v846122928/187fa6/1MG-fzdS1vY.jpg?ava=1"
//        },
//        {
//        "id": 70424161,
//        "name": "Центр крови имени О.К. Гаврилова  ДЗ г.Москвы",
//        "screen_name": "bloodcenter_dzm",
//        "is_closed": 0,
//        "type": "group",
//        "is_admin": 0,
//        "is_member": 1,
//        "is_advertiser": 0,
//        "photo_50": "https://sun1-85.userapi.com/c845217/v845217117/f0e33/QDhpvDMxurY.jpg?ava=1",
//        "photo_100": "https://sun1-89.userapi.com/c845217/v845217117/f0e32/togHL76UOT0.jpg?ava=1",
//        "photo_200": "https://sun1-20.userapi.com/c845217/v845217117/f0e31/-p8mRRbBgBM.jpg?ava=1"
//        },
//        {
//        "id": 53916844,
//        "name": "Декатлон | Decathlon",
//        "screen_name": "decathlon",
//        "is_closed": 0,
//        "type": "page",
//        "is_admin": 0,
//        "is_member": 1,
//        "is_advertiser": 0,
//        "photo_50": "https://sun1-25.userapi.com/c639731/v639731853/f760/EGU0SWdsWVM.jpg?ava=1",
//        "photo_100": "https://sun1-89.userapi.com/c639731/v639731853/f75f/5xgOumo4Xnw.jpg?ava=1",
//        "photo_200": "https://sun1-19.userapi.com/c639731/v639731853/f75e/yRKJThOCuUs.jpg?ava=1"
//        },
//        {
//        "id": 28144147,
//        "name": "Автошторки Laitovo, шторки на авто каркасные",
//        "screen_name": "newlaitovo",
//        "is_closed": 0,
//        "type": "group",
//        "is_admin": 0,
//        "is_member": 1,
//        "is_advertiser": 0,
//        "photo_50": "https://sun1-86.userapi.com/c631423/v631423053/df9c/8OIZfsWSFo8.jpg?ava=1",
//        "photo_100": "https://sun1-30.userapi.com/c631423/v631423053/df9b/UekTxXpYDV8.jpg?ava=1",
//        "photo_200": "https://sun1-26.userapi.com/c631423/v631423053/df9a/J84dV2VTRpk.jpg?ava=1"
//        },
//        {
//        "id": 26881076,
//        "name": "Банк Русский Стандарт",
//        "screen_name": "rsb",
//        "is_closed": 0,
//        "type": "page",
//        "is_admin": 0,
//        "is_member": 1,
//        "is_advertiser": 0,
//        "photo_50": "https://sun1-29.userapi.com/c850636/v850636812/165733/yJHDl1pXCXU.jpg?ava=1",
//        "photo_100": "https://sun1-88.userapi.com/c850636/v850636812/165732/Pm7inibR_tU.jpg?ava=1",
//        "photo_200": "https://sun1-27.userapi.com/c850636/v850636812/165731/-1QL0naAVg0.jpg?ava=1"
//        },
//        {
//        "id": 1545696,
//        "name": "►►►Школа_№12_г.Абакан◄◄◄ ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄",
//        "screen_name": "abakan_12",
//        "is_closed": 0,
//        "type": "group",
//        "is_admin": 0,
//        "is_member": 1,
//        "is_advertiser": 0,
//        "photo_50": "https://sun9-33.userapi.com/c1213/g1545696/c_1fb2d1db.jpg?ava=1",
//        "photo_100": "https://sun9-33.userapi.com/c1213/g1545696/b_7ee978cc.jpg?ava=1",
//        "photo_200": "https://sun9-33.userapi.com/c1213/g1545696/b_7ee978cc.jpg?ava=1"
//        },
//        {
//        "id": 144637872,
//        "name": "День открытых перспектив",
//        "screen_name": "open_persp_day",
//        "is_closed": 0,
//        "type": "group",
//        "is_admin": 0,
//        "is_member": 1,
//        "is_advertiser": 0,
//        "photo_50": "https://sun9-39.userapi.com/c847123/v847123509/1d28a7/oAsdY5sobnA.jpg?ava=1",
//        "photo_100": "https://sun9-47.userapi.com/c847123/v847123509/1d28a6/LUYHv8gXAIo.jpg?ava=1",
//        "photo_200": "https://sun9-33.userapi.com/c847123/v847123509/1d28a5/I8sV_wQwMkQ.jpg?ava=1"
//        },
//        {
//        "id": 64980878,
//        "name": "Telegram News",
//        "screen_name": "tnews",
//        "is_closed": 0,
//        "type": "page",
//        "is_admin": 0,
//        "is_member": 1,
//        "is_advertiser": 0,
//        "photo_50": "https://sun1-85.userapi.com/c629121/v629121510/29d89/tAYCCpudTsA.jpg?ava=1",
//        "photo_100": "https://sun1-28.userapi.com/c629121/v629121510/29d88/tYQgtU3GsME.jpg?ava=1",
//        "photo_200": "https://sun1-24.userapi.com/c629121/v629121510/29d87/34e5FGQVKiM.jpg?ava=1"
//        },
//        {
//        "id": 28775,
//        "name": "ФТФ-НГТУ",
//        "screen_name": "club28775",
//        "is_closed": 0,
//        "type": "group",
//        "is_admin": 0,
//        "is_member": 1,
//        "is_advertiser": 0,
//        "photo_50": "https://sun9-19.userapi.com/c848528/v848528584/1d565a/4_iCJe91Nfo.jpg?ava=1",
//        "photo_100": "https://sun9-37.userapi.com/c848528/v848528584/1d5659/vatadieIXgQ.jpg?ava=1",
//        "photo_200": "https://sun9-26.userapi.com/c848528/v848528584/1d5658/5MOr7vq8emU.jpg?ava=1"
//        },
//        {
//        "id": 306868,
//        "name": "======================== БАНКИ РОССИИ ==========",
//        "screen_name": "banksofrussia",
//        "is_closed": 0,
//        "type": "group",
//        "is_admin": 0,
//        "is_member": 1,
//        "is_advertiser": 0,
//        "photo_50": "https://sun9-27.userapi.com/c1537/g306868/c_22ccc1d8.jpg?ava=1",
//        "photo_100": "https://sun9-27.userapi.com/c1537/g306868/b_9909b636.jpg?ava=1",
//        "photo_200": "https://sun9-27.userapi.com/c1537/g306868/b_9909b636.jpg?ava=1"
//        },
//        {
//        "id": 9256,
//        "name": "Студенты Новосибирска",
//        "screen_name": "stud_nsk",
//        "is_closed": 0,
//        "type": "group",
//        "is_admin": 0,
//        "is_member": 1,
//        "is_advertiser": 0,
//        "photo_50": "https://sun1-21.userapi.com/c604628/v604628180/1b1dc/kuM558E4BiU.jpg?ava=1",
//        "photo_100": "https://sun1-30.userapi.com/c604628/v604628180/1b1db/97f75HCezIc.jpg?ava=1",
//        "photo_200": "https://sun1-84.userapi.com/c604628/v604628180/1b1d9/FFZ7k3kgeRI.jpg?ava=1"
//        },
//        {
//        "id": 28502218,
//        "name": "Ford Explorer",
//        "screen_name": "club28502218",
//        "is_closed": 0,
//        "type": "group",
//        "is_admin": 0,
//        "is_member": 1,
//        "is_advertiser": 0,
//        "photo_50": "https://sun1-19.userapi.com/c837432/v837432315/1ddd5/Uz1AuWWNuTA.jpg?ava=1",
//        "photo_100": "https://sun1-85.userapi.com/c837432/v837432315/1ddd4/NUGvmnCcmRs.jpg?ava=1",
//        "photo_200": "https://sun1-89.userapi.com/c837432/v837432315/1ddd3/6sx9KSz0p3M.jpg?ava=1"
//        },
//        {
//        "id": 37131732,
//        "name": "ПСБ",
//        "screen_name": "psbank_ru",
//        "is_closed": 0,
//        "type": "page",
//        "is_admin": 0,
//        "is_member": 1,
//        "is_advertiser": 0,
//        "photo_50": "https://sun1-88.userapi.com/c851232/v851232498/149deb/eYgq7XkeqFQ.jpg?ava=1",
//        "photo_100": "https://sun1-83.userapi.com/c851232/v851232498/149dea/a0fK_BYQDho.jpg?ava=1",
//        "photo_200": "https://sun1-20.userapi.com/c851232/v851232498/149de9/-aDFmkyl72w.jpg?ava=1"
//        },
//        {
//        "id": 21434998,
//        "name": "Фотокниги Нетпринт (netPrint.ru)",
//        "screen_name": "netprint_ru",
//        "is_closed": 0,
//        "type": "page",
//        "is_admin": 0,
//        "is_member": 1,
//        "is_advertiser": 0,
//        "photo_50": "https://sun1-83.userapi.com/c840130/v840130471/601d7/0keKs8Hdl7Q.jpg?ava=1",
//        "photo_100": "https://sun1-85.userapi.com/c840130/v840130471/601d6/Of__5RXQSuQ.jpg?ava=1",
//        "photo_200": "https://sun1-85.userapi.com/c840130/v840130471/601d4/ybPiGHJzD6o.jpg?ava=1"
//        },
//        {
//        "id": 22749457,
//        "name": "Банк ВТБ",
//        "screen_name": "vtb",
//        "is_closed": 0,
//        "type": "group",
//        "is_admin": 0,
//        "is_member": 1,
//        "is_advertiser": 0,
//        "photo_50": "https://sun1-27.userapi.com/c849328/v849328717/9d657/qRVJDWVwSfg.jpg?ava=1",
//        "photo_100": "https://sun1-87.userapi.com/c849328/v849328717/9d656/selEPGprdxY.jpg?ava=1",
//        "photo_200": "https://sun1-87.userapi.com/c849328/v849328717/9d655/02qVYZFYl4U.jpg?ava=1"
//        },
//        {
//        "id": 98648430,
//        "name": "Московский кредитный банк",
//        "screen_name": "bankmkb",
//        "is_closed": 0,
//        "type": "page",
//        "is_admin": 0,
//        "is_member": 1,
//        "is_advertiser": 0,
//        "photo_50": "https://sun1-28.userapi.com/c850216/v850216718/15c3cc/uhkgb1LJPoc.jpg?ava=1",
//        "photo_100": "https://sun1-16.userapi.com/c850216/v850216718/15c3cb/fjYkPEJhR5M.jpg?ava=1",
//        "photo_200": "https://sun1-23.userapi.com/c850216/v850216718/15c3ca/1zEqvXsdQF4.jpg?ava=1"
//        },
//        {
//        "id": 34849764,
//        "name": "Visa в России",
//        "screen_name": "visarussia",
//        "is_closed": 0,
//        "type": "group",
//        "is_admin": 0,
//        "is_member": 1,
//        "is_advertiser": 0,
//        "photo_50": "https://sun1-21.userapi.com/c837236/v837236781/699e2/x5oW_cHG2Cs.jpg?ava=1",
//        "photo_100": "https://sun1-27.userapi.com/c837236/v837236781/699e1/9KjdOricd10.jpg?ava=1",
//        "photo_200": "https://sun1-17.userapi.com/c837236/v837236781/699e0/TJqOi93prXg.jpg?ava=1"
//        },
//        {
//        "id": 157415,
//        "name": "Банк \"Возрождение\" (ОАО)",
//        "screen_name": "club157415",
//        "is_closed": 1,
//        "type": "group",
//        "is_admin": 0,
//        "is_member": 1,
//        "is_advertiser": 0,
//        "photo_50": "https://sun9-46.userapi.com/c40/g157415/c_0b8186b.jpg?ava=1",
//        "photo_100": "https://sun9-46.userapi.com/c40/g157415/b_0b8186b.jpg?ava=1",
//        "photo_200": "https://sun9-46.userapi.com/c40/g157415/b_0b8186b.jpg?ava=1"
//        },
//        {
//        "id": 6176,
//        "name": "По Новосибу!",
//        "screen_name": "ponovosibu",
//        "is_closed": 0,
//        "type": "group",
//        "is_admin": 0,
//        "is_member": 1,
//        "is_advertiser": 0,
//        "photo_50": "https://sun1-83.userapi.com/c630718/v630718870/40f45/rGKuHGoUvSM.jpg?ava=1",
//        "photo_100": "https://sun1-20.userapi.com/c630718/v630718870/40f44/_uN-mdop4w4.jpg?ava=1",
//        "photo_200": "https://sun1-19.userapi.com/c630718/v630718870/40f43/q3gmFrofv9c.jpg?ava=1"
//        },
//        {
//        "id": 143433,
//        "name": "Новосибирск",
//        "screen_name": "club143433",
//        "is_closed": 0,
//        "type": "group",
//        "is_admin": 0,
//        "is_member": 1,
//        "is_advertiser": 0,
//        "photo_50": "https://sun9-6.userapi.com/c39/g143433/c_9753dbd.jpg?ava=1",
//        "photo_100": "https://sun9-6.userapi.com/c39/g143433/b_9753dbd.jpg?ava=1",
//        "photo_200": "https://sun9-6.userapi.com/c39/g143433/b_9753dbd.jpg?ava=1"
//        },
//        {
//        "id": 128322,
//        "name": "Милости",
//        "screen_name": "ukgcity",
//        "is_closed": 0,
//        "type": "group",
//        "is_admin": 0,
//        "is_member": 1,
//        "is_advertiser": 0,
//        "photo_50": "https://sun1-21.userapi.com/c851328/v851328509/7b8a/BdtG5GxIGvw.jpg?ava=1",
//        "photo_100": "https://sun1-85.userapi.com/c851328/v851328509/7b89/L32ijuzQQLY.jpg?ava=1",
//        "photo_200": "https://sun1-84.userapi.com/c851328/v851328509/7b88/2snt3i2AYL8.jpg?ava=1"
//        }
//        ]
//    }
//}

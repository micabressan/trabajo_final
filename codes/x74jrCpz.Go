package main

import (
	"fmt"
	"generais/app/type/DataBaseType"
	_ "github.com/go-sql-driver/mysql"
	"github.com/jinzhu/gorm"
	"github.com/julienschmidt/httprouter"
	_ "github.com/lib/pq"
	_ "github.com/mattn/go-sqlite3"
	"log"
	"net/http"
)

/*
Мы создадим глобальную переменную db для конекта с бд.
Потом в main создадим конект и передадим его переменной db
Все функции что вызиваються в роутере сохраняем в этом файле.
С них передаём данные в функции модулей.
*/

//обьявление глобаьной переменной
var db gorm.DB

//обработчики роутов.

func Auth(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {
	UserLogin := ps.ByName("login")
	KeyApi := ps.ByName("keyApi")
	HashHttp := ps.ByName("hash")
	fmt.Fprintf(w, "hello, %s! Твой ключ апи %s Хеш запроса %s \n", UserLogin, KeyApi, HashHttp)
}
func BattlesInvasion(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}

func BattlesInvasionNew(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}

func BattlesSanction(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}

func BattlesSanctionNew(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}

func BattlesSanctionNewProtectorate(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}

func BattlesSanctionNewLegion(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}

func Battleground(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}

func BattlegroundDispley(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}

func BattlegroundChangeRole(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}

func BattlegroundStart(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}

func BattlegroundReady(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}

func BattlegroundDeseration(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}

func BattlegroundAttak(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}

func BattlegroundHospital(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}

func BattlegroundDefeense(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}

func MissionsLocation(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}

func MissionsLocationId(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}

func MissionsLocationOk(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}

func MissionHq(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}

func MissionOk(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}

func MissionDelete(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}

func MissionMany(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}

func UnitsGround(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}

func UnitsMarine(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}

func UnitsAviation(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}

func UnitsUnique(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}

func BlackmarketMercenaries(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}

func BlackmarketMercenariesNew(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}

func BlackmarketSaboteursNewDiver(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}

func BlackmarketSaboteursNewKazarm(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}

func BlackmarketLaboratory(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}

func BlackmarketLaboratoryNew(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}

func BlackmarketContraband(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}

func BlackmarketContrabandNew(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}

func BlackmarketDocuments(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}

func BlackmarketDocumentsUpdate(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}

func BlackmarketAuction(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}

func BlackmarketAuctionUpdate(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}

func ManufacturingFactory(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}

func ManufacturingEvolve(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}

func ManufacturingNewEvolve(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}

func ManufacturingNew(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}

func ManufacturingMines(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}

func ManufacturingMinesSp(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}

func ManufacturingMinesTerorAttak(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}
func ManufacturingMinesSpContinue(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}
func ManufacturingMinesNew(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}
func BuildingsProfitable(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}
func BuildingsProfitableNew(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}
func BuildingsDefense(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}
func BuildingsDefenseNew(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}
func BuildingsEnergy(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}
func BuildingsEnergyNew(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}
func OfficerscResling(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}
func OfficerscRoulette(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}
func OfficerscSpyInterrogation(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}
func OfficerscVeteransRiddle(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}
func OfficerscWallNewspaper(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}
func ProfileInfo(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}
func ProfileInfoId(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}
func ProfileSkills(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}
func ProfileAchievements(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}
func ProfileProperty(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}
func ProfileBooty(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}
func ProfileGifts(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}
func ProfileVipMode(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}
func ProfileStatistic(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}
func HalloffameRating(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}
func HalloffameStatistic(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}
func HalloffameHeroes(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}
func HalloffameLegions(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}
func AllianceIndex(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}
func AllianceRequests(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}
func AllianceReferrals(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}
func AllianceReinforcement(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}
func AllianceUnderDefense(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}
func ChatPublic(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}
func ChatAlliance(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}
func ChatLegions(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}
func ChatBootcamp(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}
func BankStorage(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}
func BankGold(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}
func BankСredit(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}
func BankExchanger(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}
func MailIndex(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}
func MailWrite(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}
func MailContacts(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}
func MailIgnore(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}
func News(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}
func NewsAddCommen(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}
func dailyBonus(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}

func SystemMigration(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {
	//db.CreateTable(&DataBaseType.UserPassport{})
	db.Set("gorm:table_options", "ENGINE=InnoDB").CreateTable(&DataBaseType.UserPassport{})
	db.Set("gorm:table_options", "ENGINE=MyISAM").CreateTable(&DataBaseType.UseApi{})
}

func UserAuthViews(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}
func UserSekurity(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}
func UserAuth(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}

func UserRegistration(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}

func BlackmarketSaboteurs(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {

}

//магазин техники

//точка входа
func main() {
	//Конектим с бд
	dbConnect, err := gorm.Open("mysql", "root:parsh888@/generais?charset=utf8&parseTime=True&loc=Local")
	dbConnect.DB()
	dbConnect.DB().Ping()
	dbConnect.DB().SetMaxIdleConns(10)
	dbConnect.DB().SetMaxOpenConns(100)
	dbConnect.SingularTable(true)
	//проверяем ошибки
	if err != nil {
		log.Fatal(err)
	}
	//ошибок нет. Делаем конект глобальным.
	db = dbConnect

	//Создаём экземпляр оутера
	router := httprouter.New()

	//Авторизация, регистрация, доступ//
	router.GET("/auth/:keyApi/:login/:hash", UserAuthViews)
	router.GET("/sekurity/:keyAPI", UserSekurity)
	router.POST("/auth/", UserAuth)
	router.POST("/registration", UserRegistration)
	//Война//
	router.GET("/Battles/Invasion/:keyApi/:token/:hash", BattlesInvasion)
	router.POST("/Battles/Invasion/new/:keyApi/:token/:hash", BattlesInvasionNew)
	router.GET("/Battles/Sanctions/:keyApi/:token/:hash", BattlesSanction)
	router.POST("/Battles/Sanctions/new/:keyApi/:token/:hash", BattlesSanctionNew)
	router.POST("/Battles/Sanction/newProtectorate", BattlesSanctionNewProtectorate)
	router.POST("/Battles/Sanction/newLegion", BattlesSanctionNewLegion)
	/******************************Груповые бои****************************************/
	router.GET("/battleground/:keyApi/:token/:hash", Battleground)
	router.GET("/battleground/main/:keyApi/:token/:hash", BattlegroundDispley)
	router.GET("/battleground/changeRole/:role/:keyApi/:token/:hash", BattlegroundChangeRole)
	router.GET("/battleground/start/:keyApi/:token/:hash", BattlegroundStart)
	router.GET("/battleground/ready/:keyApi/:token/:hash", BattlegroundReady)
	router.GET("/battleground/deseration/:keyApi/:token/:hash", BattlegroundDeseration)
	router.GET("/battleground/attak/:user_attak/:keyApi/:token/:hash", BattlegroundAttak)
	router.GET("/battleground/defense/:user_hospital/:keyApi/:token/:hash", BattlegroundHospital)
	router.GET("/battleground/defense/:user_defense/:keyApi/:token/:hash", BattlegroundDefeense)
	//Мисии//
	router.GET("/Missions/location/:keyApi/:token/:hash", MissionsLocation)
	router.GET("/Missions/location/:id/:keyApi/:token/:hash", MissionsLocationId)
	router.GET("/Missions/location/:id_location/:id_missions/:keyApi/:token/:hash", MissionsLocationOk)
	router.GET("/Missions/hq/:keyApi/:token/:hash", MissionHq)
	router.GET("/Missions/hq/ok/:hqId/:keyApi/:token/:hash", MissionOk)
	router.GET("/Missions/hq/delete/:hqID/:keyApi/:token/:hash", MissionDelete)
	router.GET("/Missions/hq/many/:hqID/:keyApi/:token/:hash", MissionMany)
	//Магазин техники//
	router.GET("/units/index/ground/:page/:keyApi/:token/:hash", UnitsGround)
	router.GET("/units/index/marine/:page/:keyApi/:token/:hash", UnitsMarine)
	router.GET("/units/index/aviation/:page/:keyApi/:token/:hash", UnitsAviation)
	router.GET("/units/index/unique/:page/:keyApi/:token/:hash", UnitsUnique)
	//Чёрный рынок//
	router.GET("/Blackmarket/Mercenaries/:keyApi/:token/:hash", BlackmarketMercenaries)
	router.GET("/Blackmarket/Mercenaries/:id/:time/:keyApi/:token/:hash", BlackmarketMercenariesNew) //
	router.GET("/Blackmarket/Saboteurs/:keyApi/:token/:hash", BlackmarketSaboteurs)
	router.GET("/Blackmarket/Saboteurs/newDiver/:diverId/:keyApi/:token/:hash", BlackmarketSaboteursNewDiver)
	router.GET("/Blackmarket/Saboteurs/newKazarm/:diverId/:keyApi/:token/:hash", BlackmarketSaboteursNewKazarm)
	router.GET("/Blackmarket/Laboratory/:keyApi/:token/:hash", BlackmarketLaboratory)
	router.GET("/Blackmarket/Laboratory/:id/:time/:keyApi/:token/:hash", BlackmarketLaboratoryNew)
	router.GET("/Blackmarket/Contraband/:keyApi/:token/:hash", BlackmarketContraband)
	router.GET("/Blackmarket/Contraband/:id/:keyApi/:token/:hash", BlackmarketContrabandNew)
	router.GET("/Blackmarket/Documents/:keyApi/:token/:hash", BlackmarketDocuments)
	router.GET("/Blackmarket/Documents/:ava/:flags/:keyApi/:token/:hash", BlackmarketDocumentsUpdate)
	router.GET("/Blackmarket/Auction/:keyApi/:token/:hash", BlackmarketAuction)
	router.GET("/Blackmarket/Auction/:gold/:keyApi/:token/:hash", BlackmarketAuctionUpdate)
	//Производство//
	router.GET("/Manufacturing/Factory/:keyApi/:token/:hash", ManufacturingFactory)
	router.GET("/Manufacturing/Factory/evolve/:keyApi/:token/:hash", ManufacturingEvolve)
	router.GET("/Manufacturing/Factory/NewEvolve/:units/:keyApi/:token/:hash", ManufacturingNewEvolve)
	router.GET("/Manufacturing/Factory/New/:keyApi/:token/:hash", ManufacturingNew)
	router.GET("/Manufacturing/Mines/:keyApi/:token/:hash", ManufacturingMines)
	router.GET("/Manufacturing/Mines/Sp/:keyApi/:token/:hash", ManufacturingMinesSp)
	router.GET("/Manufacturing/Mines/TerorAttak/:keyApi/:token/:hash", ManufacturingMinesTerorAttak)
	router.GET("/Manufacturing/Mines/SpContinue/:keyApi/:token/:hash", ManufacturingMinesSpContinue)
	router.GET("/Manufacturing/Mines/new/:keyApi/:token/:hash", ManufacturingMinesNew)
	//Постройки//
	router.GET("/Buildings/Profitable/:keyApi/:token/:hash", BuildingsProfitable)
	router.GET("/Buildings/Profitable/:id/:keyApi/:token/:hash", BuildingsProfitableNew)
	router.GET("/Buildings/Defense/:keyApi/:token/:hash", BuildingsDefense)
	router.GET("/Buildings/Defense/:id/:keyApi/:token/:hash", BuildingsDefenseNew)
	router.GET("/Buildings/Energy/:keyApi/:token/:hash", BuildingsEnergy)
	router.GET("/Buildings/Energy/:id/:keyApi/:token/:hash", BuildingsEnergyNew)
	//Клуб офицеров//
	router.GET("Officerscclub/Resling/:keyApi/:token/:hash", OfficerscResling)
	router.GET("Officerscclub/Roulette/:keyApi/:token/:hash", OfficerscRoulette)
	router.GET("Officerscclub/SpyInterrogation/:keyApi/:token/:hash", OfficerscSpyInterrogation)
	router.GET("Officerscclub/VeteransRiddle/:keyApi/:token/:hash", OfficerscVeteransRiddle)
	router.GET("Officerscclub/WallNewspaper/:keyApi/:token/:hash", OfficerscWallNewspaper)
	//Профиль//
	router.GET("/Profile/Info/:keyApi/:token/:hash", ProfileInfo)
	router.GET("/Profile/Info/:id/:keyApi/:token/:hash", ProfileInfoId)
	router.GET("/Profile/Skills/:keyApi/:token/:hash", ProfileSkills)
	router.GET("/Profile/Achievements/:keyApi/:token/:hash", ProfileAchievements)
	router.GET("/Profile/Property/:keyApi/:token/:hash", ProfileProperty)
	router.GET("/Profile/Booty/:keyApi/:token/:hash", ProfileBooty)
	router.GET("/Profile/Gifts/:keyApi/:token/:hash", ProfileGifts)
	router.GET("/Profile/VipMode/:keyApi/:token/:hash", ProfileVipMode)
	router.GET("/Profile/Statistic/:keyApi/:token/:hash", ProfileStatistic)
	//Зал славы//
	router.GET("/Halloffame/Rating/:keyApi/:token/:hash", HalloffameRating)
	router.GET("/Halloffame/Statistic/:keyApi/:token/:hash", HalloffameStatistic)
	router.GET("/Halloffame/Heroes/:keyApi/:token/:hash", HalloffameHeroes)
	router.GET("/Halloffame/Legions/:keyApi/:token/:hash", HalloffameLegions)
	//Альянс//
	router.GET("/Alliance/Index/:keyApi/:token/:hash", AllianceIndex)
	router.GET("/Alliance/Requests/:keyApi/:token/:hash", AllianceRequests)
	router.GET("/Alliance/Referrals/:keyApi/:token/:hash", AllianceReferrals)
	router.GET("/Alliance/Reinforcement/:keyApi/:token/:hash", AllianceReinforcement)
	router.GET("/Alliance/UnderDefense/:keyApi/:token/:hash", AllianceUnderDefense)
	//Чаты//
	router.GET("/Chat/Public/:keyApi/:token/:hash", ChatPublic)
	router.GET("/Chat/Alliance/:keyApi/:token/:hash", ChatAlliance)
	router.GET("/Chat/Legions/:keyApi/:token/:hash", ChatLegions)
	router.GET("/Chat/Bootcamp/:keyApi/:token/:hash", ChatBootcamp)
	//Банк//
	router.GET("/Bank/Storage/:keyApi/:token/:hash", BankStorage)
	router.GET("/Bank/Gold/:keyApi/:token/:hash", BankGold)
	router.GET("/Bank/Сredit/:keyApi/:token/:hash", BankСredit)
	router.GET("/Bank/Exchanger/:keyApi/:token/:hash", BankExchanger)
	//Почта//
	router.GET("/Mail/Index/:keyApi/:token/:hash", MailIndex)
	router.GET("/Mail/Write/:keyApi/:token/:hash", MailWrite)
	router.GET("/Mail/Contacts/:keyApi/:token/:hash", MailContacts)
	router.GET("/Mail/Ignore/:keyApi/:token/:hash", MailIgnore)
	//Новости//
	router.GET("/News/:keyApi/:token/:hash", News)
	router.GET("/News/AddCommen/:keyApi/:token/:hash", NewsAddCommen)
	//Ежедневный бонус//
	router.GET("/dailyBonus/:keyApi/:token/:hash", dailyBonus)
	//Системные вызовы//
	router.GET("/system/migration", SystemMigration)

	//стартуем сервер на 8080 порту.
	log.Fatal(http.ListenAndServe(":8080", router))
}
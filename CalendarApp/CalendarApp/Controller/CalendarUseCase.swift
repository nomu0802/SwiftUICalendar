import Foundation

//現在の年月を取得する
func getYM() -> (year:Int,month:Int){
    let current = Calendar.current
    let year = current.component(.year, from: Date())
    let month = current.component(.month, from: Date())
    
    
    return(year,month)
}

//月初の曜日を計算
func dayOfWeek(_ year: Int, _ month: Int) -> Int {
    var year = year
    var month = month
    if month == 1 || month == 2 {
        year -= 1
        month += 12
    }
    return zellerCongruence(year, month, 1)
}
let zellerCongruence = { (year: Int, month: Int, day: Int) in (year + year/4 - year/100 + year/400 + (13 * month + 8)/5 + day) % 7 }

//月の日数を取得する
func getDayCnt(year:Int,month:Int) -> Int{
    
    let calendar = Calendar(identifier: .gregorian)
    var components = DateComponents()
    components.year = year
    // 日数を求めたい次の月。13になってもOK。ドキュメントにも、月もしくは月数とある
    components.month = month + 1
    // 日数を0にすることで、前の月の最後の日になる
    components.day = 0
    // 求めたい月の最後の日のDateオブジェクトを得る
    let date = calendar.date(from: components)!
    let dayCnt = calendar.component(.day, from: date)
    
    return(dayCnt)
}

//閏年の判定
let isLeapYear = { (year: Int) in year % 400 == 0 || (year % 4 == 0 && year % 100 != 0) }

//週の数の判定
func numberOfWeeks(_ year: Int, _ month: Int) -> Int {
    if conditionFourWeeks(year, month) {
        return 4
    } else if conditionSixWeeks(year, month) {
        return 6
    } else {
        return 5
    }
}
//週が4つの場合
func conditionFourWeeks(_ year: Int, _ month: Int) -> Bool {
    let firstDayOfWeek = dayOfWeek(year, month)
    return !isLeapYear(year) && month == 2 && (firstDayOfWeek == 0)
}
//週が6つの場合
func conditionSixWeeks(_ year: Int, _ month: Int) -> Bool {
    let firstDayOfWeek = dayOfWeek(year, month)
    let days = getDayCnt(year: year, month: month)
    return (firstDayOfWeek == 6 && days == 30) || (firstDayOfWeek >= 5 && days == 31)
}



//月の計算
func ymCalculation(dayCnt:Int) -> (year:Int,month:Int){
    
    let day = Date()
    let modifiedDate = Calendar.current.date(byAdding: .month, value: dayCnt, to: day)!
    let current = Calendar.current
    let year = current.component(.year, from: modifiedDate)
    let month = current.component(.month, from: modifiedDate)
    
    
    return(year,month)
    
}

//配列の作成
func setWeakDay(weekCnt:Int,dayOffSet:Int,lastDay:Int) -> [[Int]]{
    var dayCnt:Int = 0
    var dayFlag = false
    var weekList = [[Int]]()
    
    for i in 0..<weekCnt {
        var dayList = [Int]()
        for j in 0..<7{
            if(i == 0 && dayCnt == 0){
                
                if(j == dayOffSet){
                    dayCnt += 1
                }
            }else if(dayCnt >= lastDay ){
                dayCnt = 0
                dayFlag = true
                
            }
            else{
                dayCnt += 1
            }
            
            if(dayFlag){
                dayCnt = 0
            }
            dayList.append(dayCnt)
        }
        weekList.append(dayList)
    }
    return(weekList)
}

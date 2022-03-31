import SwiftUI

struct CalendarViewController: View {
    @State var calendarList = [[Int]]()
    @Binding var monthCnt:Int
    var body: some View {
        VStack{
            let YM = ymCalculation(dayCnt: monthCnt)
            
            
            let firstday = dayOfWeek(YM.year, YM.month)
            let weekCnt = numberOfWeeks(YM.year,YM.month)
            
            //月末日取得
            let lastDay = getDayCnt(year: YM.year, month: YM.month)
            
            let test = setWeakDay(weekCnt: weekCnt+1, dayOffSet: firstday, lastDay: lastDay)
            
            let title = String(YM.year) + "年" + String(YM.month)+"月"
            Text(title)
            
            HStack{
                CalendarCell(dayCell: .constant("日"))
                CalendarCell(dayCell: .constant("月"))
                CalendarCell(dayCell: .constant("火"))
                CalendarCell(dayCell: .constant("水"))
                CalendarCell(dayCell: .constant("木"))
                CalendarCell(dayCell: .constant("金"))
                CalendarCell(dayCell: .constant("土"))
            }
            
            ForEach(0..<weekCnt+1) { num in
                HStack{
                    ForEach(0..<7){row in
                        
                        
                        
                        CalendarCell(dayCell: .constant( String(test[num][row])))
                        
                        
                    }
                }
                
            }
        }
    }
}

struct CalendarViewController_Previews: PreviewProvider {
    static var previews: some View {
        CalendarViewController(monthCnt: .constant(0))
    }
}
